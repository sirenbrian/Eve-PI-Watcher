unit uMarketHistory;

interface
type

  TMarketHistory=class(TObject)
  public
    //THESE HAVE TO START WITH F or the ToObject function won't work
    //Something something "FIELDS".
    ForderCount:integer;
    FlowPrice:currency;
    FhighPrice:currency;
    FavgPrice:currency;
    Fvolume:integer;
    Fdate:TDateTime;
  end;

implementation

end.
