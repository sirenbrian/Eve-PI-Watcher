unit ushared;
//Contains handy functions not tied to any one program.
interface
uses System.Classes,comctrls;

procedure SetAllListViewColumnsToMaxWidth(lvListView: TListView; bFitHeader: boolean = false);
procedure SetAllListViewColumnsToFixedWidth(lvListView: TListView;iWidth:integer=50);
function SortListView(Item1, Item2: TListItem; bSortAscending: boolean;
                iColumnIndex: integer; iSortType: integer = 0): integer;
procedure ExpandWildcards(sWildPath: string; slResult: TStringList);
function RightConTrim(sString, sTarget: string): string; //Trailing only

const
    CrLf   = #13 + #10;
    SQ = '''';

implementation
uses strutils,sysutils,dateutils,math;

procedure SetAllListViewColumnsToMaxWidth(lvListView: TListView; bFitHeader: boolean = false);
//Set the width of each column to the width of their widest item
//
//NOTE - AFTER THIS IS APPLIED TO A LISTVIEW IT WILL BE **VERY** SLOW
//TO ADD NEW ITEMS TO THE LIST. It's about 15-20 times slower on my box.
//Ideally you would call SetAllListViewColumnsToFixedWidth before loading
//lots of new rows into a TListView that had been MaxWidthed.
//
//Begin|EndUpdate doesn't help either - you really need to set the col widths
//back to fixed.
var
  iRowLP,ilp:  integer;
  iHeaderWidth,iValueWidth,iWidthToUse,iVal: integer;
  sValue:string;
begin
  iVal := -1;
  //Columns should fit the widest value in the actual rows
  //But columns should match the width of the column header if asked to do so,
  //or if there are no rows in the whole listview
  if bFitHeader or (lvListView.Items.Count = 0) then
    iVal := -2;

  for ilp := 0 to lvListView.Columns.Count - 1 do
    begin
      lvListView.Columns[ilp].Width := iVal;
    end;

  //If any of the columns contain no data, set the column width to -2 (width of header)
  //Also if none of the data shown is wider than the column header, use the col header width
  for ilp := 0 to lvListView.Columns.Count - 1 do
    begin
      //Look at each item in this column

      iWidthToUse := -2;//default to using the "match header" width setting
      //How wide is the header, in pixels ?
      iHeaderWidth := lvListView.Canvas.TextWidth(lvListView.Columns[ilp].caption);
      for iRowLP := 0 to lvListView.Items.count-1 do
        begin
          if ilp = 0 then
            svalue := lvListView.items[iRowlp].caption
          else
            begin
              //If there's a subitem we can read, get it
              //otherwise, there's no value there - use ''
              if lvListView.items[iRowlp].subitems.count >= ilp then
                sValue := lvListView.items[iRowlp].subitems[ilp-1]
              else
                sValue := '';
            end;

          if sValue <> '' then
            begin
              iValueWidth := lvListView.Canvas.TextWidth(sValue);
              if iValueWidth > iHeaderWidth then
                begin
                  iWidthTouse := -1; //We found something - use "match column contents width" setting.
                  break; //We can break now...we've cleared the threshold of being wider than the header width
                         //listview will choose its own width.
                end;
            end;
        end;
      lvListView.Columns[ilp].Width := iWidthToUse;
    end;
end;

procedure SetAllListViewColumnsToFixedWidth(lvListView: TListView;iWidth:integer=50);
var
  ilp:  integer;
begin
  //No, using Items.Begin/EndUpdate does NOT do the same thing as this.
  for ilp := 0 to lvListView.Columns.Count - 1 do
    begin
      lvListView.Columns[ilp].Width := iWidth;
    end;
end;

function SortListView(Item1, Item2: TListItem; bSortAscending: boolean;
                iColumnIndex: integer; iSortType: integer = 0): integer;
var
  scompare1, sCompare2: string;
  iVal1, iVal2:     integer;
  fVal1, fVal2:     double;
  cVal1,cVal2:currency;
  dtDate1, dtDate2: TDateTime;
begin
  //got sick of writing this individually, so this routine will handle any list view

  //[STEP ONE]
  //In your TListView.OnCompare event, do
  //      Compare := SortListView(Item1,Item2,Data,[0|1|2])
  //Decide for yourself if you want the data to be compared by integer or not
  //Obviously, don't pick a column with alphabetic data and tell me it's an
  //integer sort though !

  //STEP TWO
    //If you want bi-directional sorting you'll need to put a few things in place.
    //declare these two:
    //    bSortAscending:boolean; //We use this to track the sort order for the listview
    //  iLastColumnSorted:integer;//ditto

    //In form.create initialize them to TRUE and -1 respectively.

    //STEP THREE
    //then your listview.columnclick should look like this
{    if Column.Index = iLastColumnSorted then
        bSortAscending := not bSortAscending
    else
        bSortAscending := true;

    iLastColumnSorted := Column.Index;

    lvLinks.CustomSort(nil,Column.Index);
 }

 // It's a pain that we have to track this ourselves: The listview in QComCtrls seems
 //much nicer, with built-in properties for this kind of stuff.
 // If this doesn't suit your needs, look for a third party listview control
 //or try and figure out how to use the qcomctrls listview instead of the standard one.

  //First lets extract the data we'll be comparing.  It might be in the
  //.caption, or a subitem.
  if iColumnIndex = 0 then
    begin
      sCompare1 := Item1.Caption;
      sCompare2 := Item2.Caption;
    end
  else
    begin
      sCompare1 := Item1.subitems[iColumnIndex - 1];
      sCompare2 := Item2.subitems[iColumnIndex - 1];
    end;

  //sanitation - remove commas from any numeric values
  if iSorttype > 0 then
  begin
    sCompare1 := stringreplace(sCompare1,',','',[rfReplaceAll]);
    sCompare2 := stringreplace(sCompare2,',','',[rfReplaceAll]);
  end;

  //Now do the comparison either as string, integer, float, date
  case iSortType of
    0: Result := AnsiCompareText(sCompare1, sCompare2);
    1: //integer
        begin
          //Use the safe version of strtoint
          iVal1 := strtointdef(sCompare1, 0);
          iVal2 := strtointdef(sCompare2, 0);
          result := CompareValue(iVal1,iVAl2);
        end;
    2: //date
        begin
          dtDate1 := StrToDateDef(sCompare1,0);
          dtDate2 := strtodatedef(sCompare2,0);
          Result := CompareDate(dtDate1,dtDate2);
        end;
    3: //float
        begin
          //Use the safe version of strtofloat
          fVal1 := StrToFloatDef(sCompare1, 0);
          fVal2 := StrToFloatDef(sCompare2, 0);
          result := CompareValue(fVal1,fVal2);
        end;
    4: //datetime
        begin
          dtDate1 := StrToDateTimeDef(sCompare1,0);
          dtDate2 := StrToDateTimeDef(sCompare2,0);
          Result := CompareDateTime(dtDate1,dtDate2);
        end;
    5: //currency (float has limits?)
      begin
          cVal1 := StrToCurrDef(sCompare1, 0);
          cVal2 := StrToCurrDef(sCompare2, 0);
          result := CompareValue(cVal1,cVal2);
      end;
    else
      Result := 0;
  end;

  if not bSortAscending then
    Result := -(Result);
end;

function RightConTrim(sString, sTarget: string): string; //Trailing only
begin
  Result := sString;
  if comparetext(rightstr(sString, length(sTarget)), sTarget) = 0 then
    Result := copy(sString, 1, length(sString) - length(sTarget));
end;

function LeftConTrim(sString, sTarget: string): string; //Left only
begin
  Result := sString;
  if comparetext(copy(sString, 0, length(sTarget)), sTarget) = 0 then
    begin
      delete(sString,1,length(sTarget)); //MidStr(sString, length(sTarget) + 1, );
      result := sString;
    end;
end;

function FilePath(sDir, sFile: string): string;
//Copes with DOS or URL style paths.  Actually this just joins ANY two
//items together, defaulting to DOS style unless it finds a URL slash in
//the sDir parameter.
var
  sSlash: string;
begin
  //Special case - if sDir is blank then
  //just return sFile, otherwise we're saying that
  //it defaults to root (ie /foobar.txt)
  if sDir = '' then
    begin
      Result := sFile;
      exit;
    end;

  if Pos('/', sDir) > 0 then
    sSlash := '/'
  else
    sSlash := '\';

  //this could be rightcontrim now
  sDir := rightcontrim(sdir,sSlash);

  sFile := leftcontrim(sFile,sSlash);

  Result := sDir + sSlash + sFile;
end;


procedure ExpandWildcards(sWildPath: string; slResult: TStringList);
// Originall from sausage.bas / BSMITH
// Give a directory/file wildcard, populate a TStringList with all the matching filenames.
var
  Result:      TSearchRec;
  sWildcard, sPath: string;
  slSubDirs:   TStringList;
  iDirLP, iOK: integer;

  sExt: string;
  bCheckExt, bUseIt: boolean;
begin
  //Bsmith
  //Expand a wildcard and return the list of files that match it.

  bUseIt    := true;
  sPath     := extractfilepath(sWildpath);
  sExt      := extractfileext(sWildpath);
  sWildcard := extractfilename(sWildpath);
  bCheckExt := false;
  if Pos('*', sExt) = 0 then
    bCheckExt := true;

  slSubDirs := TStringList.Create;
  try
    slSubDirs.add(sPath);

    for iDirLP := 0 to slSubDirs.Count - 1 do
      begin
        iOK := findfirst(filepath(slSubDirs[iDirLP], sWildcard), 0, Result);
          if iOK = 0 then
            begin
              repeat
{ TODO : JAC:  Why is the BEGIN/END pair here? }
                begin
                  if bCheckExt then
                    begin
                      bUseIt := true;
                      if comparetext(extractfileext(Result.Name), sExt) <> 0 then
                        bUseIt := false;
                    end;
                end;
                if bUseIt then
                  slResult.add(filepath(slSubDirs[iDirLP], Result.Name));

                iOK := findNext(Result);
              until iOK <> 0;
            end;
      end;
    findclose(Result);
  finally
    slSubDirs.Free;
  end;
end;

end.
