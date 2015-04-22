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
    pcLower: TPageControl;
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
    pcMain: TPageControl;
    tsPI: TTabSheet;
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
    lvPI: TListView;
    Panel2: TPanel;
    dbgWatchList: TDBGrid;
    Actions1: TMenuItem;
    InitBuildandWatch1: TMenuItem;
    btnPopulateWatchList: TButton;
    btnDeleteFromWatchList: TButton;
    splB: TSplitter;
    tsInputs: TTabSheet;
    memInputReport: TMemo;
    Button3: TButton;
    pnlGroupandSearch: TPanel;
    tvMarketGroups: TTreeView;
    splA: TSplitter;
    pnlSearch: TPanel;
    lblSearchCount: TLabel;
    txtSearch: TEdit;
    btnSearch: TButton;
    btnAddToWatchList: TButton;
    btnFindGroup: TButton;
    btnFindGroupFromWatchlist: TButton;
    Button4: TButton;
    rbInGroup: TRadioButton;
    rbAllTypes: TRadioButton;
    lvSearchResults: TListView;
    btnSave: TButton;
    btnLoad: TButton;
    btnClearWatchList: TButton;
    btnAddGroup: TButton;
    cmbFiles: TComboBox;
    chkTech1: TCheckBox;
    rbChildGroups: TRadioButton;
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
    procedure pcLowerChange(Sender: TObject);
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
    procedure btnAddToWatchListClick(Sender: TObject);
    procedure txtSearchKeyPress(Sender: TObject; var Key: Char);
    procedure btnDeleteFromWatchListClick(Sender: TObject);
    procedure tvMarketGroupsClick(Sender: TObject);
    procedure tvMarketGroupsExpanding(Sender: TObject; Node: TTreeNode;
      var AllowExpansion: Boolean);
    procedure dbgWatchListCellClick(Column: TColumn);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Button3Click(Sender: TObject);
    procedure dbgWatchListTitleClick(Column: TColumn);
    procedure btnFindGroupClick(Sender: TObject);
    procedure btnFindGroupFromWatchlistClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnClearWatchListClick(Sender: TObject);
    procedure btnAddGroupClick(Sender: TObject);
    procedure cmbFilesSelect(Sender: TObject);
    procedure DBGrid3TitleClick(Column: TColumn);
  private
    { Private declarations }
    FMarketGroups:TMarketGroupManager;
    aSearchRoot:TTreeNode;
    sAllSearchString: string;
    procedure ViewSearchResults;
    procedure ShowGroupForTypeID(iTypeID:integer);
    function GetCurrentSelectedtypeID:integer;
    function GetGroupSearchFilter(aNode:TTreeNode;bRecurse:boolean;var sSearchString:string): boolean;
    procedure SetWatchlistSearchFilter(sFilter:string);
    function IsMarketOrderShowing:boolean;
    function IsMarketHistoryShowing:boolean;
    procedure DrawPrices(iParentTypeID:integer=-1);
    procedure ParsePriceJSON(sJSON:string);
    procedure ParsePriceWatchList(sJSON:string);
    function GetSelectedPIItem:TPIPrice;
    procedure ShowMarketORders(iTypeID: integer=0);
    procedure DoShowMarketHistory(itypeID:integer);
    procedure RenderGroupToTreeNode(aParentNode: TTreeNode);
    procedure RenderRootMarketGroupsToTree;
    procedure DoExtractMarketGroups;
    procedure ShowInformation(iTypeID:integer=-1);
    procedure PopulateFileList;
    procedure GetMarketChildIDs(aThisnode: TTreeNode);
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
implementation
uses uShared,dData,ioUtils,rest.json,system.json,fViewData,uProfitCalculator,
  uMarketOrders,uWatcherglobals, uMarketHistory, fSearch,
  FireDAC.Stan.Intf, dEveStatic, uClientDataSetUtils;
{$R *.dfm}

procedure TfrmMain.btnClearWatchListClick(Sender: TObject);
begin
  dmData.ClearWatchList;
end;

procedure TfrmMain.btnDeleteFromWatchListClick(Sender: TObject);
begin
  if dmData.fdmWatchList.RecNo>-1 then
    dmData.fdmWatchlist.Delete;
end;

procedure TfrmMain.btnFindGroupClick(Sender: TObject);
var
  sTargetGroup: string;
  aNode:TTreeNode;
  aGroup:TMarketGroup;
begin
  //ShowGroupForTypeID(dmEveStatic.fdmAllTypestypeID.value);
  ShowGroupForTypeID(lvSearchresults.selected.subitems[0].ToInteger);
end;

procedure TfrmMain.btnFindGroupFromWatchlistClick(Sender: TObject);
begin
  if dmData.fdmWatchList.RecNo > -1 then
    ShowGroupForTypeID(dmData.fdmWatchListtypeID.value)
  else
    showmessage('Please choose a record in the watch list first.');
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

procedure TfrmMain.btnLoadClick(Sender: TObject);
var
  sfile: string;
begin
  if InputQuery('filename','filename',sfile) then
  begin
    dmData.fdmWatchList.LoadFromFile(sfile+'.bin',sfBinary);
  end;
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
  ParsePriceWatchList(sJSON);
end;

procedure TfrmMain.btnSaveClick(Sender: TObject);
var
  sfile: string;
begin
  if InputQuery('filename','filename',sfile) then
  begin
    dmData.fdmWatchList.SaveToFile(sfile+'.bin',sfBinary);
    PopulateFileList;
  end;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
var
  sGroupFilter,sFilter :string;
  aItem:TListItem;
begin
  sFilter := '';
  if length(txtSearch.text) >= 3 then
  begin
    sFilter := 'UPPER(typeName) like ''%'+uppercase(txtSearch.text)+'%''';
    if rbInGroup.checked or rbChildGroups.checked then
    begin
      GetGroupSearchFilter(nil,rbChildGroups.Checked,sGroupFilter);
      //If nothing was selected in the group list, we'll search all names
      if sGroupFilter > '' then
        sFilter := sFilter + ' and '+sGroupFilter;
    end;
  end;
  if sFilter > '' then
  begin
    SetWatchListSearchFilter(sFilter);
    ViewSearchResults;
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
  pnlGroupandSearch.visible := not pnlGroupandSearch.visible;
end;

procedure TfrmMain.Button4Click(Sender: TObject);
var
  sJSON:string;
begin
  if fileexists(LASTWATCHJSON) then
  begin
    sJSON:=TFile.ReadAllText(LASTWATCHJSON);
    ParsePriceWatchList(sJSON);

//    DrawPrices;
  end;

end;

procedure TfrmMain.cmbFilesSelect(Sender: TObject);
begin
  dmData.fdmWatchList.LoadFromFile(cmbFiles.text,sfBinary);
  btnPopulateWatchList.click;
end;

procedure TfrmMain.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if ord(key) = VK_RETURN then
    btnAddToWatchList.click;
end;

procedure TfrmMain.DBGrid3TitleClick(Column: TColumn);
begin
  SortFDMemTable(dmData.mtMarketHistory,Column);
end;

procedure TfrmMain.dbgWatchListCellClick(Column: TColumn);
begin
  ShowInformation;
end;

procedure TfrmMain.dbgWatchListTitleClick(Column: TColumn);
begin
  //SortClientDataSet(dmData.fdmWatchList.data,Column.FieldName);
//  if Column.Field.FieldKind = fkData then
  SortFDMemTable(dmData.fdmWatchList,Column);
 // else
   // ShowMessage('Cannot sort by that column because of the FieldKind being not fkData.');
end;

procedure TfrmMain.btnAddGroupClick(Sender: TObject);
var
  sFilter: string;
begin
  //Add all the items in a group to the current watch list
  GetGroupSearchFilter(nil,rbChildGroups.Checked,sFilter);
  if sFilter = '' then
    showmessage('No group selected, please choose one.')
  else
  begin
    SetWatchlistSearchFilter(sFilter);
    dmEveStatic.fdmAllTypes.findfirst;

    while dmEveStatic.fdmAllTypes.Found do
    begin
      dmData.AddTypeIDToWatchList(dmEveStatic.fdmAllTypestypeID.AsInteger);
      dmEveStatic.fdmAllTypes.findnext;
    end;
  end;
end;

procedure TfrmMain.btnAddToWatchListClick(Sender: TObject);
var
  iVal:integer;
  aItem:TListItem;
begin
  if not dmData.fdmWatchList.active then
    dmData.fdmWatchList.active := true;
  //iVal:=dmEveStatic.fdmAllTypestypeID.asinteger;
  for aItem in lvSearchResults.items do
  begin
    if aItem.Selected then
    begin
      dmData.AddTypeIDToWatchList(aItem.SubItems[0].toInteger);
    end;
  end;
end;

procedure TfrmMain.SetWatchlistSearchFilter(sFilter: string);
begin
  dmEveStatic.fdmAllTypes.Filter := sFilter;
  dmEveStatic.fdmAllTypes.Filtered := true;
  lblSearchCount.caption := dmEveStatic.fdmAllTypes.RecordCount.ToString;
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
  sFilter:string;
begin
  if tvMarketGroups.selected = nil then
    exit;
  GetGroupSearchFilter(nil,false,sFilter);
//  memDetails.Text := sFilter;
  SetWatchlistSearchFilter(sFilter);
  ViewSearchResults;
end;

procedure TfrmMain.tvMarketGroupsExpanding(Sender: TObject; Node: TTreeNode;
  var AllowExpansion: Boolean);
begin
//  RenderGroupToTreeNode(Node);
end;

procedure TfrmMain.txtSearchKeyPress(Sender: TObject; var Key: Char);
begin
  if ord(key) = VK_RETURN then
    btnSearchclick(nil);
end;

procedure TfrmMain.ViewSearchResults;
var
  aItem:TListItem;
begin
  lvSearchResults.clear;
  dmEveStatic.fdmAllTypes.first;

  while not dmEveStatic.fdmAllTypes.eof do
  begin
    aItem:=lvSearchResults.Items.add;
    aItem.caption := dmEveStatic.fdmAlltypestypename.Value;
    aItem.subitems.add(dmEveStatic.fdmAllTypestypeID.asstring);
    dmEveStatic.fdmAllTypes.next;
  end;
end;

procedure TfrmMain.DoShowMarketHistory(itypeID:integer);
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
  dmData.reqMarketHistory.Params.ParameterByName('typeid').value := inttostr(iTypeID);
  dmData.reqMarketHistory.Execute;
  chtMarketHistory.Title.Text.Text := dmData.GetNameByTypeID(iTypeID);
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
        subitems.add(format('%n',[aPI.Minsell])); //sell
        subitems.add(format('%n',[aPI.Maxbuy])); //buy
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
{  if FileExists(WATCHLIST) then
  begin
    dmData.fdmWatchList.CreateDataSet;
    dmData.fdmWatchList.LoadFromFile(WATCHLIST);
  end;
  }
  DoExtractMarketGroups;
//  cdsMarketGroups.LoadFromFile('marketgroups.xml');
  RenderRootMarketGroupsToTree; //Draw just the root nodes to the tree

end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  FPRices.free;
  FMarketGroups.free;

  dmData.fdmBuildList.SaveToFile(BUILDLIST,sfbinary);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  self.width := 1024;
  self.height := 768;
  pnlTop.height := self.height div 2;
  lvMarketSell.height := lvMarketSell.Parent.Height div 2;
  lvPI.width := self.width - 400;
  btnuseLast.click;
  PopulateFileList;
end;

function TfrmMain.GetCurrentSelectedtypeID: integer;
begin
  result := -1;
  if pcMain.activepage = tsPI then
  begin
    if lvPI.selected = nil then
      exit;

    result := TPIPrice(lvPI.selected.Data).TypeID;
  end
  else if pcMain.activepage = tsAnyItem then
    result := dmData.fdmWatchListtypeID.asinteger;
end;

procedure TfrmMain.GetMarketChildIDs(aThisnode:TTreeNode);
var
  NextNode:TTreeNode;
begin
  if aThisnode <> nil then
  begin
    sAllSearchString := sAllSearchString + TMarketGroup(aThisNode.data).GroupID+',';
    //sAllSearchString := sAllSearchString+ aThisNode.text+crlf;
    NextNode := nil;
    if aThisNode.HasChildren then
    begin
      NextNode := aThisNode.getfirstchild;
      GetMarketChildIDs(NextNode);
    end;
    if (aThisNode <> aSearchRoot) and (aThisNode.getNextSibling <> nil) then
    begin
      NextNode := aThisNode.getnextsibling;
      GetMarketChildIDs(NextNode);
    end
    else
    {    NextNode := aThisNode.getfirstchild;
    while NextNode <> nil do
    begin
      sAllSearchString := sAllSearchString+ NextNode.text+crlf;
      GetMarketChildIDs(NextNode.getFirstChild);
      NextNode := NextNode.getNextSibling;
    end;
    }
  end;
end;

function TfrmMain.GetGroupSearchFilter(aNode:TTreeNode;bRecurse:boolean;var sSearchString:string): boolean;
var
  aGroup:TMarketGroup;
begin
  //I can use "IN" construct to look for many marketGroupIDs
  result := false;
  if aNode = nil then
    aNode := tvMarketGroups.Selected;
  if aNode <> nil then
  begin
  aSearchRoot := aNode; //Mark our stopping point.
  sAllSearchString:='';
    if bRecurse then
    begin
      GetMarketChildIDs(aNode);
      sSearchString := 'marketGroupID in ('+rightcontrim(sAllSearchString,',')+')';
      //sSearchString := sSearchString + aNode.text+',';
      {
      if aNode.HasChildren then
        aNode := aNode.getfirstchild
      else if aNode.getNextSibling <> nil then
        aNode := aNode.getnextsibling
      else
        aNode := nil;
      if aNode <> nil then
        GetGroupSearchFilter(aNode,bRecurse,sSearchString)
      else
        sSearchString := 'marketGroupID in ('+rightcontrim(sSearchString,',')+')';
        }
    end
    else
    begin
      aGroup:=TMarketGroup(aNode.data);
      sSearchString :='marketGroupID='+aGroup.GroupID;
    end;
  end
  else
    result := False;
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
  result := (pcLower.activepage = tsMarketHistory) or
    (pcLower.activepage = tsMarketHistoryChart);
end;

function TfrmMain.IsMarketOrderShowing: boolean;
begin
  result := pcLower.activepage = tsMarketOrders;
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
begin
  if Selected then
    ShowInformation;
end;

procedure TfrmMain.ShowGroupForTypeID(iTypeID: integer);
var
  sTargetGroup: string;
  aNode: TTreeNode;
  aGroup: TMarketGroup;
begin
  if dmEveStatic.fdmAllTypes.locate('typeID',iTypeID) then
  begin
    sTargetGroup := dmEveStatic.fdmAllTypesmarketGroupID.AsString;
    for aNode in tvMarketGroups.items do
    begin
      aGroup := TMarketGroup(aNode.Data);
      if aGroup.GroupID = sTargetgroup then
      begin
        aNode.MakeVisible;
        aNode.Selected := true;
        break;
      end;
    end;
  end;
end;

procedure TfrmMain.ShowInformation(iTypeID:integer=-1);
var
  ilp:integer;
begin
  if iTypeID=-1 then
    iTypeID := GetCurrentSelectedTypeID;
  if iTypeID = -1 then
  begin
    showmessage('Could not determine selected type id');
    exit;
  end;

  memInputReport.text := InputReport(iTypeID);
//    memDetails.text := aPI.AsString;

  if IsMarketOrderShowing then
    ShowMarketOrders(iTypeID);
//Show market history
  if IsMarketHistoryShowing then
  begin
    DoShowMarketHistory(iTypeID); //Not a Happy-Path, so we need to catch the response, parse and show it
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
    //aItem := TJSON.JSONToObject<TPIPrice>(jo);
    aItem := ParseECPrice(jo.ToJSON);
//    aItem.RawJSON := TJSON.ObjectToJsonString(aItem);
    //aItem.Name := dmData.GetNameByTypeID(aItem.TypeID);
    aItem.PILevel := dmData.GetLevelByTypeID(aItem.TypeID);
    FPrices.add(aItem);
  end;
end;

procedure TfrmMain.ParsePriceWatchList(sJSON: string);
var
  ja:TJSONArray;
  jv:TJSONValue;
  jo:TJSONObject;
  aNewItem,aItem:TPIPrice;

begin
  ja := TJSONObject.ParseJSONValue(sJSON) as TJSONArray;
  FPrices.clear;
  for jv in ja do
  begin
    jo := jv as TJSONObject;
    //aNewItem:= TJSON.JSONToObject<TPIPrice>(jo);
    aNewItem:=ParseECPrice(jo.ToJSON);
    if aNewItem<> nil then
      FPrices.add(aNewItem);
  end;
    //The json will contain some items, the inputs, that aren't
    //in the watchlist. They're there for calculations profit/loss etc.
    //Inputs are pulled first, so that when the actual watchlist items are reached,
    //price data will be available. Hhhugly.
    //Should instead put them all in memory first, then loop through the watchlist
    //and called GetPIByTypeID, but this is all a big hack for now.
  dmData.fdmWatchList.DisableControls;
  try
    for aItem in FPrices do
    begin
      with dmData.fdmWatchList do
      begin
        if Locate('typeID',aItem.TypeID) then
        begin
          dmData.fdmWatchList.Edit;
          FieldByName('MinSell').AsCurrency := aItem.Minsell;
          FieldByName('MaxBuy').AsCurrency := aItem.Maxbuy;
          FieldByName('BuildFromBuy').AsCurrency := CostToBuildMaterialsBuy(aItem.TypeID);
          FieldByName('BuildFromSell').AsCurrency := CostToBuildMaterialsSell(aItem.TypeID);
          dmData.fdmWatchList.Post;
        end;
      end;
    end;
  finally
    dmData.fdmWatchList.EnableControls;
  end;
end;

procedure TfrmMain.pcLowerChange(Sender: TObject);
begin
  ShowInformation;
end;

procedure TfrmMain.PopulateFileList;
var
  slBins:TStringList;
  sPath:string;
begin
  slBins := TStringList.Create;
  cmbFiles.Items.Clear;
  try
    ExpandWildcards(ExtractFilePath(Application.ExeName)+'*.bin',slBins);
    for sPath in slBins do
      cmbFiles.Items.add(ExtractFileName(sPath));
  finally
    slBins.free;
  end;
end;

procedure TfrmMain.RenderRootMarketGroupsToTree;
begin
  tvMarketGroups.items.clear;
  tvMarketGroups.Items.BeginUpdate;
  try
    RenderGroupToTreeNode(nil);
  finally
    tvMarketGroups.items.endupdate;
  end;
end;

procedure TfrmMain.RenderGroupToTreeNode(aParentNode:TTreeNode);
var
  aNode:TTreeNode;
  aGroup:TMarketGroup;
  sParentHREF:string;
begin
  if aParentNode = nil then
    sParentHREF:=''
  else
  begin
    sparentHREF:= TMarketGroup(aParentNode.data).href;
    //if aParentNode.HasChildren then
      //aParentNode.DeleteChildren;
  end;

  for aGroup in FMarketGroups do
  begin
    if aGroup.parentgroup=sParentHREF then
    begin
      aNode := tvMarketGroups.items.addchildobject(aParentNode,aGroup.name,aGroup);
      RenderGroupToTreeNode(aNode);
    end;
  end;
end;

procedure TfrmMain.DoExtractMarketGroups;
var
  jvArr:TJSONArray;
  jvSource:TJsonObject;
  jvGroup:TJSONValue;
  jvObject:TJSONObject;
  sfieldname,svalue,sRawJson:string;
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
    //aGroup should be fully populated now. Add it to the manager
    FMarketGroups.Add(aGroup);
  end;
end;

end.
