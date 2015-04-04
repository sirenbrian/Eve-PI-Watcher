unit fViewData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,dData, Vcl.Grids, Vcl.DBGrids, Data.DB,
  Data.Bind.EngExt, Vcl.Bind.DBEngExt, Data.Bind.Components, Vcl.StdCtrls,
  System.Rtti, System.Bindings.Outputs, Vcl.Bind.Editors;

type
  TfrmViewData = class(TForm)
    DBGrid1: TDBGrid;
    dsInputs: TDataSource;
    DBGrid2: TDBGrid;
    dsPITypes: TDataSource;
    Memo1: TMemo;
    BindingsList1: TBindingsList;
    LinkControlToField1: TLinkControlToField;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmViewData: TfrmViewData;

implementation

{$R *.dfm}

uses dEveStatic;

end.
