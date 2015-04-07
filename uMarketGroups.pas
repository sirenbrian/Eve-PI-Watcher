unit uMarketGroups;

interface
uses system.generics.collections, System.IOUtils;

type
  TMarketGroup=class
  public
    href:string;
    name:string;
    typeshref:string;
    parentgroup:string;//href that matches another .href in another instance
    description:string;
    function GroupID:string;
  end;

  TMarketGroupManager=class(TObjectList<TMarketGroup>)
    public
      function GetParent(Findhref:string):TMarketGroup;
  end;
implementation

uses
  System.Types, System.StrUtils;

{ TMarketGroupManager }

function TMarketGroupManager.GetParent(Findhref: string): TMarketGroup;
var
  aTest:TMarketGroup;
begin
  result := nil;
  for aTest in self do
  begin
    if aTest.href=FindHREF then
    begin
      result := aTest;
      break;
    end;
  end;
end;

{ TMarketGroup }

function TMarketGroup.GroupID: string;
var
  aValues:Tstringdynarray;
begin
  //https://public-crest.eveonline.com/market/groups/1376/
  aValues:=SplitString(href,'/');
  if length(aValues)>5 then
    result := aValues[5];
end;

end.
