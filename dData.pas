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
  private

    { Private declarations }
  public
    { Public declarations }
    function GetLevelByTypeID(iTypeID: integer): integer;
    procedure FetchPIPrices;
  end;

var
  dmData: TdmData;

implementation
uses strutils,ioutils;
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

{ TdmData }

procedure TdmData.FetchPIPrices;
var
  sTypes:string;
  p:TRESTRequestParameter;
begin
  fdmPITypeIDs.first;
  stypes := '';
  p := reqPrices.Params.ParameterByName('typeid');
  sTypes:='';
  while not fdmPITypeIDs.eof do
  begin
    stypes:=sTypes+fdmPITypeIDsTypeID.AsString;
    if fdmPITypeIDs.RecNo < fdmPITypeIDs.RecordCount then
      sTypes:=sTypes+',';
    fdmPITypeIDs.next;
  end;
  p.Value:= sTypes;
  reqPrices.execute;
  TFile.WriteAllText('lastpijson.txt',respPrices.content);
end;

function TdmData.GetLevelByTypeID(iTypeID: integer): integer;
begin
  result := fdmPITypeIDs.Lookup('typeid',iTypeID,'PILevel')-1;
end;



end.
