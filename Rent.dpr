program Rent;

uses
  Forms,
  RentMain in 'RentMain.pas' {fMainRent},
  RentDM in 'RentDM.pas' {dmRent: TDataModule},
  RentSetting in 'RentSetting.pas' {fRentSetting},
  RentRegistr in 'RentRegistr.pas' {fRentRegistr};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Rent 1.0';
  Application.CreateForm(TfRentSetting, fRentSetting);
  Application.CreateForm(TfMainRent, fMainRent);
  Application.CreateForm(TdmRent, dmRent);
  Application.CreateForm(TfRentRegistr, fRentRegistr);
  Application.Run;
end.
