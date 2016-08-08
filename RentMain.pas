unit RentMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Spin, ExtCtrls, Menus, ImgList, DateUtils, WinProcs;

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
    procedure LoadDay(RabTime: string; MinOne: integer);
    procedure cobMonthChange(Sender: TObject);
    procedure sgMonthSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure sgDayTimeDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sgDayTimeDblClick(Sender: TObject);
    procedure LoadRegistr;
    procedure SeatsCount;

  private
    { Private declarations }
  public
    WeekSetting: array [1..4] of TStringList;
    { Public declarations }
  end;

var
  fMainRent: TfMainRent;
  FTextHeight : Integer;

implementation

uses RentRegistr, RentDM;

{$R *.dfm}

//Загрузка данных в таблицу
procedure TfMainRent.LoadMonth;
var
  days, WD: integer;
  i, j, index: integer;
  month_, day_, n_day_, date_, data_: string;

  procedure LoadRegCount;
  var
    s: string;
  begin
    with dmRent do
      begin
        s := #39 + '%' + cobMonth.Text + ' ' + spGod.Text + #39;

        adoqRegCount.SQL.Clear;

        adoqRegCount.SQL.Text := 'SELECT date_fit, count(fam) AS Coun' +
                                  ' FROM register' +
                                  ' WHERE date_fit LIKE ' + s +
                                  ' GROUP BY date_fit' +
                                  ' ORDER BY date_fit ASC';

  //      adoqRegCount.Parameters.ParamByName('d_f').Value := '*' + cobMonth.Text +
  //                                                          ' ' + spGod.Text;

        adoqRegCount.Open;
        ShowMessage(IntToStr(adoqRegCount.RecordCount));
      end;
  end;

begin
  LoadRegCount;

  for i := 1 to sgMonth.RowCount - 1 do
    sgMonth.Rows[i].Clear;

  sgMonth.Cells[0, 0] := 'пн';
  sgMonth.Cells[1, 0] := 'вт';
  sgMonth.Cells[2, 0] := 'ср';
  sgMonth.Cells[3, 0] := 'чт';
  sgMonth.Cells[4, 0] := 'пт';
  sgMonth.Cells[5, 0] := 'сб';
  sgMonth.Cells[6, 0] := 'вс';

  days := DaysInMonth(StrToDate('01.' + IntToStr(cobMonth.ItemIndex + 1) + '.' + spGod.Text));

  DateSeparator := '.';
  ShortDateFormat := 'dd/mm/yyyy';
  WD:=DayOfTheWeek(StrToDate('01.' + IntToStr(cobMonth.ItemIndex + 1) + '.' + spGod.Text));

  n_day_ := DateToStr(Date);
  delete(n_day_, 3, length(n_day_));

  j := 1;

  for i := 1 to days do
    begin
      if WD = 8 then
        begin
          WD := 1;
          Inc(j);
          sgMonth.RowCount := j + 1;
       end;

      if length(IntToStr(i)) = 2 then
        day_ := IntToStr(i)
      else
        day_ := '0' + IntToStr(i);

      date_ := day_ + ' ' + cobMonth.Text + ' ' + spGod.Text;
      index := WeekSetting[1].IndexOf(sgMonth.Cells[WD - 1, 0]);
        
        if index > - 1 then
          begin
            with dmRent do
              begin
                if adoqRegCount.Locate('date_fit', date_, []) then
                  data_ := IntToStr(StrToInt(WeekSetting[4][index]) -
                          adoqRegCount.FieldByName('Coun').AsInteger) +
                          ' свободно'
                else
                  if WeekSetting[4][index] = 'выходной' then
                    data_ := WeekSetting[4][index]
                  else
                    data_ := WeekSetting[4][index] + ' свободно';
              end;

            month_ := day_ + #10 + #13 + #10 + #13 + ' ' + data_;
          end;

      sgMonth.Cells[WD - 1, j] := month_;

      if n_day_ = day_ then
        begin
          sgMonth.SetFocus;
          sgMonth.Row := j;
          sgMonth.Col := WD - 1;
        end;

      Inc(WD);
    end;

  for i := 1 to sgMonth.RowCount - 1 do
    sgMonth.RowHeights[i] := 60;
end;

procedure TfMainRent.FormShow(Sender: TObject);
var
  day_: string;
begin
  cobMonth.ItemIndex := MonthOf(Date) - 1; //Присвоение данных о текущем месяце
  spGod.Value := YearOf(Date);             //Присвоение данных о текущем годе

  SeatsCount;
  LoadMonth;                               //Загрузка данных по месяцу
 // LoadDay;                                 //Загрузка данных по дню

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

procedure TfMainRent.LoadDay(RabTime: string; MinOne: integer);
var
  days, WD: integer;
  i, j, hour_, minut_, im: integer;
  time_, t1, t2, st: string;
begin

  time_ := RabTime;

  sgDayTime.Cells[0, 0] := 'Время';
  sgDayTime.Cells[1, 0] := 'Фамилия';
  sgDayTime.Cells[2, 0] := 'Размер';
  sgDayTime.Cells[3, 0] := 'Рост';
  sgDayTime.Cells[4, 0] := 'Статус';

  i := 1;
  if time_ <> 'выходной' then
    begin
      while length(time_) > 0 do
        begin
          if pos(';', time_) > 0 then
            begin
              t1 := copy(time_, 1, pos(' ', time_) - 1);
              t2 := copy(time_, pos(' ', time_) + 3, pos(';', time_) - pos(' ', time_) - 3);
              delete(time_, 1, pos(';', time_));
            end
          else
            begin
              t1 := copy(time_, 1, pos(' ', time_) - 1);
              t2 := copy(time_, pos(' ', time_) + 3, length(time_));
              time_ := '';
            end;

          im := MinOne;
          hour_ := StrToInt(copy(t1, 1, pos(':', t1) - 1));
          minut_ := StrToInt(copy(t1, pos(':', t1) + 1, length(t1)));
          sgDayTime.Cells[0, i] := t1;
          inc(i);
          sgDayTime.RowCount := i;

          while t1 <> t2 do
            begin
              minut_ := minut_ + im;

              if minut_ >= 60 then
                begin
                  minut_ := minut_ mod 60;
                  hour_ := hour_ + 1;
                end;

              if length(IntToStr(minut_)) = 2 then
                t1 := IntToStr(hour_) + ':' + IntToStr(minut_)
              else
                t1 := IntToStr(hour_) + ':0' + IntToStr(minut_);

              if t1 <> t2 then
                begin
                  sgDayTime.Cells[0, i] := t1;
                  inc(i);
                  sgDayTime.RowCount := i;
                end;
            end;
        end;
    end
  else
    begin
      sgDayTime.RowCount := 2;
      sgDayTime.Cells[0, 1] := 'выходной';
    end;

end;

procedure TfMainRent.cobMonthChange(Sender: TObject);
begin
  LoadMonth;
end;

procedure TfMainRent.sgMonthSelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var
  wd: string;
  index, i, zap: integer;
begin
  if ARow > 0 then
    if sgMonth.Cells[ACol, ARow] <> '' then
      begin
        lDate.Caption := copy(sgMonth.Cells[ACol, ARow], 1, 2) + ' ' +
                          cobMonth.Text + ' ' + spGod.Text;
                          
        case ACol of
          0:  wd := 'пн';
          1:  wd := 'вт';
          2:  wd := 'ср';
          3:  wd := 'чт';
          4:  wd := 'пт';
          5:  wd := 'сб';
          6:  wd := 'вс';
        end;

        index := WeekSetting[1].IndexOf(wd);
        
        if index > - 1 then
          if WeekSetting[3][index] <> '  ' then
            LoadDay(WeekSetting[2][index], StrToInt(WeekSetting[3][index]))
          else
            LoadDay(WeekSetting[2][index], 0);
      end;

  LoadRegistr;

  //Проверка сколько записано и сколько можно записать
  zap := 0;

  for i := 1 to sgDayTime.RowCount do
    begin
      if sgdayTime.Cells[1, i] <> '' then
        Inc(zap);
    end;

  ShowMessage(lDate.Caption + ' записано: ' + IntToStr(zap) +
              ' человек, свободно: ' + IntToStr(sgDayTime.RowCount - 1 - zap) + 'мест');
  //
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

procedure TfMainRent.FormCreate(Sender: TObject);
var
  i: integer;
begin
  for i := 1 to 4 do
    WeekSetting[i] := TStringList.Create;
end;

procedure TfMainRent.FormClose(Sender: TObject; var Action: TCloseAction);
var
  i: integer;
begin
  for i := 1 to 4 do
    WeekSetting[i].Free;
end;

procedure TfMainRent.sgDayTimeDblClick(Sender: TObject);
begin
  fRentRegistr.meTime.Text := sgDayTime.Cells[0, sgDayTime.Row];
  fRentRegistr.eFam.Text := sgDayTime.Cells[1, sgDayTime.Row];
  fRentRegistr.cobSize.Text := sgDayTime.Cells[2, sgDayTime.Row];
  fRentRegistr.eRise.Text := sgDayTime.Cells[3, sgDayTime.Row];

  if sgDayTime.Cells[4, sgDayTime.Row] = 'Пришла' then
    fRentRegistr.cebStatus.Checked := true
  else
    fRentRegistr.cebStatus.Checked := false;

  if sgDayTime.Cells[0, sgDayTime.Row] <> 'выходной' then
    fRentRegistr.ShowModal;
end;

procedure TfMainRent.LoadRegistr;
var
  i: integer;
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
              sgDayTime.Cells[1, i] := '';
              sgDayTime.Cells[2, i] := '';
              sgDayTime.Cells[3, i] := '';
              sgDayTime.Cells[4, i] := '';
            end;
        end;
    end;
end;

procedure TfMainRent.SeatsCount;
var
  i, im, Kol: integer;
  time_, hour_, minut_, t1, t2: string;

  function SumKol(h1, m1, h2, m2: integer; Sum_Kol: integer): integer;
  begin
    Result := Sum_Kol + (h2 * 60 + m2) - (h1 * 60 + m1);
  end;

begin
 for i := 0 to WeekSetting[1].Count - 1 do
    begin
      time_ := WeekSetting[2][i];
      Kol := 0;

      if time_ <> 'выходной' then
        begin
          im := StrToInt(WeekSetting[3][i]);

          while length(time_) > 0 do
            begin
              if pos(';', time_) > 0 then
                begin
                  t1 := copy(time_, 1, pos('-', time_) - 2);
                  t2 := copy(time_, pos('-', time_) + 2, pos(';', time_) - pos('-', time_) - 2);
                  delete(time_, 1, pos(';',time_));
                end
              else
                begin
                  t1 := copy(time_, 1, pos('-', time_) - 2);
                  t2 := copy(time_, pos('-', time_) + 2, length(time_) - 1);
                  time_ := '';
                end;

              Kol := SumKol(StrToInt(copy(t1, 1, 2)), StrToInt(copy(t1, 4, 2)), StrToInt(copy(t2, 1, 2)), StrToInt(copy(t2, 4, 2)), Kol);
            end;
          WeekSetting[4][i] := IntToStr(Trunc(Kol / im));
        end
      else
        WeekSetting[4][i] := 'выходной';
    end;
end;

end.



