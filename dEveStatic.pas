unit dEveStatic;
//a collection of fdmemtables loaded with static data
//from Eve Online that never (or rarely) changes.
//5MB because the data is permanently saved in the .dfm
interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Stan.StorageBin;

type
  TdmEveStatic = class(TDataModule)
    fdmAllTypes: TFDMemTable;
    fdmAllTypestypeID: TIntegerField;
    fdmAllTypesgroupID: TIntegerField;
    fdmAllTypestypeName: TStringField;
    fdmAllTypesmarketGroupID: TIntegerField;
    fdmAllTypesdescription: TStringField;
    fdmInputs: TFDMemTable;
    fdmInputsParentTypeID: TIntegerField;
    fdmInputsChildTypeID: TIntegerField;
    fdmInputsQuantity: TIntegerField;
    fdmemGroups: TFDMemTable;
    fdmemGroupsgroupID: TIntegerField;
    fdmemGroupscategoryID: TIntegerField;
    fdmemGroupsgroupName: TStringField;
    fdmemGroupsdescription: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure LoadGroups;
    procedure LoadTypes;
    function GetNameByTypeID(iTypeID:integer):string;

    function IsParentOf(iParentTypeID,iChildTypeID:integer):boolean;

  end;

var
  dmEveStatic: TdmEveStatic;


implementation
uses types,strutils;

function TdmEveStatic.GetNameByTypeID(iTypeID: integer): string;
begin
  result := fdmAllTypes.Lookup('typeid',iTypeID,'TypeName');
end;

function TdmEveStatic.IsParentOf(iParentTypeID, iChildTypeID: integer): boolean;
var
  sFilter:string;
begin
  sFilter := format('(ParentTypeID=%d) and (ChildTypeID=%d)',[iParentTypeID,iChildTypeID]);
  fdmInputs.filter := sFilter;
  fdmInputs.Filtered:=true;
  result := fdmInputs.recordcount=1;
end;

procedure TdmEveStatic.LoadGroups;
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

procedure TdmEveStatic.LoadTypes;
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
{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

end.
