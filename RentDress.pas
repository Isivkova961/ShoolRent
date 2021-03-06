unit RentDress;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls, StdCtrls;

type
  TfRentDress = class(TForm)
    pFiltr: TPanel;
    pData: TPanel;
    pMessage: TPanel;
    dbgDress: TDBGridEh;
    cebNumForm: TCheckBox;
    cebColor: TCheckBox;
    cebSize: TCheckBox;
    cebLengSkird: TCheckBox;
    cebStatus: TCheckBox;
    cebYesStatus: TCheckBox;
    eNumForm: TEdit;
    cobColor: TComboBox;
    eSize: TEdit;
    eLengSkird: TEdit;
    lMessage: TLabel;
    lKol: TLabel;
    procedure dbgDressKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function FilterString: string;
    procedure FiltrBase;
    procedure eNumFormChange(Sender: TObject);
    procedure cebNumFormClick(Sender: TObject);
    procedure cobColorChange(Sender: TObject);
    procedure cebColorClick(Sender: TObject);
    procedure eSizeChange(Sender: TObject);
    procedure cebSizeClick(Sender: TObject);
    procedure eLengSkirdChange(Sender: TObject);
    procedure cebLengSkirdClick(Sender: TObject);
    procedure cebStatusClick(Sender: TObject);
    procedure cebYesStatusClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoadData;

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRentDress: TfRentDress;

implementation

uses RentDM;

{$R *.dfm}

procedure TfRentDress.dbgDressKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
    begin
      dbgDress.Options := dbgDress.Options - [dgRowSelect] + [dgEditing];

      with dmRent.adoqDress do
        begin
          Edit;
          Post;
        end;
    end;

  if Key = 46 then
    begin
      dmRent.adoqDress.Insert;
    end;

  if Key = 45 then
    if MessageDlg('�� �������, ��� ������ �������!', mtWarning, mbOKCancel, 0) = mrOK then
      dmRent.adoqDress.Delete;
end;

function TfRentDress.FilterString: string;
var
  s, status: string;
begin
  if cebNumForm.Checked then
    if s = '' then
      s := s + 'num_form LIKE ''*' + eNumForm.Text + '*'''
    else
      s := s + ' and num_form LIKE ''*' + eNumForm.Text + '*''';

  if cebColor.Checked then
    if s = '' then
      s := s + 'color LIKE ''*' + cobColor.Text + '*'''
    else
      s := s + ' and color LIKE ''*' + cobColor.Text + '*''';

  if cebSize.Checked then
    if s = '' then
      s := s + 'size LIKE ''*' + eSize.Text + '*'''
    else
      s := s + ' and size LIKE ''*' + eSize.Text + '*''';

  if cebLengSkird.Checked then
    if s = '' then
      s := s + 'leng_skird >' + eLengSkird.Text
    else
      s := s + ' and leng_skird >' + eLengSkird.Text;

  if cebYesStatus.Checked then
    status := 'true'
  else
    status := 'false';

  if cebStatus.Checked then
    if s = '' then
      s := s + 'status = ' + status
    else
      s := s + ' and status = ' + status;

  Result := s;
end;

procedure TfRentDress.FiltrBase;
var
  Filtr: string;
begin
  Filtr := FilterString;

  with dmRent.adoqDress do
    begin
      Filter := Filtr;
      Filtered := (Filtr <> '');
    end;

  lKol.Caption := IntToStr(dmRent.adoqDress.RecordCount);
end;

procedure TfRentDress.eNumFormChange(Sender: TObject);
begin
  if eNumForm.Text <> '' then
    cebNumForm.Checked := true;
    
  FiltrBase;
end;

procedure TfRentDress.cebNumFormClick(Sender: TObject);
begin
  if cebNumForm.Checked = false then
    eNumForm.Text := '';
    
  FiltrBase;
end;

procedure TfRentDress.cobColorChange(Sender: TObject);
begin
  if cobColor.ItemIndex <> - 1 then
    cebColor.Checked := true;

  FiltrBase;
end;

procedure TfRentDress.cebColorClick(Sender: TObject);
begin
  if cebColor.Checked = false then
    cobColor.ItemIndex := - 1;

  FiltrBase;
end;

procedure TfRentDress.eSizeChange(Sender: TObject);
begin
  if eSize.Text <> '' then
    cebSize.Checked := true;

  FiltrBase;
end;

procedure TfRentDress.cebSizeClick(Sender: TObject);
begin
  if cebSize.Checked = false then
    eSize.Text := '';

  FiltrBase;
end;

procedure TfRentDress.eLengSkirdChange(Sender: TObject);
begin
  if eLengSkird.Text <> '' then
    cebLengSkird.Checked := true;

  FiltrBase;
end;

procedure TfRentDress.cebLengSkirdClick(Sender: TObject);
begin
  if cebLengSkird.Checked = false then
    eLengSkird.Text := '';

  FiltrBase;
end;

procedure TfRentDress.cebStatusClick(Sender: TObject);
begin
  if cebStatus.Checked = false then
    cebYesStatus.Checked := false;

  FiltrBase;
end;

procedure TfRentDress.cebYesStatusClick(Sender: TObject);
begin
  if cebYesStatus.Checked = true then
    cebStatus.Checked := true;

  FiltrBase;
end;

procedure TfRentDress.FormShow(Sender: TObject);
begin
  LoadData;
  lKol.Caption := IntToStr(dmRent.adoqDress.RecordCount);
end;

procedure TfRentDress.LoadData;
begin
  with dmRent.adoqDress do
    begin
      SQL.Clear;

      SQL.Append('SELECT * FROM dress');
      SQL.Append('ORDER BY num_form ASC');

      Open;
    end;
end;

end.
