unit uClientDataSetUtils;

interface

uses Datasnap.DBClient, Data.DB,FireDAC.Comp.Client, Vcl.DBGrids;

function SortClientDataSet(ClientDataSet: TClientDataSet;
  const FieldName: String): Boolean;
function SortFDMemTable(fdm:TFDMemTable;Column:TColumn):boolean;

implementation
uses uShared;

function SortFDMemTable(fdm:TFDMemTable;Column:TColumn):boolean;
var
  sNewIndex: string;
begin
  if Column.Title.Caption= fdm.IndexFieldNames then
    sNewIndex := Column.Title.Caption+':D'
  else
    sNewIndex := Column.Title.Caption;
  sNewIndex := rightcontrim(sNewIndex,':D:D');
  fdm.IndexFieldNames := sNewIndex;
end;

function SortClientDataSet(ClientDataSet: TClientDataSet;
  const FieldName: String): Boolean;
var
  i: Integer;
  NewIndexName: String;
  IndexOptions: TIndexOptions;
  Field: TField;
begin
  Result := False;
  Field := ClientDataSet.Fields.FindField(FieldName);
  // If invalid field name, exit.
  if Field = nil then
    Exit;
  // if invalid field type, exit.
  if (Field is TObjectField) or (Field is TBlobField) or
    (Field is TAggregateField) or (Field is TVariantField) or
    (Field is TBinaryField) then
    Exit;
  // Get IndexDefs and IndexName using RTTI
  // Ensure IndexDefs is up-to-date
  ClientDataSet.IndexDefs.Update;
  // If an ascending index is already in use,
  // switch to a descending index
  if ClientDataSet.IndexName = FieldName + '__IdxA' then
  begin
    NewIndexName := FieldName + '__IdxD';
    IndexOptions := [ixDescending];
  end
  else
  begin
    NewIndexName := FieldName + '__IdxA';
    IndexOptions := [];
  end;
  // Look for existing index
  for i := 0 to Pred(ClientDataSet.IndexDefs.Count) do
  begin
    if ClientDataSet.IndexDefs[i].Name = NewIndexName then
    begin
      Result := True;
      Break
    end; // if
  end; // for
  // If existing index not found, create one
  if not Result then
  begin
    ClientDataSet.AddIndex(NewIndexName, FieldName, IndexOptions);
    Result := True;
  end; // if not
  // Set the index
  ClientDataSet.IndexName := NewIndexName;
end;

end.
