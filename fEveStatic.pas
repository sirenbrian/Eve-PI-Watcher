unit fEveStatic;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove,
  FireDAC.Comp.BatchMove.Text, FireDAC.Stan.Intf;

type
  TfrmEveStatic = class(TForm)
    grdAllTypes: TDBGrid;
    dsAllTypes: TDataSource;
    btnLoadAllTypes: TButton;
    btnSaveAllTypes: TButton;
    DBGrid1: TDBGrid;
    dsAllGroups: TDataSource;
    Button1: TButton;
    Button2: TButton;
    dbMaterials: TDBGrid;
    dsInputs: TDataSource;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveTextReader1: TFDBatchMoveTextReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    Label1: TLabel;
    procedure btnSaveAllTypesClick(Sender: TObject);
    procedure btnLoadAllTypesClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEveStatic: TfrmEveStatic;

implementation

{$R *.dfm}

uses dEveStatic;

procedure TfrmEveStatic.btnLoadAllTypesClick(Sender: TObject);
begin
  dmEveStatic.LoadTypes;
end;

procedure TfrmEveStatic.btnSaveAllTypesClick(Sender: TObject);
begin
  dmEveStatic.fdmAlltypes.SavetoFile('invTypes.bin',sfBinary);
end;

procedure TfrmEveStatic.Button1Click(Sender: TObject);
begin
  dmEveStatic.LoadGroups;
end;

procedure TfrmEveStatic.Button2Click(Sender: TObject);
begin
  dmEveStatic.fdmemGroups.SavetoFile('invGroup.bin',sfBinary);
end;

end.
