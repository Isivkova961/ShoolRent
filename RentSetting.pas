unit RentSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons, Mask, DateUtils, ComCtrls,
  ToolEdit, ImgList, LoadSetting;

type
  TfRentSetting = class(TForm)
    pButton: TPanel;
    pMessage: TPanel;
    sbSave: TSpeedButton;
    spAdd: TSpeedButton;
    sbDelete: TSpeedButton;
    lMessage: TLabel;
    iMessage: TImage;
    sbData: TScrollBox;
    procedure FormCreate(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure sbAddClick(Sender: TObject);
    procedure CreateNew;
    procedure LoadDayWeek;  //Загрузка данных по дням недели
    procedure AddNew;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean); //Добавить компоненты для описания
    
  private
    procedure SpeedButClick(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

const
  AllKol = 50;

var
  fRentSetting: TfRentSetting;
  Number: integer;
  Weeks: TStringList;

  //Создание компонент для создания расписания
  Comb: array [1..AllKol] of TComboBox;
  Mask1, Mask2, Mask3: array [1..AllKol] of TMaskEdit;
  DateEd: array [1..AllKol] of TDateEdit;
  Lab1, Lab2, Lab3: array [1..AllKol] of TLabel;
  SpeedBut: array [1..AllKol] of TSpeedButton;

implementation

uses RentMain;

{$R *.dfm}

procedure TfRentSetting.FormCreate(Sender: TObject);
var
  i: integer;
  s: string;
begin
  LoadDayWeek; //Создаем список дней недель
  LoadSet;     //Загружаем настройки из файла

  Number := 0;

  for i := 0 to WeekSetting[1].Count - 1 do
    begin
      AddNew;

      Comb[Number].ItemIndex := Comb[Number].Items.IndexOf(WeekSetting[1][i]);

      s := WeekSetting[2][i];
      Mask1[Number].Text := Copy(s, 1, pos('-', s) - 2);
      Mask2[Number].Text := Copy(s, pos('-', s) + 2, length(s));

      s := WeekSetting[3][i];
      Mask3[Number].Text := Copy(s, 1, pos('мин.', s) - 2);

      if pos(' ', WeekSetting[4][i]) = 0 then
        DateEd[Number].Text := WeekSetting[4][i];
    end;

end;

procedure TfRentSetting.sbSaveClick(Sender: TObject);
var
  i: integer;
  Timing: TStringList;
begin
  Timing := TStringList.Create;

  for i := 1 to Number do
    begin
      Timing.Append(Comb[i].Text + ' / ' +
                    Mask1[i].Text + ' - ' + Mask2[i].Text +
                    ' / ' + Mask3[i].Text + ' мин. / ' +
                    DateEd[i].Text + ' /');

      WeekSetting[1].Append(Comb[i].Text);
      WeekSetting[2].Append(Mask1[i].Text + ' - ' + Mask2[i].Text);
      WeekSetting[3].Append(Mask3[i].Text);
      WeekSetting[4].Append(DateEd[i].Text);
    end;

  Timing.SaveToFile(FileName);

  Timing.Free;
end;

procedure TfRentSetting.sbAddClick(Sender: TObject);
begin
  AddNew;
end;


//динамическое создание компонент для составления расписания
procedure TfRentSetting.CreateNew;
  //Создание ComboBox со значением дня недели
  procedure CreateComboBox(num: integer);
  begin
    Comb[num] := TComboBox.Create(Self);

    with Comb[num] do
      begin
        Parent := sbData;
        Width := 49;
        Height := 25;
        Top := 8 + 32 * (num - 1);
        Left := 8;
        Items := Weeks;

        if (num - 1) > 0 then
          ItemIndex := Comb[num - 1].ItemIndex + 1
        else
          ItemIndex := 0;

        Visible := true;
      end;
  end;

  //Создание MaskEdit со значениями времени работы
  procedure CreateMaskEdit(num: integer);
    //Свойства MaskEdit
    procedure Proper(Mask: TMaskEdit; prLeft: integer);
    begin
      with Mask do
        begin
          Parent := sbData;
          Width := 49;
          Height := 25;
          Top := 8 + 32 * (num - 1);
          Left := prLeft;
          EditMask := '99:99;1;_';
          Visible := true;
        end;
    end;

  begin
    Mask1[num] := TMaskEdit.Create(Self);
    Mask2[num] := TMaskEdit.Create(Self);
    Mask3[num] := TMaskEdit.Create(Self);

    Proper(Mask1[num], 80);
    Proper(Mask2[num], 152);

    with Mask3[num] do
      begin
        Parent := sbData;
        Width := 25;
        Height := 25;
        Top := 8 + 32 * (num - 1);
        Left := 224;
        EditMask := '99;1;_';
        Visible := true;
      end;
  end;
  //Создание DateEdit со значениями даты
  procedure CreateDateEdit(num: integer);
  begin
    DateEd[num] := TDateEdit.Create(Self);

    with DateEd[num] do
      begin
        Parent := sbData;
        Width := 97;
        Height := 25;
        Top := 8 + 32 * (num - 1);
        Left := 368;
        Visible := true;
      end;
  end;
  //Создание Label со значениями с, по, мин. на человека
  procedure CreateLabel(num: integer);
    //Свойства Label
    procedure Proper(Lab: TLabel; prWidth, prLeft: integer; prCaption: string);
    begin
        with Lab do
          begin
            Parent := sbData;
            Width := prWidth;
            Height := 17;
            Top := 16 + 32 * (num - 1);
            Left := prLeft;
            Caption := prCaption;
            Font.Color := clBlue;
            Visible := true;
          end;
    end;

  begin
    Lab1[num] := TLabel.Create(Self);
    Lab2[num] := TLabel.Create(Self);
    Lab3[num] := TLabel.Create(Self);

    Proper(Lab1[num], 7, 64, 'с');
    Proper(Lab2[num], 14, 136, 'по');
    Proper(Lab3[num], 107, 256, 'мин. на человека');
  end;
  //Создание кнопок SpeedButton для удаления из расписания
  procedure CreateSpeedButton(num: integer);
  begin
    SpeedBut[num] := TSpeedButton.Create(Self);

    with SpeedBut[num] do
      begin
        Parent := sbData;
        Width := 23;
        Height := 23;
        Top := 8 + 32 * (num - 1);
        Left := 472;
        Glyph := sbDelete.Glyph;
        OnClick := SpeedButClick;
        Flat := true;
        Visible := true;
        Tag := num;
      end;
  end;

begin
  CreateComboBox(Number);
  CreateMaskEdit(Number);
  CreateDateEdit(Number);
  CreateLabel(Number);
  CreateSpeedButton(Number);
end;

//Процедура описания кнопки удаления из расписания
procedure TfRentSetting.SpeedButClick(Sender: TObject);
var
  i, j: integer;
begin
  j := (Sender as TSpeedButton).Tag;

  if Number > 0 then
    for i := j to Number - 1 do
      begin
        Comb[i].Text := Comb[i + 1].Text;

        Mask1[i].Text := Mask1[i + 1].Text;
        Mask2[i].Text := Mask2[i + 1].Text;
        Mask3[i].Text := Mask3[i + 1].Text;

        DateEd[i].Text := DateEd[i + 1].Text;
      end;

  //удаление компонент
  if Number > 0 then
    begin
      Comb[Number].Destroy;

      Mask1[Number].Destroy;
      Mask2[Number].Destroy;
      Mask3[Number].Destroy;

      DateEd[Number].Destroy;

      Lab1[Number].Destroy;
      Lab2[Number].Destroy;
      Lab3[Number].Destroy;

      SpeedBut[Number].Destroy;
    end;

  Dec(Number);
end;


//Загрузка данных по дням недели
procedure TfRentSetting.LoadDayWeek;
var
  i: integer;
begin
  Weeks := TStringList.Create;

  for i := 1 to 7 do
    Weeks.Append(DayWeek[i]);
end;

//Процедура добавления новых компоненты для составления расписания
procedure TfRentSetting.AddNew;
begin
  inc(Number);

  if Number < AllKol then
    CreateNew;
end;

procedure TfRentSetting.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Weeks.Free;
end;

procedure TfRentSetting.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  Mess: string;
begin
  Mess := 'Вы не внесли настройки!' + #10 + #13 +
          'OK - внести настройки' + #10 + #13 +
          'Cancel - закрыть программу';
          
  if WeekSetting[1].Count = 0 then
    begin
      if MessageDlg(Mess, mtWarning, mbOKCancel, 0) = mrOK then
        CanClose := false
      else
        Application.Terminate;
    end
  else
    begin
      LoadSet;
      fMainRent.LoadMonth;
    end;
end;

end.
