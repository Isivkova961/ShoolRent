unit Fitting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Mask, ToolEdit, StdCtrls, GridsEh, DBGridEh;

type
  TfFitting = class(TForm)
    pButton: TPanel;
    pData: TPanel;
    pMessage: TPanel;
    lFIO: TLabel;
    lAdress: TLabel;
    lTelefon: TLabel;
    lSchool: TLabel;
    lClass: TLabel;
    lForma: TLabel;
    dbgDress: TDBGridEh;
    dbgApron: TDBGridEh;
    eNumForm: TEdit;
    lNumForm: TLabel;
    lNumApron: TLabel;
    eNumApron: TEdit;
    lDateFit: TLabel;
    lDateExt: TLabel;
    lDateRet: TLabel;
    lKit: TLabel;
    lStatus: TLabel;
    eFIO: TEdit;
    eAdress: TEdit;
    eTelefon: TEdit;
    eSchool: TEdit;
    cobClass: TComboBox;
    deDateFit: TDateEdit;
    deDateExt: TDateEdit;
    deDateRet: TDateEdit;
    cobKit: TComboBox;
    cobStatus: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fFitting: TfFitting;

implementation

uses RentDM;

{$R *.dfm}

end.
