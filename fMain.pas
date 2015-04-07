unit fMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,uEveCentralPrice,System.Generics.Collections,
  uPIPrice, Vcl.ComCtrls, Vcl.ExtCtrls, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart, Vcl.Grids,
  Vcl.DBGrids, Vcl.Menus, Data.DB,uMarketGroups;

type
  TfrmMain = class(TForm)
    Splitter1: TSplitter;
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
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    ManageStatic1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    tsAnyItem: TTabSheet;
    Panel1: TPanel;
    btnGetPrices: TButton;
    btnuseLast: TButton;
    btnViewData: TButton;
    Button1: TButton;
    btnNameSearch: TButton;
    btnShowChildren: TButton;
    Button2: TButton;
    pnlTop: TPanel;
    Splitter2: TSplitter;
    lvPI: TListView;
    memInputReport: TMemo;
    Panel2: TPanel;
    tsManufacture: TTabSheet;
    Panel3: TPanel;
    dbgWatchList: TDBGrid;
    Actions1: TMenuItem;
    InitBuildandWatch1: TMenuItem;
    btnPopulateWatchList: TButton;
    txtSearch: TEdit;
    btnSearch: TButton;
    DBGrid1: TDBGrid;
    dsAllTypes: TDataSource;
    Button3: TButton;
    btnDeleteFromWatchList: TButton;
    tvMarketGroups: TTreeView;
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
    procedure btnNameSearchClick(Sender: TObject);
    procedure btnShowChildrenClick(Sender: TObject);
    procedure ManageStatic1Click(Sender: TObject);
    procedure InitBuildandWatch1Click(Sender: TObject);
    procedure btnPopulateWatchListClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure btnDeleteFromWatchListClick(Sender: TObject);
    procedure tvMarketGroupsExpanded(Sender: TObject; Node: TTreeNode);
    procedure tvMarketGroupsClick(Sender: TObject);
  private
    { Private declarations }
    FMarketGroups:TMarketGroupManager;
    function IsMarketOrderShowing:boolean;
    function IsMarketHistoryShowing:boolean;
    procedure DrawPrices(iParentTypeID:integer=-1);
    procedure ParsePriceJSON(sJSON:string);
    procedure ParsePriceWatchList(sJSON:string);
    function GetSelectedPIItem:TPIPrice;
    procedure ShowMarketORders(iTypeID: integer=0);
    procedure DoShowMarketHistory;
    procedure RenderGroupToTreeNode(aParentNode: TTreeNode);
    procedure RenderRootMarketGroupsToTree;
    procedure DoExtractMarketGroups;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
const
  LASTJSON='lastpijson.txt';
  WATCHLIST='watch.bin';
  BUILDLIST='build.bin';
implementation
uses uShared,dData,ioUtils,rest.json,system.json,fViewData,uProfitCalculator,
  uMarketOrders,uWatcherglobals, uMarketHistory, fSearch,
  FireDAC.Stan.Intf, dEveStatic;
{$R *.dfm}

procedure TfrmMain.btnDeleteFromWatchListClick(Sender: TObject);
begin
  if dmData.fdmWatchList.RecNo>-1 then
    dmData.fdmWatchlist.Delete;
end;

procedure TfrmMain.btnGetPricesClick(Sender: TObject);
var
  sJSON:string;
begin
  dmData.FetchPIPrices;
  sJSON:=dmData.respPrices.JSONValue.ToString;
  ParsePriceJSON(sJSON); //Will load the FPrices into memory
  DrawPrices;
end;

procedure TfrmMain.btnNameSearchClick(Sender: TObject);
var
  frm:TfrmSearch;
begin
  frm:=TfrmSearch.create(nil);
  try
    frm.showmodal;
  finally
    frm.free;
  end;
end;

procedure TfrmMain.btnPopulateWatchListClick(Sender: TObject);
var
  sJSON:string;
begin
  dmData.FetchWatchListPrices;
  sJSON:=dmData.respPrices.JSONValue.ToString;
  ParsePriceWatchList(sJSON); //Will load the FPrices into memory
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
begin
  if length(txtSearch.text) >= 3 then
  begin
    dmEveStatic.fdmAllTypes.Filter := 'UPPER(typeName) like ''%'+uppercase(txtSearch.text)+'%''';
    dmEveStatic.fdmAllTypes.Filtered := true;
  end;
end;

procedure TfrmMain.btnShowChildrenClick(Sender: TObject);
var
  aPI:TPIPrice;
begin
  aPI := TPIPrice(lvPI.Selected.Data);

  DrawPrices(aPI.typeid);
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

procedure TfrmMain.Button3Click(Sender: TObject);
begin
  if not dmData.fdmWatchList.active then
    dmData.fdmWatchList.active := true;
  dmData.fdmWatchList.Append;
  dmData.fdmWatchListtypeID.asinteger := dmEveStatic.fdmAllTypestypeID.asinteger;
  dmData.fdmWatchList.Post;
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

procedure TfrmMain.tvMarketGroupsClick(Sender: TObject);
var
  aGroup:TMarketGroup;
  sGroupID:string;
begin
  if tvMarketGroups.selected = nil then
    exit;
  aGroup:=TMarketGroup(tvMarketGroups.selected.data);
  sGroupID:=aGroup.GroupID;
  dmEveStatic.fdmAllTypes.filter := 'groupID='+sGroupID;
  dmEveStatic.fdmAllTypes.filtered := true;
end;

procedure TfrmMain.tvMarketGroupsExpanded(Sender: TObject; Node: TTreeNode);
begin
  //User wants to see the contents, so draw them.
  RenderGroupToTreeNode(Node);
end;

procedure TfrmMain.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(key) = VK_RETURN then
    btnSearchclick(nil);
end;

procedure TfrmMain.DoShowMarketHistory;
var
  ja:TJSONArray;
  jv:TJSONValue;
  jo:TJSONObject;
  mh:TMarketHistory;
  dtEarliestDate:TDateTime;
begin
  //try doing jsontoobject myself
  {"volume_str":"1","orderCount":1,"lowPrice":1498998.98,"highPrice":14989978.98,
  "avgPrice":14989978.98,"volume":1,
  "orderCount_str":"1","date":"2014-03-31T00:00:00"}
  dtEarliestDate := now - 180;
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
    if mh.Fdate >= dtEarliestDate then
      dmData.mtMarketHistory.InsertRecord([mh.ForderCount,mh.FlowPrice,mh.FhighPrice,
        mh.FavgPrice,mh.Fvolume,mh.Fdate]);
    mh.free;
  end;
  dmData.mtMarketHistory.EndBatch;
  chtMarketHistory.RefreshData;

end;

procedure TfrmMain.DrawPrices(iParentTypeID:integer=-1);
var
  aPI:TPIPrice;
  cCostB,cCostS:extended;
  bAdd:boolean;
begin
  lvPI.items.clear;
  lvPI.items.BeginUpdate;
  //Get a list of the typeIDs that are inputs into iParentTypeID.
  //Only draw each item in FPrices if its in that list.
  try
    for aPI in FPrices do
    begin
      if (iParentTypeID = -1) or (iParentTypeID = aPI.TypeID) then
        bAdd := true
      else
        bAdd := dmData.IsParentOf(iParentTypeID,aPI.TypeID);
      if not bAdd then
        continue;
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
  FMarketGroups:= TMarketGroupManager.create;
  FPrices := TObjectList<TPIPrice>.create;
  giTypesSortCol := 0; //PI Level
  gbTypesSortAscending := false;//go down from the top
  giSellOrdersSortCol:=0;//price
  gibuyOrderSortCol :=0;
  gbSellOrdersSortAscending :=true; //lowest seller at the top
  gbBuyOrdersSortAscending := false; //highest buyer at the top
{  if FileExists(BUILDLIST) then
  begin
    dmData.fdmBuildList.CreateDataSet;
    dmData.fdmBuildList.LoadFromFile(BUILDLIST);
  end;
  }
  if FileExists(WATCHLIST) then
  begin
    dmData.fdmWatchList.CreateDataSet;
    dmData.fdmWatchList.LoadFromFile(WATCHLIST);
  end;
  DoExtractMarketGroups;
//  cdsMarketGroups.LoadFromFile('marketgroups.xml');
  RenderRootMarketGroupsToTree; //Draw just the root nodes to the tree

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FPRices.free;
  FMarketGroups.free;

  dmData.fdmBuildList.SaveToFile(BUILDLIST,sfbinary);
  dmData.fdmWatchList.SaveToFile(WATCHLIST,sfbinary);
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

procedure TfrmMain.InitBuildandWatch1Click(Sender: TObject);
begin
  with dmData.fdmWatchList do
  begin
    if not Active then
      Active := true;
    Append;
    fieldbyname('typeID').asinteger := 2454;
    Append;
    fieldbyname('typeID').asinteger := 2456;
    Post;
  end;
end;

function TfrmMain.IsMarketHistoryShowing: boolean;
begin
  result := (pcMain.activepage = tsMarketHistory) or
    (pcMain.activepage = tsMarketHistoryChart);
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
  aPI:=nil;
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
  if (aPI<> nil) and IsMarketHistoryShowing then
  begin
    dmData.reqMarketHistory.Params.ParameterByName('typeid').value := inttostr(aPI.TypeID);
    dmData.reqMarketHistory.Execute;
    DoShowMarketHistory; //Not a Happy-Path, so we need to catch the response, parse and show it
  end;
end;

procedure TfrmMain.ManageStatic1Click(Sender: TObject);
//var
//  frm:TfrmEveStatic;
begin
{
  frm:=TfrmEveStatic.create(nil);
  try
    frm.showmodal;
  finally
    frm.free;
  end;
  }
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
//    aItem.RawJSON := TJSON.ObjectToJsonString(aItem);
    aItem.Name := dmData.GetNameByTypeID(aItem.TypeID);
    aItem.PILevel := dmData.GetLevelByTypeID(aItem.TypeID);
    FPrices.add(aItem);
  end;
end;

procedure TfrmMain.ParsePriceWatchList(sJSON: string);
var
  ja:TJSONArray;
  jv:TJSONValue;
  jo:TJSONObject;
  aItem:TPIPrice;
begin
  ja := TJSONObject.ParseJSONValue(sJSON) as TJSONArray;

  for jv in ja do
  begin
    jo := jv as TJSONObject;
    aItem := TJSON.JSONToObject<TPIPrice>(jo);
//    aItem.RawJSON := TJSON.ObjectToJsonString(aItem);
    aItem.Name := dmData.GetNameByTypeID(aItem.TypeID);
    with dmData.fdmWatchList do
    begin
      Locate('typeID',aItem.TypeID);
      dmData.fdmWatchList.Edit;
      FieldByName('MinSell').AsCurrency := aItem.sell.min;
      FieldByName('MaxBuy').AsCurrency := aItem.buy.max;
    end;
    aItem.free;
  end;
  dmData.fdmWatchList.Post;
end;

procedure TfrmMain.pcMainChange(Sender: TObject);
begin
  if pcMain.ActivePage = tsMarketOrders then
    ShowMarketOrders;
end;

procedure TfrmMain.RenderRootMarketGroupsToTree;
begin
  tvMarketGroups.items.clear;
  RenderGroupToTreeNode(nil);
end;

procedure TfrmMain.RenderGroupToTreeNode(aParentNode:TTreeNode);
var
  aNode:TTreeNode;
  aGroup:TMarketGroup;
  sParentHREF:string;
begin
  tvMarketGroups.Items.BeginUpdate;
  if aParentNode = nil then
    sParentHREF:=''
  else
  begin
    sparentHREF:= TMarketGroup(aParentNode.data).href;
    if aParentNode.Item[0].Text='Loading...' then
      aParentNode.DeleteChildren;
  end;

  for aGroup in FMarketGroups do
  begin
    if aGroup.parentgroup=sParentHREF then
    begin
      aNode := tvMarketGroups.items.addchildobject(aParentNode,aGroup.name,aGroup);
      //Add a child stub so it can be expanded. On expansion, we'll populate the children
      tvMarketGroups.items.addchild(aNode,'Loading...');
    end;
  end;
  tvMarketGroups.items.endupdate;
  {
  while not cdsMarketGroups.eof do
  begin
    if cdsMarketGroups.fieldbyname('parentGroup').asstring = '' then
      arelNode := nil
    else
      aRelNode := tvMarketGroups.Items.get
    aNode:= tvMarketGroups.Items.Add(nil,cdsMarketGroups.FieldByName('name').AsString);
    aNode.data := pointer(cdsMarketGroups.RecNo);
  end;
  }
end;

procedure TfrmMain.DoExtractMarketGroups;
var
  jvArr:TJSONArray;
  jvSource:TJsonObject;
  jvGroup:TJSONValue;
  jvObject:TJSONObject;
  jvPair:TJSONPair;
  sfieldname,svalue,sRawJson,sTemp,sName:string;
  jvValue:TJSONValue;
  jvPairEnum:TJSONPairEnumerator;
  fField:TField;
  sl:TStringList;
  ilp:integer;
  aGroup:TMarketGroup;
begin
  //Use JSON utils to parse the market groups, since they have a variable
  //number of elements and the automatic RESTtoDatasetAdapter can't handle it
  {
  I partly copied sample code FROM http://www.dave-gill.co.uk/blog/2013/08/13/json-and-delphi-xe4
}
  sRawJSON:=TFile.readalltext('rawmarketgroups.txt');

  //jvSource := resMarketGroups.JSONValue;
  jvSource := TJSONObject.ParseJSONValue(sRawJSON) as TJSONObject;
  jvARR := jvSource.GetValue('items') as TJSONArray;
  for jvGroup in jvArr do
  begin
    jvObject := TJSONObject(jvGroup);
    //To Do later - use json to object. will need to include TJSONInterceptor to handle
    //catching the types / href situation.

    //TJSON.JSONtoObject<TMarketGroup>(jvObject
    //parentGroup, is missing from root level groups.
    aGroup := TMarketGroup.create;
    for ilp := 0 to jvObject.Count-1 do
    begin
      sFieldName:=jvObject.pairs[ilp].jsonstring.tostring;
      if sFieldName='"types"' then
      begin
        sFieldName := 'typeshref';
        sValue := jvObject.Pairs[ilp].jsonvalue.GetValue<string>('href');
      end
      else if sFieldName = '"parentGroup"' then
        sValue := jvObject.Pairs[ilp].jsonvalue.GetValue<string>('href')
      else
        sValue := jvObject.pairs[ilp].jsonvalue.tostring;
      sfieldName := AnsiDeQuotedStr(sFieldName,'"');
      sValue := AnsiDeQuotedStr(sValue,'"');
      if sFieldName = 'href' then
        aGroup.href := sValue
      else if sFieldName = 'name' then
        aGroup.name := sVAlue
      else if sFieldName = 'description' then
        aGroup.description:= sVAlue
      else if sFieldName = 'typeshref' then
        aGroup.typeshref := sVAlue
      else if sFieldName = 'parentGroup' then
        aGroup.parentGroup:= sVAlue;
    end;
    //aGroup should be fully populate now. Add it to the manager
    FMarketGroups.Add(aGroup);
  end;
end;

end.
