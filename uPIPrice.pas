unit uPIPrice;

interface
uses uEveCentralPrice,system.generics.collections;



type TPIPrice=class(TItemClass)
public
  PILevel:integer; //in data it's 1-5, but most people use 0 to 4
  Name:string;
  function TypeID:integer;
  function AsString:string;
  function AsStringBasic:string;
end;

function GetPIByTypeID(iTypeID:integer):TPIPrice;
var
  FPrices:TObjectList<TPIPrice>;

implementation
uses system.rtti,uRTTIUtils,classes,sysutils;
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
end;

function TPIPrice.AsStringBasic: string;
begin
  result := 'Name: '+Name;
  result := result + format('Sell.Min: %n',[Sell.Min]);
  result := result + format('Buy.Max: %n',[buy.Max]);
end;

function TPIPrice.TypeID: integer;
begin
  result := trunc(all.forQuery.types[0]);
end;

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
