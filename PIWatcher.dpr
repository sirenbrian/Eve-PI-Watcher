program PIWatcher;

uses
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  dData in 'dData.pas' {dmData: TDataModule},
  fImportData in 'fImportData.pas' {Form2},
  fViewData in 'fViewData.pas' {frmViewData},
  uEveCentralPrice in 'uEveCentralPrice.pas',
  uPIPrice in 'uPIPrice.pas',
  uProfitCalculator in 'uProfitCalculator.pas',
  uRTTIUtils in 'uRTTIUtils.pas',
  uWatcherGlobals in 'uWatcherGlobals.pas',
  uMarketOrders in 'uMarketOrders.pas',
  ushared in 'ushared.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmViewData, frmViewData);
  Application.Run;
end.
