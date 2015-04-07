unit uWatcherGlobals;

interface
var
  gbTypesSortAscending,gbSellOrdersSortAscending,gbBuyOrdersSortAscending:boolean;
  giTypesSortCol,giSellOrdersSortCol,gibuyOrderSortCol:integer;

  function PercentageDifference(cBase,cTest:currency):double;

const
  CRLF=#13#10;
implementation
uses Math;
function PercentageDifference(cBase,cTest:currency):double;
var
  dDiff:double;
begin
  //by what percentage is cTest bigger/smaller than cBase
  dDiff := ((cTest-cBase)/cBase)*100;
  result := roundto(dDiff,2);
end;

end.
