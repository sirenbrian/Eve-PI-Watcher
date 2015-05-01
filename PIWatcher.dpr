program PIWatcher;



uses
  Vcl.Forms,
  fMain in 'fMain.pas' {frmMain},
  dData in 'dData.pas' {dmData: TDataModule},
  fViewData in 'fViewData.pas' {frmViewData},
  uEveCentralPrice in 'uEveCentralPrice.pas',
  uPIPrice in 'uPIPrice.pas',
  uProfitCalculator in 'uProfitCalculator.pas',
  uRTTIUtils in 'uRTTIUtils.pas',
  uWatcherGlobals in 'uWatcherGlobals.pas',
  uMarketOrders in 'uMarketOrders.pas',
  ushared in 'ushared.pas',
  uMarketHistory in 'uMarketHistory.pas',
  fSearch in 'fSearch.pas' {frmSearch},
  fEveStatic in 'fEveStatic.pas',
  dEveStatic in 'dEveStatic.pas',
  uMarketGroups in 'uMarketGroups.pas',
  uClientDataSetUtils in 'uClientDataSetUtils.pas',
  fMetaFilter in 'fMetaFilter.pas' {frmMetafilter};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmData, dmData);
  Application.CreateForm(TdmEveStatic, dmEveStatic);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmViewData, frmViewData);
  Application.CreateForm(TfrmMetafilter, frmMetafilter);
  Application.Run;
end.
