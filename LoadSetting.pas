unit LoadSetting;

interface

uses SysUtils, Classes, DateUtils;

procedure LoadSet;
procedure ExitSet;
function IntToStrTwo(ValInt: integer): string;
function VivodKolMin(t1, t2: string): integer;
function CopyTime(str: string; h_m: boolean): integer;

var
  WeekSetting: array [1..5] of TStringList;
  FileName: string = 'Setting.dat';
  DayWeek: array [1..7] of string = ('��', '��', '��', '��', '��', '��', '��');
  MonthInt: array [0..11] of integer = (1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);

implementation

procedure LoadSet;
var
  i, j: integer;
  LoadData: TStringList;
  s: string;
  Fil: TextFile;

  procedure RecordNumber;
  var
    k: integer;
    Time1, Time2, str, min_: string;
  begin
    for k := 0 to WeekSetting[2].Count - 1 do
      begin
        str := WeekSetting[2][k];

        Time1 := Copy(str, 1, pos('-', str) - 2);
        Time2 := Copy(str, pos('-', str) + 2, length(str));

        str := WeekSetting[3][k];

        min_ := Copy(str, 1, pos('���.', str) - 2);
        
        WeekSetting[5][k] := IntToStr(Trunc(VivodKolMin(Time1, Time2)/ StrToInt(min_)));
      end;
  end;
begin
  LoadData := TStringList.Create;

  //�������� ����� �������� ����������
  AssignFile(Fil, FileName);

  if FileExists(FileName) then
    begin
      Reset(Fil);
      LoadData.LoadFromFile(FileName);
    end
  else
    Rewrite(Fil);

  CloseFile(Fil);
  //�������� ����� �������� ����������

  for i := 1 to 5 do
    WeekSetting[i] := TStringList.Create;

  for j := 0 to LoadData.Count - 1 do
    begin
      s := LoadData[j];

      for i := 1 to 4 do
        begin
          WeekSetting[i].Append(copy(s, 1, pos('/', s) - 2));
          delete(s, 1, pos('/', s) + 1);
        end;

      WeekSetting[5].Append('0');
    end;

  RecordNumber;
  //������������ ������ ����� �������� ������
  LoadData.Free;
end;

procedure ExitSet;
var
  i: integer;
begin
  //������������ ������ ����� �������� ����������
  for i := 1 to 5 do
    WeekSetting[i].Free;
end;

function IntToStrTwo(ValInt: integer): string;
var
  num: string;
begin
  num := IntToStr(ValInt);

  if Length(num) < 2 then
    Result := '0' + num
  else
    Result := num;
end;

function VivodKolMin(t1, t2: string): integer;
var
  h1, m1, h2, m2: integer;
begin
  h1 := CopyTime(t1, true);
  m1 := CopyTime(t1, false);
  h2 := CopyTime(t2, true);
  m2 := CopyTime(t2, false);

  Result := (h2 * 60 + m2) - (h1 * 60 + m1);
end;

function CopyTime(str: string; h_m: boolean): integer;
begin
  if h_m = true then
    Result := StrToInt(Copy(str, 1, pos(':', str) - 1))
  else
    Result := StrToInt(Copy(str, pos(':', str) + 1, length(str)));
end;

end.
