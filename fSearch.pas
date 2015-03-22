unit fSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls;

type
  TfrmSearch = class(TForm)
    txtSearch: TEdit;
    btnSearch: TButton;
    DBGrid1: TDBGrid;
    dsAllTypes: TDataSource;
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSearch: TfrmSearch;

implementation

{$R *.dfm}

uses dData;

procedure TfrmSearch.btnSearchClick(Sender: TObject);
begin
  if length(txtSearch.text) > 3 then
  begin
    dmData.fdmAllTypes.Filter := 'UPPER(typeName) like ''%'+uppercase(txtSearch.text)+'%''';
    dmData.fdmAllTypes.Filtered := true;
  end;
end;

end.
