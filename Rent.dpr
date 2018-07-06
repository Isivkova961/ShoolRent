program Rent;

uses
  Forms,
  RentMain in 'RentMain.pas' {fMainRent},
  RentDM in 'RentDM.pas' {dmRent: TDataModule},
  RentSetting in 'RentSetting.pas' {fRentSetting},
  RentRegistr in 'RentRegistr.pas' {fRentRegistr},
  LoadSetting in 'LoadSetting.pas',
  RentDress in 'RentDress.pas' {fRentDress},
  RentFitting in 'RentFitting.pas' {fRentFitting},
  Fitting in 'Fitting.pas' {fFitting};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Rent 1.0';
  Application.CreateForm(TfMainRent, fMainRent);
  Application.CreateForm(TfRentDress, fRentDress);
  Application.CreateForm(TfRentSetting, fRentSetting);
  Application.CreateForm(TdmRent, dmRent);
  Application.CreateForm(TfRentRegistr, fRentRegistr);
  Application.CreateForm(TfRentFitting, fRentFitting);
  Application.CreateForm(TfFitting, fFitting);
  Application.Run;
end.

