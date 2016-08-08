unit RentSetting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, ExtCtrls, Buttons, Mask;

type
  TfRentSetting = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Splitter1: TSplitter;
    lWeek: TLabel;
    cobWeek: TComboBox;
    lTimeS: TLabel;
    meTimeS: TMaskEdit;
    lTimePo: TLabel;
    meTimePo: TMaskEdit;
    cebDayOff: TCheckBox;
    spAdd: TSpeedButton;
    sbClear: TSpeedButton;
    mWeek: TMemo;
    lMin: TLabel;
    meMin: TMaskEdit;
    lMin_: TLabel;
    sbSave: TSpeedButton;
    procedure cebDayOffClick(Sender: TObject);
    procedure sbClearClick(Sender: TObject);
    procedure spAddClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure sbSaveClick(Sender: TObject);
    procedure ClearText;
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRentSetting: TfRentSetting;
  Day_Off : array [1..3] of TStringList;   //¬место Day_Off использовать fMainRent.WeekSetting
  
implementation

uses RentMain;

{$R *.dfm}

procedure TfRentSetting.cebDayOffClick(Sender: TObject);
begin
  meTimeS.Enabled := not(cebDayOff.Checked);
  meTimePo.Enabled := not(cebDayOff.Checked);
  meMin.Enabled := not(cebDayOff.Checked);

  ClearText;
  meMin.Text := '';
end;

procedure TfRentSetting.sbClearClick(Sender: TObject);
begin
  ClearText;
end;

procedure TfRentSetting.spAddClick(Sender: TObject);
var
  i, index: integer;

  function TimeAdd(DayOff: boolean; OpenHour: string): string;
  var
    s, TimePeriod: string;
  begin
    TimePeriod := meTimeS.Text + ' - ' + meTimePo.Text;

    OpenHour := StringReplace(OpenHour, 'выходной', '', []);
    OpenHour := StringReplace(OpenHour, TimePeriod, '', []);

    if OpenHour = '' then
      s := ''
    else
      s := ';';

    if DayOff then
      Result := 'выходной'
    else
      Result := OpenHour + s + TimePeriod;

    Result := StringReplace(Result, ';;', ';', [rfReplaceAll]);
  end;

  function TestData: boolean;
  begin
    if not(cebDayOff.Checked) then
      begin
        if pos(' ', meTimeS.Text) > 0 then
          begin
            ShowMessage('¬ведите врем€ начала!');
            meTimeS.SetFocus;

            Result := false;
          end
        else
        if pos(' ', meTimePo.Text) > 0 then
          begin
            ShowMessage('¬ведите врем€ окончани€!');
            meTimePo.SetFocus;

            Result := false;
          end
        else
        if pos(' ', meMin.Text) > 0 then
          begin
            ShowMessage('¬ведите врем€ на одного человека!');
            meMin.SetFocus;

            Result := false;
          end
        else
          Result := true;
      end
    else
      Result := true;
  end;

begin
  if TestData then
    begin
      index := Day_Off[1].IndexOf(cobWeek.Text);

      if index = - 1 then
        begin
          Day_Off[1].Append(cobWeek.Text);
          Day_Off[2].Append(TimeAdd(cebDayOff.Checked, ''));
          Day_Off[3].Append(meMin.Text);
        end
      else
        begin
          Day_Off[2][index] := TimeAdd(cebDayOff.Checked, Day_Off[2][index]);
          Day_Off[3][index] := meMin.Text;
        end;

      mWeek.Clear;

      for i := 0 to Day_Off[1].Count - 1 do
        begin
          mWeek.Lines.Append(Day_Off[1][i] + ' ' + Day_Off[2][i] + ' // ' + Day_Off[3][i] + ' мин.');
        end;
    end;
end;

procedure TfRentSetting.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 3 do
    Day_Off[i] := TStringList.Create;
end;

procedure TfRentSetting.FormShow(Sender: TObject);
var
  FileName: string;
  i: integer;
  WeekFile: TStringList;
  Fil: TextFile;
begin
  WeekFile := TStringList.Create;
  FileName := 'Setting.dat';

  AssignFile(Fil, FileName);

  if FileExists(FileName) then
    begin
      Reset(Fil);
      WeekFile.LoadFromFile(FileName);

      for i := 1 to 3 do
        Day_Off[i].Clear;

      for i := 0 to WeekFile.Count - 1 do
        begin
          Day_Off[1].Append(copy(WeekFile[i], 1, 2));
          Day_Off[2].Append(copy(WeekFile[i], 4 , pos('//', WeekFile[i]) - 5));
          Day_Off[3].Append(copy(WeekFile[i], pos('//', WeekFile[i]) + 3, pos('мин', WeekFile[i]) - pos('//', WeekFile[i]) - 4));
        end;

      for i := 0 to Day_Off[1].Count - 1 do
        begin
          mWeek.Lines.Append(Day_Off[1][i] + ' ' + Day_Off[2][i] + ' // ' + Day_Off[3][i] + ' мин.');
        end;
    end
  else
    Rewrite(Fil);

  CloseFile(Fil);
    
end;

procedure TfRentSetting.sbSaveClick(Sender: TObject);
var
  i, j: integer;
begin
  mWeek.Lines.SaveToFile('Setting.dat');

  for i := 0 to Day_Off[1].Count - 1 do
    begin
      for j := 1 to 3 do
        fMainRent.WeekSetting[j].Append(Day_Off[j][i]);
        
      fMainRent.WeekSetting[4].Append('');
    end;
    
  fMainRent.Show;
end;

procedure TfRentSetting.ClearText;
begin
  meTimeS.Text := '';
  meTimePo.Text := '';
end;



end.
