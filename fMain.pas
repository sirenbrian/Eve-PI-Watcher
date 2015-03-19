unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uEveCentralPrice,System.Generics.Collections,
  uPIPrice, Vcl.ComCtrls, Vcl.ExtCtrls, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, Vcl.Grids,
  Vcl.DBGrids;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnGetPrices: TButton;
    btnuseLast: TButton;
    btnViewData: TButton;
    Splitter1: TSplitter;
    pnlTop: TPanel;
    lvPI: TListView;
    memInputReport: TMemo;
    Splitter2: TSplitter;
    Button1: TButton;
    pcMain: TPageControl;
    tsDetails: TTabSheet;
    memDetails: TMemo;
    tsMarketOrders: TTabSheet;
    lvMarketBuy: TListView;
    Splitter3: TSplitter;
    Splitter5: TSplitter;
    lvMarketSell: TListView;
    tsMarketHistoryChart: TTabSheet;
    chtMarketHistory: TDBChart;
    Series1: TLineSeries;
    tsMarketHistory: TTabSheet;
    DBGrid3: TDBGrid;
    procedure btnGetPricesClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnViewDataClick(Sender: TObject);
    procedure btnuseLastClick(Sender: TObject);
    procedure lvPISelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure Button1Click(Sender: TObject);
    procedure lvPIColumnClick(Sender: TObject; Column: TListColumn);
    procedure Button2Click(Sender: TObject);
    procedure pcMainChange(Sender: TObject);
    procedure lvPICompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure FormShow(Sender: TObject);
    procedure lvMarketSellColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvMarketBuyColumnClick(Sender: TObject; Column: TListColumn);
    procedure lvMarketSellCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure lvMarketBuyCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
  private
    { Private declarations }
    function IsMarketOrderShowing:boolean;
    procedure DrawPrices;
    procedure ParsePriceJSON(sJSON:string);
    function GetSelectedPIItem:TPIPrice;
    procedure ShowMarketORders(iTypeID: integer=0);
    procedure DoShowMarketHistory;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
const
  LASTJSON='lastjson.txt';

implementation
uses uShared,dData,ioUtils,rest.json,system.json,fViewData,uProfitCalculator,
  uMarketOrders,uWatcherglobals, uMarketHistory;
{$R *.dfm}

procedure TfrmMain.btnGetPricesClick(Sender: TObject);
var
  sJSON:string;
begin
  dmData.FetchAllPrices;
  sJSON:=dmData.respPrices.JSONValue.ToString;
  ParsePriceJSON(sJSON); //Will load the FPrices into memory
  DrawPrices;
end;

procedure TfrmMain.btnuseLastClick(Sender: TObject);
var
  sJSON:string;
begin
  if fileexists(LASTJSON) then
  begin
    sJSON:=TFile.ReadAllText(LASTJSON);
    ParsePriceJSON(sJSON);

    DrawPrices;
  end;

end;

procedure TfrmMain.btnViewDataClick(Sender: TObject);
begin
  frmViewData.show;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
begin
  if fileexists(LASTJSON) then
    memDetails.text := TFile.ReadAllText(LASTJSON)
  else
    showmessage('Please click Fresh Prices first.');
end;

procedure TfrmMain.Button2Click(Sender: TObject);
begin
  ShowMarketOrders;
end;

procedure TfrmMain.ShowMarketORders(iTypeID:integer=0);
begin
  lvMarketSell.items.clear;
  lvMarketBuy.items.clear;
  if iTypeID = 0 then
    iTypeID:=GetSelectedPIItem.TypeID;
  FetchMarketOrders(iTypeID); //will load up the two object lists
  DrawMarketOrders(otSell,lvMarketSell);
  lvMarketSell.CustomSort(nil,giSellOrdersSortCol);
  DrawMarketOrders(otBuy,lvMarketBuy);
  lvMarketBuy.CustomSort(nil,gibuyOrderSortCol);
end;

procedure TfrmMain.DoShowMarketHistory;
var
  ja:TJSONArray;
  jv:TJSONValue;
  jo:TJSONObject;
  mh:TMarketHistory;
begin
  //try doing jsontoobject myself
  {"volume_str":"1","orderCount":1,"lowPrice":1498998.98,"highPrice":14989978.98,
  "avgPrice":14989978.98,"volume":1,
  "orderCount_str":"1","date":"2014-03-31T00:00:00"}
  ja := dmData.respMarketHistory.JSONValue as TJSONArray;
  dmData.mtMarketHistory.Close;
  dmData.mtMarketHistory.open;
  dmData.mtMarketHistory.BeginBatch;
  for jv in ja do
  begin
    jo := jv as TJSONObject;
    mh := TJson.JsonToObject<TMarketHistory>(jo,[joDateFormatISO8601]);
{
    ForderCount:integer;
    FlowPrice:currency;
    FhighPrice:currency;
    FavgPrice:currency;
    Fvolume:integer;
    Fdate:TDateTime;
}
    dmData.mtMarketHistory.InsertRecord([mh.ForderCount,mh.FlowPrice,mh.FhighPrice,
      mh.FavgPrice,mh.Fvolume,mh.Fdate]);
    mh.free;
  end;
  dmData.mtMarketHistory.EndBatch;
  chtMarketHistory.RefreshData;

end;

procedure TfrmMain.DrawPrices;
var
  aPI:TPIPrice;
  cCostB,cCostS:extended;
begin
  lvPI.items.clear;
  lvPI.items.BeginUpdate;
  try
    for aPI in FPrices do
    begin
      //%n = float but with , seperators
      with lvPI.items.add do
      begin
        caption := inttostr(aPI.PILevel);
        subitems.add(dmData.GetNameByTypeID(aPI.TypeID));
        subitems.add(format('%n',[aPI.sell.min])); //sell
        subitems.add(format('%n',[aPI.buy.max])); //buy
        //make (buy mats)
        cCostB := CostToBuildMaterialsBuy(aPI.TypeID);
        cCostS := CostToBuildMaterialsSell(aPI.TypeID);
        subitems.add(format('%n',[cCostB]));
        subitems.add(format('%n',[cCostS]));
        subitems.add(format('%n',[ProfitPerItemByTypeID(aPI.TypeID,cCostB)])); //profit calc from buy
        subitems.add(format('%n',[ProfitPerItemByTypeID(aPI.TypeID,cCostS)])); //profit calc from sell
        Data := aPI; //doesn't own it, just points to it.
      end;
    end;
    lvPI.CustomSort(nil,giTypesSortCol);
    SetAllListViewColumnsToMaxWidth(lvPI);
  finally
    lvPI.items.endupdate;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  FPrices := TObjectList<TPIPrice>.create;
  giTypesSortCol := 0; //PI Level
  gbTypesSortAscending := false;//go down from the top
  giSellOrdersSortCol:=0;//price
  gibuyOrderSortCol :=0;
  gbSellOrdersSortAscending :=true; //lowest seller at the top
  gbBuyOrdersSortAscending := false; //highest buyer at the top
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FPRices.free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  self.width := 1024;
  self.height := 768;
  pnlTop.height := self.height div 2;
  lvMarketSell.height := lvMarketSell.Parent.Height div 2;
  lvPI.width := self.width - 400;
  btnuseLast.click;
end;

function TfrmMain.GetSelectedPIItem: TPIPrice;
begin
  result := nil;
  if lvPI.Selected <> nil then
    result := TPIPrice(lvPI.selected.Data);
end;

function TfrmMain.IsMarketOrderShowing: boolean;
begin
  result := pcMain.activepage = tsMarketOrders;
end;

procedure TfrmMain.lvMarketBuyColumnClick(Sender: TObject; Column: TListColumn);
begin
  if Column.Index = gibuyOrderSortCol then
    gbBuyOrdersSortAscending:= not gbBuyOrdersSortAscending
  else
    gbBuyOrdersSortAscending:=true;

  gibuyOrderSortCol:= Column.Index;

  lvMarketBuy.CustomSort(nil, Column.Index);
end;

procedure TfrmMain.lvMarketBuyCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  iSortType:integer;
begin
  //price/vol/date
  //0=string, 1=integer,2=date,3=float.Replace with enumeration later
  if Data = 2 then //Name
    iSortType := 2
  else
    iSortType:= 5; //currency/ints
  Compare := SortListView(Item1,Item2,gbBuyOrdersSortAscending, Data,iSortType)
end;

procedure TfrmMain.lvMarketSellColumnClick(Sender: TObject;
  Column: TListColumn);
begin
  if Column.Index = giSellOrdersSortCol then
    gbSellOrdersSortAscending:= not gbSellOrdersSortAscending
  else
    gbSellOrdersSortAscending:=true;

  giSellOrdersSortCol := Column.Index;

  lvMarketSell.CustomSort(nil, Column.Index);
end;

procedure TfrmMain.lvMarketSellCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  iSortType:integer;
begin
  //price/vol/date
  //0=string, 1=integer,2=date,3=float.Replace with enumeration later
  if Data = 2 then //Name
    iSortType := 2
  else
    iSortType:= 5; //currency/ints
  Compare := SortListView(Item1,Item2,gbSellOrdersSortAscending, Data,iSortType)
end;

procedure TfrmMain.lvPIColumnClick(Sender: TObject; Column: TListColumn);
begin
  if Column.Index = giTypesSortCol then
    gbTypesSortAscending := not gbTypesSortAscending
  else
    gbTypesSortAscending:=true;

  giTypesSortCol := Column.Index;

  lvPI.CustomSort(nil, Column.Index);
end;

procedure TfrmMain.lvPICompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
var
  iSortType:integer;
begin
  //0=string, 1=integer,2=date,3=float.Replace with enumeration later
  if Data = 1 then //Name
    iSortType := 0
  else
    iSortType:= 5; //currency
  Compare := SortListView(Item1,Item2,gbTypesSortAscending, Data,iSortType)
end;

procedure TfrmMain.lvPISelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  aPI : TPIPrice;
  ilp:integer;
begin
  if Item = nil then
    exit;

  memInputReport.text := '';
  memDetails.text := '';

  if lvPI.SelCount = 0 then
    exit;

  for ilp := 0 to lvPI.items.count-1 do
  begin
    if not lvPI.items[ilp].selected then
      continue;
    //it's selected, get the deets
    aPI := TPIPrice(lvPI.Items[ilp].Data);
    if aPI = nil then
      exit;
    memInputReport.text := memInputReport.text+#13#10#13#10+InputReport(aPI.typeid);
    memDetails.text := memDetails.text+ #13#10#13#10+aPI.AsString;
  end;
  if IsMarketOrderShowing then
    ShowMarketOrders;
//Show market history
  dmData.reqMarketHistory.Params.ParameterByName('typeid').value := inttostr(aPI.TypeID);
  dmData.reqMarketHistory.Execute;
  DoShowMarketHistory; //Not a Happy-Path, so we need to catch the response, parse and show it

end;

procedure TfrmMain.ParsePriceJSON(sJSON: string);
var
  ja:TJSONArray;
  jv:TJSONValue;
  jo:TJSONObject;
  aItem:TPIPrice;
begin
  FPrices.clear;
  ja := TJSONObject.ParseJSONValue(sJSON) as TJSONArray;
  for jv in ja do
  begin
    jo := jv as TJSONObject;
    aItem := TJSON.JSONToObject<TPIPrice>(jo);
    aItem.RawJSON := TJSON.ObjectToJsonString(aItem);
    aItem.Name := dmData.GetNameByTypeID(aItem.TypeID);
    aItem.PILevel := dmData.GetLevelByTypeID(aItem.TypeID);
    FPrices.add(aItem);
  end;

end;

procedure TfrmMain.pcMainChange(Sender: TObject);
begin
  if pcMain.ActivePage = tsMarketOrders then
    ShowMarketOrders;
end;

end.
