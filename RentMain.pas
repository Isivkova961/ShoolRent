unit RentMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Spin, ExtCtrls, Menus, ImgList, DateUtils, WinProcs,
  LoadSetting;

type
  TfMainRent = class(TForm)
    mmRent: TMainMenu;
    ilRent: TImageList;
    N1: TMenuItem;
    pMonth: TPanel;
    pDate: TPanel;
    sRent: TSplitter;
    pTime: TPanel;
    lMonth: TLabel;
    lGod: TLabel;
    cobMonth: TComboBox;
    spGod: TSpinEdit;
    pMessage: TPanel;
    sgMonth: TStringGrid;
    sgDayTime: TStringGrid;
    lDate: TLabel;
    lMessage: TLabel;
    nSetting: TMenuItem;
    procedure LoadMonth;
    procedure FormShow(Sender: TObject);
    procedure sgMonthDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure LoadDay;
    procedure cobMonthChange(Sender: TObject);
    procedure sgMonthSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDayTimeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgDayTimeDblClick(Sender: TObject);
    procedure LoadRegistr;
    procedure nSettingClick(Sender: TObject);
    procedure VivodTime(TimeHours: string; MinOne: integer);

  private
    { Private declarations }
  public
    OpenHours: TStringList;
    { Public declarations }
  end;

var
  fMainRent: TfMainRent;
  FTextHeight : Integer;


implementation

uses RentRegistr, RentDM, RentSetting;

{$R *.dfm}

//Загрузка данных в таблицу
procedure TfMainRent.LoadMonth;
var
  days, WD: integer;
  i, j, index, k, Rows, Cols: integer;
  month_, day_, date_, data_: string;
  OneDate, NowDate, MonthYear: string;

  //Процедура вывода запроса о количестве людей записаных на день
  procedure LoadRegCount;
  var
    s: string;
  begin
    with dmRent do
      begin
        s := #39 + '%' + MonthYear + #39;

        adoqRegCount.SQL.Clear;

        adoqRegCount.SQL.Text := 'SELECT date_fit, count(fam) AS Coun' +
                                  ' FROM register' +
                                  ' WHERE date_fit LIKE ' + s +
                                  ' GROUP BY date_fit' +
                                  ' ORDER BY date_fit ASC';

        adoqRegCount.Open;
      end;
  end;

begin
  MonthYear := '.' + IntToStrTwo(MonthInt[cobMonth.ItemIndex]) + '.' + spGod.Text;

  LoadRegCount;

  for i := 1 to sgMonth.RowCount - 1 do
    sgMonth.Rows[i].Clear;

  for i := 0 to 6 do
    sgMonth.Cells[i, 0] := DayWeek[i + 1];

  OneDate := '01' + MonthYear;

  //Определяем количество дней в месяце
  days := DaysInMonth(StrToDate(OneDate));

  //Описание формата даты
  DateSeparator := '.';
  ShortDateFormat := 'dd/mm/yyyy';

  //Определение дня недели для первого числа месяца
  WD := DayOfTheWeek(StrToDate(OneDate));

  //Определение даты на данный момент
  NowDate := DateToStr(Date);

  j := 1;
  Rows := 1;
  Cols := WD - 1;

  //Проходим цикл по дням месяца
  for i := 1 to days do
    begin
      data_ := '0';

      //Если прошла неделя, то выводим ноыую строку
      if WD = 8 then
        begin
          WD := 1;
          Inc(j);
          sgMonth.RowCount := j + 1;
       end;

      day_ := IntToStrTwo(i); //Преобразование из числа в строку с двумя знаками

      //Определение записываемого дня
      date_ := day_ + MonthYear;

      index := WeekSetting[4].IndexOf(date_);

      if index > - 1 then
        begin
          for k := index to WeekSetting[4].Count - 1 do
            if  date_ = WeekSetting[4][k] then
              data_ := IntToStr(StrToInt(data_) + StrToInt(WeekSetting[5][k]));

          if dmRent.adoqRegCount.Locate('date_fit', date_, []) then
            data_ := IntToStr(StrToInt(data_) - dmRent.adoqRegCount.FieldByName('Coun').AsInteger) + ' свободно'
          else
            data_ := data_ + ' свободно';
        end
      else
        begin
          index := WeekSetting[1].IndexOf(sgMonth.Cells[WD - 1, 0]);

          if index > - 1 then
            begin
              for k := index to WeekSetting[1].Count - 1 do
                if (WeekSetting[1][k] = sgMonth.Cells[WD - 1, 0]) and (pos(' ', WeekSetting[4][k]) > 0) then
                  data_ := IntToStr(StrToInt(data_) + StrToInt(WeekSetting[5][k]));

              if dmRent.adoqRegCount.Locate('date_fit', date_, []) then
                data_ := IntToStr(StrToInt(data_) - dmRent.adoqRegCount.FieldByName('Coun').AsInteger) + ' свободно'
              else
                data_ := data_ + ' свободно';
            end
          else
            data_ := 'выходной';
        end;

      month_ := day_ + #10 + #13 + #10 + #13 + ' ' + data_;

      sgMonth.Cells[WD - 1, j] := month_;

      if NowDate = Date_ then
        begin
          Rows := j;
          Cols := WD - 1;
        end;

      Inc(WD);
    end;

  for i := 1 to sgMonth.RowCount - 1 do
    sgMonth.RowHeights[i] := 60;

  sgMonth.SetFocus;
  sgMonth.Row := Rows;
  sgMonth.Col := Cols;
end;

procedure TfMainRent.FormShow(Sender: TObject);
begin
  LoadSet;

  if WeekSetting[1].Count = 0 then
    begin
      ShowMessage('Пожалуйста внесите настройки расписания для приема записей на примерку');
      fRentSetting.ShowModal;
    end;

  cobMonth.ItemIndex := MonthOf(Date) - 1; //Присвоение данных о текущем месяце
  spGod.Value := YearOf(Date);             //Присвоение данных о текущем годе

  OpenHours := TStringList.Create;
  OpenHours.Sorted := true;
  
  LoadMonth;                               //Загрузка данных по месяцу
end;

procedure TfMainRent.sgMonthDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
var
  Format: Word;
  C: array[0..255] of Char;
  st: string;
begin
  if (gdFocused in State) then
    begin
      sgMonth.Canvas.Brush.Color := RGB(24, 231, 112); //цвет фона зеленый
    end
  else
    begin
      if ARow = 0 then
        begin
          sgMonth.Canvas.Font.Color := RGB(28, 3, 252);           //цвет текста синий
          sgMonth.Canvas.Font.Style := [fsBold];                //текст жирный
          sgMonth.Canvas.Brush.Color := clGradientActiveCaption;//цвет фона
        end
      else
        begin
          st := sgMonth.Cells[ACol, ARow];

          delete(st, 1, pos(' свободно', st) - 3);
          delete(st, 1, pos(' выходной', st) - 1);

          st := StringReplace(st, ' ', '', [rfReplaceAll, rfIgnoreCase]);
          st := StringReplace(st, 'свободно', '', [rfReplaceAll, rfIgnoreCase]);

          if (st = '') then
            sgMonth.Canvas.Brush.Color := RGB(255, 255, 255)
          else
            if (st = 'выходной') then
              sgMonth.Canvas.Brush.Color := RGB(255, 98, 98)
            else
            if (StrToInt(st) > 0) then
              sgMonth.Canvas.Brush.Color := RGB(255, 255, 255)
            else
              sgMonth.Canvas.Brush.Color := RGB(255, 98, 98);

          sgMonth.Canvas.Font.Style := [];
          sgMonth.Canvas.Font.Color := RGB(0, 0, 0);
        end;
    end;

  Format := DT_CENTER or DT_WORDBREAK;

  sgMonth.Canvas.Font.Name := 'Times New Roman'; //Шрифт данных
  sgMonth.Canvas.Font.Size := 10;                //Размер шрифта
  sgMonth.Canvas.FillRect(Rect);

  StrPCopy(C, sgMonth.Cells[ACol, ARow]);

  WinProcs.DrawText(sgMonth.Canvas.Handle, C,
                    StrLen(C), Rect, Format);

end;

procedure TfMainRent.LoadDay;
var
  i: integer;
begin
  sgDayTime.Cells[0, 0] := 'Время';
  sgDayTime.Cells[1, 0] := 'Фамилия';
  sgDayTime.Cells[2, 0] := 'Размер';
  sgDayTime.Cells[3, 0] := 'Рост';
  sgDayTime.Cells[4, 0] := 'Статус';

  sgDayTime.RowCount := OpenHours.Count + 1;

  for i := 0 to OpenHours.Count - 1 do
    sgDayTime.Cells[0, i + 1] := OpenHours[i];
end;

procedure TfMainRent.cobMonthChange(Sender: TObject);
begin
  LoadMonth;
end;

procedure TfMainRent.sgMonthSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  wd: string;
  index, i: integer;
begin
  if ARow > 0 then
    if sgMonth.Cells[ACol, ARow] <> '' then
      begin
        lDate.Caption := copy(sgMonth.Cells[ACol, ARow], 1, 2) + '.' +
                          IntToStrTwo(MonthInt[cobMonth.ItemIndex]) +
                          '.' + spGod.Text;
                          
        wd := DayWeek[ACol + 1];
      end;

      index := WeekSetting[4].IndexOf(lDate.Caption);

      if index > - 1 then
        begin
          OpenHours.Clear;

          for i := index to WeekSetting[4].Count - 1 do
            if lDate.Caption = WeekSetting[4][i] then
              VivodTime(WeekSetting[2][i], StrToInt(copy(WeekSetting[3][i], 1, 2)));
        end
      else
        begin
          index := WeekSetting[1].IndexOf(wd);

          if index > - 1 then
            begin
              OpenHours.Clear;

              for i := index to WeekSetting[1].Count - 1 do
                if wd = WeekSetting[1][i] then
                  VivodTime(WeekSetting[2][i], StrToInt(copy(WeekSetting[3][i], 1, 2)));
            end
          else
            begin
              OpenHours.Clear;
              OpenHours.Append('выходной');
            end;
        end;
        
  LoadDay;
  LoadRegistr;
end;

procedure TfMainRent.sgDayTimeDrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if (gdSelected in State) then
    begin
      sgDayTime.Canvas.Brush.Color := RGB(24, 231, 112); //цвет фона зеленый
      sgDayTime.Canvas.Font.Style := [fsBold];         //текст жирный
      sgDayTime.Canvas.Font.Color :=  RGB(0, 0, 0);
    end
  else
    begin
      if ARow = 0 then
        begin
          sgDayTime.Canvas.Brush.Color := clGradientActiveCaption;
          sgDayTime.Canvas.Font.Style := [fsBold];
          sgDayTime.Canvas.Font.Color :=  RGB(28, 3, 252);
        end
      else
        begin
          if (sgDayTime.Cells[1, ARow] <> '') and (ARow > 0) then
            sgDayTime.Canvas.Brush.Color := RGB(255, 98, 98)
          else
            sgDayTime.Canvas.Brush.Color := RGB(255, 255, 255); //цвет фона белый

          sgDayTime.Canvas.Font.Style := [];
          sgDayTime.Canvas.Font.Color :=  RGB(0, 0, 0);
        end;
    end;
    
  sgMonth.Canvas.Font.Name := 'Times New Roman'; //Шрифт данных
  sgMonth.Canvas.Font.Size := 10;                //Размер шрифта

  sgDayTime.Canvas.FillRect(Rect);
  
  DrawText(sgDayTime.Canvas.Handle, PChar(sgDayTime.Cells[ACol, ARow]),
          Length(sgDayTime.Cells[ACol, ARow]), Rect,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
end;

procedure TfMainRent.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  ExitSet;
end;

procedure TfMainRent.sgDayTimeDblClick(Sender: TObject);
begin
  fRentRegistr.LoadData(sgDayTime.Cells[0, sgDayTime.Row], sgDayTime.Cells[1, sgDayTime.Row],
                       sgDayTime.Cells[2, sgDayTime.Row], sgDayTime.Cells[3, sgDayTime.Row],
                       (sgDayTime.Cells[4, sgDayTime.Row] = 'Пришла'));

  if sgDayTime.Cells[0, sgDayTime.Row] <> 'выходной' then
    fRentRegistr.ShowModal;
end;

procedure TfMainRent.LoadRegistr;
var
  i, j: integer;
begin
  with dmRent do
    begin
      adoqRegistr.SQL.Clear;

      adoqRegistr.SQL.Append('SELECT * FROM register');
      adoqRegistr.SQL.Append('WHERE date_fit = :d_f');
      adoqRegistr.SQL.Append('ORDER BY time_fit ASC');

      adoqRegistr.Parameters.ParamByName('d_f').Value := lDate.Caption;

      adoqRegistr.Open;

      for i := 1 to sgDayTime.RowCount do
        begin
          if adoqRegistr.Locate('time_fit', sgDayTime.Cells[0, i],[]) then
            begin
              sgDayTime.Cells[1, i] := adoqRegistr.FieldByName('fam').AsString;
              sgDayTime.Cells[2, i] := adoqRegistr.FieldByName('size').AsString;
              sgDayTime.Cells[3, i] := adoqRegistr.FieldByName('rise').AsString;

              if  adoqRegistr.FieldByName('status').AsBoolean then
                sgDayTime.Cells[4, i] := 'Пришла'
              else
                sgDayTime.Cells[4, i] := 'Не пришла';
            end
          else
            begin
              for j := 1 to 4 do
                sgDayTime.Cells[j, i] := '';
            end;
        end;

      adoqRegistr.First;

      while not(adoqRegistr.Eof) do
        begin
          j := OpenHours.IndexOf(adoqRegistr.FieldByName('time_fit').AsString);

          if j = - 1 then
            begin
              sgDayTime.RowCount := sgDayTime.RowCount + 1;
              i := sgDayTime.RowCount;

              sgDayTime.Cells[0, i] := adoqRegistr.FieldByName('time_fit').AsString;
              sgDayTime.Cells[1, i] := adoqRegistr.FieldByName('fam').AsString;
              sgDayTime.Cells[2, i] := adoqRegistr.FieldByName('size').AsString;
              sgDayTime.Cells[3, i] := adoqRegistr.FieldByName('rise').AsString;

              if  adoqRegistr.FieldByName('status').AsBoolean then
                sgDayTime.Cells[4, i] := 'Пришла'
              else
                sgDayTime.Cells[4, i] := 'Не пришла';
            end;

          adoqRegistr.Next;
        end;
    end;
end;

procedure TfMainRent.nSettingClick(Sender: TObject);
begin
  fRentSetting.ShowModal;
end;

procedure TfMainRent.VivodTime(TimeHours:string; MinOne: integer);
var
  Time1, Time2: string;
  Hours1, Hours2, Minut1, Minut2: integer;
  
begin
  Time1 := Copy(TimeHours, 1, pos('-', TimeHours) - 2);
  Time2 := Copy(TimeHours, pos('-', TimeHours) + 2, length(TimeHours));

  Hours1 := CopyTime(Time1, true);
  Hours2 := CopyTime(Time2, true);
  Minut1 := CopyTime(Time1, false);
  Minut2 := CopyTime(Time2, false);

  while (Hours1 * 60 + Minut1) < (Hours2 * 60 + Minut2) do
    begin
     OpenHours.Append(IntToStr(Hours1) + ':' + IntToStrTwo(Minut1));

     Minut1 := Minut1 + MinOne;

      if Minut1 >= 60 then
        begin
          Minut1 := Minut1 mod 60;
          Inc(Hours1);
        end;
    end;
end;

end.



