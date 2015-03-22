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
  ushared in 'ushared.pas',
  uMarketHistory in 'uMarketHistory.pas',
  uLoadEveRefData in 'uLoadEveRefData.pas',
  fSearch in 'fSearch.pas' {frmSearch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TfrmViewData, frmViewData);
  Application.CreateForm(TfrmSearch, frmSearch);
  Application.Run;
end.
