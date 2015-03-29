unit dData;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.StorageBin, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, IPPeerClient, REST.Client, Data.Bind.Components,
  Data.Bind.ObjectScope, Xml.xmldom, Xml.XMLIntf, Data.Bind.EngExt,
  Vcl.Bind.DBEngExt, System.Rtti, System.Bindings.Outputs, Xml.Win.msxmldom,
  Xml.XMLDoc;

type
  TdmData = class(TDataModule)
    fdmInputs: TFDMemTable;
    fdmInputsParentTypeID: TIntegerField;
    fdmInputsChildTypeID: TIntegerField;
    fdmInputsQuantity: TIntegerField;
    fdmTypeIDs: TFDMemTable;
    fdmTypeIDsTypeName: TStringField;
    fdmTypeIDsPILevel: TSmallintField;
    fdmTypeIDsTypeID: TIntegerField;
    resClient: TRESTClient;
    reqPrices: TRESTRequest;
    respPrices: TRESTResponse;
    fdmTypeIDsOutputQty: TIntegerField;
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
    fdmemGroups: TFDMemTable;
    fdmemGroupsgroupID: TIntegerField;
    fdmemGroupscategoryID: TIntegerField;
    fdmemGroupsgroupName: TStringField;
    fdmemGroupsdescription: TStringField;
    fdmAllTypes: TFDMemTable;
    fdmAllTypestypeID: TIntegerField;
    fdmAllTypesgroupID: TIntegerField;
    fdmAllTypestypeName: TStringField;
    fdmAllTypesmarketGroupID: TIntegerField;
    fdmAllTypesdescription: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure FetchAllPrices;
    function GetNameByTypeID(iTypeID:integer):string;
    function GetLevelByTypeID(iTypeID:integer):integer;
    function IsParentOf(iParentTypeID,iChildTypeID:integer):boolean;
  end;

var
  dmData: TdmData;

implementation
uses strutils,ioutils;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmData }

procedure TdmData.FetchAllPrices;
var
  sTypes:string;
  p:TRESTRequestParameter;
begin
  fdmTypeIDs.first;
  stypes := '';
  p := reqPrices.Params.ParameterByName('typeid');
  sTypes:='';
  while not fdmTypeIDs.eof do
  begin
    stypes:=sTypes+fdmTypeIDsTypeID.AsString;
    if fdmTypeIDs.RecNo < fdmTypeIDs.RecordCount then
      sTypes:=sTypes+',';
    fdmTypeIDs.next;
  end;
  p.Value:= sTypes;
  reqPrices.execute;
  TFile.WriteAllText('lastjson.txt',respPrices.content);
end;

function TdmData.GetLevelByTypeID(iTypeID: integer): integer;
begin
  result := fdmTypeIDs.Lookup('typeid',iTypeID,'PILevel')-1;
end;

function TdmData.GetNameByTypeID(iTypeID: integer): string;
begin
  result := fdmTypeIDs.Lookup('typeid',iTypeID,'TypeName');
end;

function TdmData.IsParentOf(iParentTypeID, iChildTypeID: integer): boolean;
var
  sFilter:string;
begin
  sFilter := format('(ParentTypeID=%d) and (ChildTypeID=%d)',[iParentTypeID,iChildTypeID]);
  fdmInputs.filter := sFilter;
  fdmInputs.Filtered:=true;
  result := fdmInputs.recordcount=1;
end;

end.
