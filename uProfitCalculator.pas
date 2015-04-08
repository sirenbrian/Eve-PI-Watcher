unit uProfitCalculator;

interface
uses dData,uPIPrice;

function ProfitPerItemByTypeID(iTypeID:integer;cCost:extended):extended;
function CostToBuildMaterialsBuy(iTypeID:integer):extended;
function CostToBuildMaterialsSell(iTypeID:integer):extended;
function InputReport(iTypeID:integer):string;

implementation
uses sysutils, dEveStatic;

function CostToBuildMaterialsBuy(iTypeID:integer):extended;
var
  aInputPI:TPIPrice;
  cTotal:currency;
  iOutQty: Integer;
begin

  with dmEveStatic.fdmInputs do
  begin
    Filter:='ParentTypeID='+inttostr(iTypeID);
    Filtered:=true;
    first;
    cTotal:=0.0;
    while not eof do
    begin
      aInputPI := GetPIByTypeID(dmEveStatic.fdmInputsChildTypeID.Value);
      cTotal:= cTotal +dmEveStatic.fdmInputsQuantity.value * aInputPI.buy.max;
      next;
    end;
  end;
  //that's how much you spent to make X units of output (PI lvl 4, x=1. Lvl 3, x=3 etc)
  iOutQty := 1; //default
  if dmData.fdmPITypeIDs.Locate('typeID',itypeID) then
    iOutQty := dmData.fdmPITypeIDsOutputQty.Value;
  result := cTotal / (ioutQty)
end;

function CostToBuildMaterialsSell(iTypeID:integer):extended;
var
  aInputPI:TPIPrice;
  cTotal:currency;
  iOutQty:integer;
begin
  with dmEveStatic.fdmInputs do
  begin
    Filter:='ParentTypeID='+inttostr(iTypeID);
    Filtered:=true;
    first;
    cTotal := 0.0;
    while not eof do
    begin
      aInputPI := GetPIByTypeID(dmEveStatic.fdmInputsChildTypeID.Value);
      cTotal:= cTotal+dmEveStatic.fdmInputsQuantity.value * aInputPI.sell.min;
      next;
    end;
  end;
  //that's how much you spent to make X units of output (PI lvl 4, x=1. Lvl 3, x=3 etc)
  iOutQty := 1; //default
  if dmData.fdmPITypeIDs.Locate('typeID',itypeID) then
    iOutQty := dmData.fdmPITypeIDsOutputQty.Value;
  result := cTotal / (ioutQty)

end;

function ProfitPerItemByTypeID(iTypeID:integer;cCost:extended):extended;
begin
    //Cost of parent item's sell price minus cost of building one from inputs
    //one level below it.
  //So we'll get the right output quantity
  dmData.fdmPITypeIDs.Locate('typeID',itypeID);
  result := GetPIByTypeID(iTypeID).sell.min - cCost;
end;

function InputReport(iTypeID:integer):string;
var
  aInputPI:TPIPrice;
  cInputCost,cInputTotalBuyCost,cInputTotalSellCost:currency;

  sFormat:string;
begin
  //Output something like
  //Inputs
  //Item 1: 6 nuclear reactors @ 49,000 each: (6X49);
  //items 2: ditto
  with dmEveStatic.fdmInputs do
  begin
    Filter:='ParentTypeID='+inttostr(iTypeID);
    Filtered:=true;
    first;
    result := UpperCase(dmEveStatic.GetNameByTypeID(iTypeID))+ ' ('+
      inttostr(iTypeID)+')'+
      #13#10;
    cInputTotalSellCost :=0.0;
    cInputTotalBuyCost :=0.0;
    sFormat:='%d @ %n each = %n';
    while not eof do
    begin
      aInputPI := GetPIByTypeID(dmEveStatic.fdmInputsChildTypeID.Value);
      if aInputPI <> nil then
      begin
      //sell
        result := result + aInputPI.Name+' ('+inttostr(aInputPI.TypeID)+ ')'+#13#10;
        cInputCost := dmEveStatic.fdmInputsQuantity.value *aInputPI.Sell.Min;
        cInputTotalSellCost := cInputTotalSellCost+cInputCost;
        result := result + format(sFormat,
          [dmEveStatic.fdmInputsQuantity.value,
          aInputPI.Sell.Min,
          cInputCost])+#13#10;

        //buy
        cInputCost := dmEveStatic.fdmInputsQuantity.value *aInputPI.buy.max;
        cInputTotalBuyCost := cInputTotalBuyCost+cInputCost;

        result := result + format(sFormat,
          [dmEveStatic.fdmInputsQuantity.value,
          aInputPI.Buy.Max,
          (dmEveStatic.fdmInputsQuantity.value *aInputPI.Buy.Max)])+#13#10;
        result := result + '- - - - - - - -'+#13#10;
      end
      else
        result := 'Unknown Type: '+dmEveStatic.fdmInputsChildtypeID.Value.ToString+#13#10;
      next;
    end;
    dmData.fdmPITypeIDs.locate('typeID',itypeID);
    result := result + format('Produces %d units',[dmData.fdmPITypeIDsOutputQty.value])+#13#10;

    result := result + format('Total Cost From Sell %n @ %n each',[
      cInputTotalSellCost,
      (cInputTotalSellCost/dmData.fdmPITypeIDsOutputQty.value)])+#13#10;
    result := result + format('Total Cost From Buy %n @ %n each',[
      cInputTotalBuyCost,
      (cInputTotalBuyCost/dmData.fdmPITypeIDsOutputQty.value)
      ])+#13#10#13#10;
  end;
end;
end.
