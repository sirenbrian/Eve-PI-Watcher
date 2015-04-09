unit uPIPrice;

interface
uses uEveCentralPrice,system.generics.collections;

type TPIPrice=class
public
  PILevel:integer; //in data it's 1-5, but most people use 0 to 4
  Name:string;
  MinSell:extended;
  MaxBuy:extended;
  TypeID:integer;
//  function TypeID:integer;
  function AsString:string;
  function AsStringBasic:string;
end;

function ParseECPrice(sJSON:string):TPIPrice;
function GetPIByTypeID(iTypeID:integer):TPIPrice;
var
  FPrices:TObjectList<TPIPrice>;

implementation
uses system.rtti,uRTTIUtils,classes,sysutils,rest.json,system.json, dData;

function ParseECPrice(sJSON:string):TPIPrice;
var
  joFQ,joJSON,joBuy,joSell:TJSONObject;
  jaTypes:TJSONArray;
begin
  joJSON := TJSONObject.ParseJSONValue(sJSON) as TJSONObject;
  joBuy := joJSON.GetValue('buy') as TJSONObject;
  joSell := joJSON.GetValue('sell') as TJSONObject;
  joFQ := joBuy.GetValue('forQuery') as TJSONObject;
  jaTypes:=joFQ.Values['types'] as TJSONArray;
  result := TPIPrice.create;
  result.typeID := jatypes.Items[0].ToString.ToInteger;
  result.MaxBuy := joBuy.Getvalue('max').Value.ToExtended;
  result.MinSell := joSell.Getvalue('min').Value.ToExtended;
  result.Name := dmData.GetNameByTypeID(result.TypeID);
  //Since TJSON.JSONToObject started crashing randomly on me, do this myself :(
//{"buy":{"forQuery":{"bid":true,"types":[35],"regions":[10000002],
//"systems":[30000142],"hours":24,"minq":10001},"volume":2702505609,
//"wavg":12.010574592217248,"avg":11.49,"variance":0.8414785714285714,
//"stdDev":0.9173214111905224,"median":12.285,"fivePercent":12.363420279857149,
//"max":12.37,"min":10.03,"highToLow":true,"generated":1428584527885},
//"all":{"forQuery":{"bid":null,"types":[35],"regions":[10000002],
//"systems":[30000142],"hours":24,"minq":10001},"volume":9751774109,"wavg":12.744656023131022,
//"avg":12.693478260869561,"variance":4.500520075614366,"stdDev":2.121442923015928,"median":12.77,
//"fivePercent":0.37,"max":17.4,"min":0.37,"highToLow":false,"generated":1428584527888},
//"sell":{"forQuery":{"bid":false,"types":[35],"regions":[10000002],"systems":[30000142],"hours":24,"minq":10001},"volume":6544268500,"wavg":14.00270502833128,"avg":13.379764705882353,"variance":1.2931811211072666,"stdDev":1.1371812173559968,"median":13.51,"fivePercent":12.443646275072629,"max":17.4,"min":12.43,"highToLow":false,"generated":1428584527884}}
end;
{ TPIPrice }
function TPIPrice.AsString: string;
var
  slOut:TStringList;
begin
  //Use RTTI to print list of property and values
  //http://docwiki.embarcadero.com/RADStudio/XE6/en/Working_with_RTTI_Index
  //http://stackoverflow.com/questions/2802864/rtti-accessing-fields-and-properties-in-complex-data-structures
  //http://stackoverflow.com/questions/15702778/how-can-i-set-get-property-value-through-rtti-for-compex-things-like-tstringgrid
  {
  slOut := TStringList.create;
  try
    GetPropertyNames(TPIPrice,slOut);//crashes
    result := slOut.text;
  finally
    slOut.free;
  end;
  }
  //max,median,min,stddev,variance,wavg,volume,fivePercent
  {
  result := format('Type ID: %d',[TypeID])+#13#10;
  result := result + 'Name: '+Name+#13#10;
  result := result + format('Sell.Max: %n',[Sell.max])+#13#10;
  result := result + format('Sell.Min: %n',[Sell.min])+#13#10;
  result := result + format('Sell.WAvg: %n',[Sell.wavg])+#13#10;
  result := result + format('Sell.5Percent: %n',[Sell.fivePercent])+#13#10;
  result := result + format('Sell.Volume: %n',[Sell.Volume])+#13#10;
  result := result + format('Sell.StdDev: %f',[Sell.stddev])+#13#10;
  result := result + format('Sell.Variance: %f',[Sell.variance])+#13#10#13#10;

  result := result + format('Buy.Max: %n',[Buy.max])+#13#10;
  result := result + format('Buy.Min: %n',[Buy.min])+#13#10;
  result := result + format('Buy.WAvg: %n',[Buy.wavg])+#13#10;
  result := result + format('Buy.5Percent: %n',[Buy.fivePercent])+#13#10;
  result := result + format('Buy.Volume: %n',[Buy.Volume])+#13#10;
  result := result + format('Buy.StdDev: %f',[Buy.stddev])+#13#10;
  result := result + format('Buy.Variance: %f',[Buy.variance])+#13#10#13#10#13#10;
  }
end;

function TPIPrice.AsStringBasic: string;
begin
  result := 'Name: '+Name;
{  result := result + format('Sell.Min: %n',[Sell.Min]);
  result := result + format('Buy.Max: %n',[buy.Max]);
  }
end;

{
function TPIPrice.TypeID: integer;
begin
  //result := trunc(all.forQuery.types[0]);
end;
 }

function GetPIByTypeID(iTypeID:integer):TPIPrice;
var
  aTestPI:TPIPrice;
begin
  result := nil;
  for atestPI in FPrices do
  begin
    if atestPI.TypeID = iTypeID then
    begin
      result := aTestPI;
      break;
    end;
  end;
end;

end.
