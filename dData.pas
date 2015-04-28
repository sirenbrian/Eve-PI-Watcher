unit dData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Xml.xmldom, Xml.XMLIntf, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Xml.Win.msxmldom,
  Xml.XMLDoc, FireDAC.Stan.StorageXML;

type
  TdmData = class(TDataModule)
    fdmPITypeIDs: TFDMemTable;
    fdmPITypeIDsTypeName: TStringField;
    fdmPITypeIDsPILevel: TSmallintField;
    fdmPITypeIDsTypeID: TIntegerField;
    resClient: TRESTClient;
    reqPrices: TRESTRequest;
    respPrices: TRESTResponse;
    fdmPITypeIDsOutputQty: TIntegerField;
    reqMarketOrders: TRESTRequest;
    respMarketOrders: TRESTResponse;
    xmlMarketOrders: TXMLDocument;
    BindingsList1: TBindingsList;
    reqMarketHistory: TRESTRequest;
    respMarketHistory: TRESTResponse;
    mtMarketHistory: TFDMemTable;
    mtMarketHistoryorderCount: TIntegerField;
    mtMarketHistorylowPrice: TCurrencyField;
    mtMarketHistoryhighPrice: TCurrencyField;
    mtMarketHistoryavgPrice: TCurrencyField;
    mtMarketHistoryvolume: TIntegerField;
    mtMarketHistorydate: TDateTimeField;
    dsMarketHistory: TDataSource;
    resClientEVE: TRESTClient;
    fdmWatchList: TFDMemTable;
    fdmBuildList: TFDMemTable;
    fdmMaterialsWeUse: TFDMemTable;
    dsWatchList: TDataSource;
    dsBuildList: TDataSource;
    dsMaterialsWeUse: TDataSource;
    fdmWatchListtypeID: TIntegerField;
    fdmWatchListMinSell: TCurrencyField;
    fdmWatchListMaxBuy: TCurrencyField;
    fdmWatchListDiffPercent: TFloatField;
    fdmWatchListDiffISK: TCurrencyField;
    fdmWatchListLowBar: TCurrencyField;
    fdmWatchListHighBar: TCurrencyField;
    fdmWatchListName: TStringField;
    fdmWatchListBuildFromBuy: TCurrencyField;
    fdmWatchListBuildFromSell: TCurrencyField;
    fdmWatchListBuildProfitPercent: TFloatField;
    fdmWatchListBuildProfitISK: TCurrencyField;
    mtMarketHistoryTotalValueAvg: TCurrencyField;
    FDStanStorageXMLLink1: TFDStanStorageXMLLink;
    procedure fdmWatchListCalcFields(DataSet: TDataSet);
    procedure mtMarketHistoryCalcFields(DataSet: TDataSet);
  private
    procedure FetchECPrices(sTypeIDs:string;sfilename:string='');
    { Private declarations }
  public
    { Public declarations }
    procedure addtypeidtolist(iTypeID:integer;sName:string);
    procedure AddTypeIDToWatchList(iTypeID:integer);
    function GetLevelByTypeID(iTypeID: integer): integer;
    procedure FetchPIPrices;
    procedure FetchWatchListPrices(sFileNameToSave:string='');
    procedure LoadGroups;
    procedure LoadTypes;
    function GetNameByTypeID(iTypeID:integer):string;
    procedure ClearWatchList;

    function IsParentOf(iParentTypeID,iChildTypeID:integer):boolean;
  end;

var
  dmData: TdmData;
const
  LASTJSON='lastpijson.txt';
  LASTWATCHJSON='lastwatchlistjson.txt';
  WATCHLIST='watch.bin';
  BUILDLIST='build.bin';

implementation
uses strutils,ioutils, dEveStatic, System.Types, System.Variants;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmData }

procedure TdmData.addtypeidtolist(iTypeID: integer; sName: string);
var
  fdmTemp:TFDMemTable;
  ilp:integer;
  sFieldName: string;
begin
  fdmTemp:=TFDMemTable.create(nil);
  try
    if FileExists(sName+'.bin') then
      fdmTemp.LoadFromFile(sName+'.bin',sfBinary)
    else
      fdmTemp.CopyDataSet(fdmWatchList,[coStructure]);
    fdmTemp.AutoCalcFields:=True;
    fdmTemp.OnCalcFields := fdmWatchList.OnCalcFields;
    fdmTemp.append;

    //fdmTemp.fields[0].value := iTypeID;
    try
      for ilp := 0 to fdmWatchList.fields.count-1 do
      begin
        //if fdmWatchList.fields[ilp].fieldkind = fkData then
        //begin
          sFieldName := fdmWatchList.fields[ilp].fieldname;
          fdmTemp.fields.FieldByName(sFieldName).Value := fdmWatchList.fields[ilp].value;
        //end;
      end;
    except
      //fuck it.
    end;
   // fdmTemp.CopyRecord(fdmWatchList.Data as TDataSet);
    fdmTemp.Post;
    fdmTemp.SaveToFile(sName+'.bin',sfBinary);
  finally
    fdmTemp.free;
  end;
end;

procedure TdmData.AddTypeIDToWatchList(iTypeID: integer);
begin
  fdmWatchList.Append;
  fdmWatchListtypeID.asinteger := iTypeID;
  fdmWatchList.Post;
end;

procedure TdmData.ClearWatchList;
begin
  fdmWatchList.DisableControls;
  try
    fdmWatchList.first;
    while not fdmWatchList.eof do
    begin
      fdmWatchList.Delete;
    end;
  finally
    fdmWatchList.EnableControls;
  end;
end;

procedure TdmData.fdmWatchListCalcFields(DataSet: TDataSet);
begin
  //Tried to make this work with other fdmemtables too, didn't work.
  if DataSet.FieldByName('typeID').asinteger > 0 then
  begin
    DataSet.FieldByName('typeName').asstring := GetNameByTypeID(DataSet.FieldByName('typeID').AsInteger);
    DataSet.FieldByName('DiffISK').AsCurrency := DataSet.FieldByName('MinSell').ascurrency-DataSet.FieldByName('MaxBuy').ascurrency;
    if DataSet.FieldByName('MaxBuy').ascurrency > 0 then
      DataSet.FieldByName('DiffPercent').AsFloat := round((DataSet.FieldByName('DiffISK').AsCurrency / DataSet.FieldByName('MaxBuy').ascurrency)*100);
    DataSet.FieldByName('BuildProfitISK').ascurrency := DataSet.FieldByName('MinSell').AsCurrency-DataSet.FieldByName('BuildFromBuy').ascurrency;
    if DataSet.FieldByName('BuildFromBuy').ascurrency > 0 then
      DataSet.FieldByName('BuildProfitPercent').asfloat := round((DataSet.FieldByName('BuildProfitISK').ascurrency/DataSet.FieldByName('BuildFromBuy').ascurrency)*100);
  end;
end;

procedure TdmData.FetchECPrices(sTypeIDs, sfilename: string);
var
  p:TRESTRequestParameter;
  aTypes:TStringdynArray;
  sInputID,sTypeID:string;
  slInputs:TStringList;
begin
  //automatically add the inputs required to make these things
  aTypes := SplitString(stypeIDS,',');
  slInputs:=TStringList.create;
  try
    slInputs.Delimiter := ',';
    for stypeID in atypes do
    begin
      dmEveStatic.fdmInputs.filter := 'ParentTypeID='+sTypeID;
      dmEveStatic.fdmInputs.filtered := true;
      dmEveStatic.fdmInputs.first;
      while not dmEveStatic.fdmInputs.eof do
      begin
        sInputID:=dmEveStatic.fdmInputsChildTypeID.AsString;
        //See if that input is already in the the inputs list, or in the actual type IDs list
        if (AnsiIndexText(sInputID,aTypes) =-1) and (slInputs.indexof(sInputID) = -1) then
          slInputs.add(dmEveStatic.fdmInputsChildtypeID.asstring);

        dmEveStatic.fdmInputs.Next;
      end;
    end;
  finally
  end;
  if slInputs.count > 0 then
    //Fetch the inputs first
    stypeIDs := slInputs.DelimitedText+','+sTypeIDs;

  p := reqPrices.Params.ParameterByName('typeid');
  p.Value:= sTypeIDs;
  reqPrices.execute;
  if sfileName>'' then
    TFile.WriteAllText(sFileName,respPrices.content);
end;

procedure TdmData.FetchPIPrices;
var
  sTypes:string;
begin
  fdmPITypeIDs.first;
  stypes := '';
  while not fdmPITypeIDs.eof do
  begin
    stypes:=sTypes+fdmPITypeIDsTypeID.AsString;
    if fdmPITypeIDs.RecNo < fdmPITypeIDs.RecordCount then
      sTypes:=sTypes+',';
    fdmPITypeIDs.next;
  end;
  FetchECPrices(sTypes,'lastpijson.txt');
end;

procedure TdmData.FetchWatchListPrices(sFileNameToSave:string='');
  //go through fdmWatchList and use the typeIDs to get prices from eve central.
var
  sTypes:string;
begin
  if sFileNameToSave ='' then
    sFileNameToSave :=LASTWATCHJSON;
  fdmWatchList.first;
  stypes := '';
  while not fdmWatchList.eof do
  begin
    stypes:=sTypes+fdmWatchListtypeID.AsString;
    if fdmWatchList.RecNo < fdmWatchList.RecordCount then
      sTypes:=sTypes+',';
    fdmWatchList.next;
  end;
  FetchECPrices(sTypes,sFileNameToSave);
end;

function TdmData.GetLevelByTypeID(iTypeID: integer): integer;
var
  vResult:Variant;
begin
  vresult := fdmPITypeIDs.Lookup('typeid',iTypeID,'PILevel')-1;
  if varisnull(vResult) then
    result := -1;
end;

function TdmData.GetNameByTypeID(iTypeID: integer): string;
begin
  dmEveStatic.fdmAllTypes.filtered := false;
  result := dmEveStatic.fdmAllTypes.Lookup('typeid',iTypeID,'TypeName');
end;

function TdmData.IsParentOf(iParentTypeID, iChildTypeID: integer): boolean;
var
  sFilter:string;
begin
  sFilter := format('(ParentTypeID=%d) and (ChildTypeID=%d)',[iParentTypeID,iChildTypeID]);
  dmEveStatic.fdmInputs.filter := sFilter;
  dmEveStatic.fdmInputs.Filtered:=true;
  result := dmEveStatic.fdmInputs.recordcount=1;
end;

procedure TdmData.LoadGroups;
var
  slRead:TStringList;
  ilp:integer;
  aValues:Tstringdynarray;
begin
  //read from invGroups.txt and load into dmEveStatic.fdmemGroups
  //int int str str
  //use tfilestream later
  //and obviously make one loading point, passing in # and types of fields
  slRead := TStringList.create;
  slRead.loadfromfile('invGroups.txt');
  dmEveStatic.fdmemGroups.Active := true;
  dmEveStatic.fdmemGroups.BeginBatch();
  try
    for ilp := 0 to slRead.count-1 do
    begin
      if (slREad[ilp] = '') or (ilp = 0) then
        continue;
      aValues:=SplitString(slRead[ilp],#9);
      dmEveStatic.fdmemGroups.InsertRecord([aValues[0],aValues[1],aValues[2],aValues[3]]);
    end;
  finally
    dmEveStatic.fdmemGroups.EndBatch;
    slRead.free;
  end;
end;

procedure TdmData.LoadTypes;
var
  slRead:TStringList;
  ilp:integer;
  aValues:Tstringdynarray;
begin
  //read from invTypes.txt and load into dmData.fdmemGroups
  //int int str int
  slRead := TStringList.create;
  slRead.loadfromfile('invTypes.txt');
  dmEveStatic.fdmAllTypes.Active := true;
  dmEveStatic.fdmAllTypes.BeginBatch();
  try
    for ilp := 0 to slRead.count-1 do
    begin
      if (slREad[ilp] = '') or (ilp = 0) then
        continue;
      aValues:=SplitString(slRead[ilp],#9);
      if aVAlues[3] = 'NULL' then
        aValues[3] := '';
      dmEveStatic.fdmAllTypes.InsertRecord([aValues[0],aValues[1],aValues[2],
        aValues[3]]);
    end;
  finally
    dmEveStatic.fdmAllTypes.EndBatch;
    slRead.free;
  end;
end;


procedure TdmData.mtMarketHistoryCalcFields(DataSet: TDataSet);
begin
  mtMarketHistoryTotalValueAvg.Value := mtMarketHistoryavgPrice.Value * mtMarketHistoryvolume.value;
end;

end.
