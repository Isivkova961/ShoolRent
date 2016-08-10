unit RentRegistr;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons, ExtCtrls;

type
  TfRentRegistr = class(TForm)
    pButton: TPanel;
    pData: TPanel;
    pMessage: TPanel;
    lTime: TLabel;
    lFam: TLabel;
    lSize: TLabel;
    lRise: TLabel;
    lStatus: TLabel;
    sbOK: TSpeedButton;
    sbCancel: TSpeedButton;
    eFam: TEdit;
    cobSize: TComboBox;
    eRise: TEdit;
    cebStatus: TCheckBox;
    lMessage: TLabel;
    cobTime: TComboBox;
    procedure eRiseKeyPress(Sender: TObject; var Key: Char);
    procedure eFamKeyPress(Sender: TObject; var Key: Char);
    procedure sbCancelClick(Sender: TObject);
    procedure sbOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure LoadTable;
    procedure LoadList;
    procedure LoadData(Time_, Fam_, Size_, Rise_: string; Status: boolean);
    procedure DataLoad;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRentRegistr: TfRentRegistr;
  TimeReg, FamReg, SizeReg, RiseReg: string;
  StatusReg: boolean;

implementation

uses RentDM, RentMain;

{$R *.dfm}

procedure TfRentRegistr.eRiseKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', #46, #8]) then Key := #0;
end;

procedure TfRentRegistr.eFamKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['à'..'ÿ', 'À'..'ß', #46, #8]) then Key := #0;
end;

procedure TfRentRegistr.sbCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfRentRegistr.sbOKClick(Sender: TObject);

  procedure WriteData;
  begin
    with dmRent do
      begin
        adoqRegistr.FieldByName('fam').Value := eFam.Text;
        adoqRegistr.FieldByName('date_fit').Value := fMainRent.lDate.Caption;
        adoqRegistr.FieldByName('time_fit').Value := cobTime.Text;
        adoqRegistr.FieldByName('size').Value := cobSize.Text;
        adoqRegistr.FieldByName('rise').Value := eRise.Text;
        adoqRegistr.FieldByName('status').Value := cebStatus.Checked;
      end;
  end;

begin
  with dmRent do
    begin
      if adoqRegistr.Locate('time_fit', cobTime.Text, []) then
        begin
          adoqRegistr.Edit;
          WriteData;
          adoqRegistr.Post;
        end
      else
        begin
          adoqRegistr.Insert;
          WriteData;
          adoqRegistr.Post;
        end;
    end;

  fMainRent.LoadRegistr;
  fMainRent.LoadMonth;
  
  Close;
end;

procedure TfRentRegistr.FormShow(Sender: TObject);
begin
  LoadList;
  LoadTable;
  DataLoad;
end;

procedure TfRentRegistr.LoadTable;
begin
  with dmRent do
    begin
      adoqRegistr.SQL.Clear;

      adoqRegistr.SQL.Append('SELECT * FROM register');
      adoqRegistr.SQL.Append('WHERE date_fit = :d_f');
      adoqRegistr.SQL.Append('AND time_fit = :t_f');

      adoqRegistr.Parameters.ParamByName('d_f').Value := fMainRent.lDate.Caption;
      adoqRegistr.Parameters.ParamByName('t_f').Value := cobTime.Text;

      adoqRegistr.Open;
    end;
end;

procedure TfRentRegistr.LoadList;
begin
  cobTime.Items := fMainRent.OpenHours;
end;

procedure TfRentRegistr.LoadData(Time_, Fam_, Size_, Rise_: string; Status: boolean);
begin
  TimeReg := Time_;
  FamReg := Fam_;
  SizeReg := Size_;
  RiseReg := Rise_;
  StatusReg := Status;
end;

procedure TfRentRegistr.DataLoad;
begin
  cobTime.ItemIndex := cobTime.Items.IndexOf(TimeReg);
  eFam.Text := FamReg;
  cobSize.ItemIndex := cobSize.Items.IndexOf(SizeReg);
  eRise.Text := RiseReg;
  cebStatus.Checked := StatusReg;
end;

end.
