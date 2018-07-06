unit RentFitting;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, ExtCtrls;

type
  TfRentFitting = class(TForm)
    pButton: TPanel;
    pData: TPanel;
    pMessage: TPanel;
    dbgFitting: TDBGridEh;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fRentFitting: TfRentFitting;

implementation

uses RentDM;

{$R *.dfm}

end.
