unit uLoadEveRefData;
//Load static data from four inv*.txt files
//on groups, types, materials (ingredients for building), meta types
interface

procedure LoadGroups;
procedure LoadTypes;

implementation
uses dData,types,sysutils,classes,strutils;

procedure LoadGroups;
var
  slRead:TStringList;
  ilp:integer;
  aValues:Tstringdynarray;
begin
  //read from invGroups.txt and load into dmData.fdmemGroups
  //int int str str
  //use tfilestream later
  //and obviously make one loading point, passing in # and types of fields
  slRead := TStringList.create;
  slRead.loadfromfile('invGroups.txt');
  dmData.fdmemGroups.Active := true;
  dmData.fdmemGroups.BeginBatch();
  try
    for ilp := 0 to slRead.count-1 do
    begin
      if (slREad[ilp] = '') or (ilp = 0) then
        continue;
      aValues:=SplitString(slRead[ilp],#9);
      dmData.fdmemGroups.InsertRecord([aValues[0],aValues[1],aValues[2],aValues[3]]);
    end;
  finally
    dmData.fdmemGroups.EndBatch;
    slRead.free;
  end;


end;

procedure LoadTypes;
var
  slRead:TStringList;
  ilp:integer;
  aValues:Tstringdynarray;
begin
  //read from invTypes.txt and load into dmData.fdmemGroups
  //int int str int
  slRead := TStringList.create;
  slRead.loadfromfile('invTypes.txt');
  dmData.fdmAllTypes.Active := true;
  dmData.fdmAllTypes.BeginBatch();
  try
    for ilp := 0 to slRead.count-1 do
    begin
      if (slREad[ilp] = '') or (ilp = 0) then
        continue;
      aValues:=SplitString(slRead[ilp],#9);
      if aVAlues[3] = 'NULL' then
        aValues[3] := '';
      dmData.fdmAllTypes.InsertRecord([aValues[0],aValues[1],aValues[2],
        aValues[3]]);
    end;
  finally
    dmData.fdmAllTypes.EndBatch;
    slRead.free;
  end;
end;
end.
