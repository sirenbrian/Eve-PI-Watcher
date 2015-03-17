unit uMarketOrders;

interface
uses system.generics.collections,comctrls;

type
  TOrderType=(otBuy,otSell);

  TMarketOrder=class
  private
    FOrderType:TOrderType;
    FVolume:integer;
    FPrice:currency;
    FExpiryDate:string;
  public
    property OrderType: TOrderType read FOrderType write FOrderType;
    property Price: currency read FPrice write FPrice;
    property Volume: integer read FVolume write FVolume;
    property ExpiryDate:string read FExpiryDate write FExpiryDate;
  end;

  TOrders=TObjectList<TMarketOrder>;

  procedure FetchMarketOrders(iTypeID:integer);
  procedure DrawMarketOrders(otType:TOrderType;lv:TListView);

  var
    gaOrders:TOrders;

implementation
uses uShared,dData,sysutils,xmlintf;

procedure DrawMarketOrders(otType:TOrderType;lv:TListView);
var
  aItem:TListItem;
  aOrder:TMarketOrder;
begin
  lv.Items.clear;
  lv.Items.beginupdate;
  try
    for aOrder in gaOrders do
    begin
      if aOrder.ORderType <> otType then
        continue;
      //price/vol/date
      aItem := lv.items.add;
      aItem.caption := format('%n',[aOrder.Price]);
      aItem.subitems.add(format('%d',[aOrder.Volume]));
      aItem.subitems.add(aOrder.ExpiryDate);
      aItem.Data := aOrder;//Nothing yet, but will use later, I'm sure
    end;
    SetAllListViewColumnsToMaxWidth(lv);
  finally
    lv.Items.EndUpdate;
  end;
end;

procedure FetchMarketOrders(iTypeID:integer);
var
  iOrder,iSellOrders,iBuyOrders,iStartNode,iOrders,iNode:IXMLNode;
  orderList:IXMLNodeList;
  aOrder:TMarketOrder;
  ilp:integer;
begin
  if assigned(gaOrders) then
    FReeAndNil(gaOrders);

  gaOrders := TOrders.create;
  dmData.reqMarketOrders.Params[0].Value := inttostr(iTypeID);
  dmData.reqMarketOrders.Execute;
  dmData.xmlMarketOrders.LoadFromXML(dmData.respMarketOrders.content);
  dmData.xmlMarketOrders.Active := true;//makes it parse the xml, which is loaded through binding
  iStartNode:=dmData.xmlMarketOrders.DocumentElement; //points to "evec"
  iOrders := iStartNode.ChildNodes['quicklook'];
  for ilp := 0 to 1 do
  begin
    iSellOrders := iOrders.ChildNodes['sell_orders'];
    iBuyOrders := iOrders.ChildNodes['buy_orders'];
    if ilp = 0 then
      iOrder := iSellOrders.childnodes.first
    else
      iOrder := iBuyOrders.childnodes.first;
    while iOrder <> nil do
    begin
      aOrder := TMarketOrder.create;
      gaOrders.add(aOrder);
      aOrder.FPrice := strtocurrdef(iOrder.ChildNodes['price'].text,0.0);
      aOrder.FVolume := strtointdef(iOrder.childnodes['vol_remain'].Text,0);
      aOrder.ExpiryDate := iOrder.ChildNodes['expires'].text;
      if ilp = 0 then
        aOrder.OrderType := otSell
      else
        aOrder.OrderType := otBuy;
      iOrder:= iOrder.NextSibling;
    end;
  end;
end;
end.

