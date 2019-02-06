unit untQtdPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmQtdPedido = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    dbgProdutos: TDBGrid;
    dsproduto: TDataSource;
    dsVenda: TDataSource;
    dsVendaItem: TDataSource;
    edtFiltro: TEdit;
    lbFiltro: TLabel;
    Panel4: TPanel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
  private
    { Private declarations }
  public
var idcliente:integer;
  end;

var
  frmQtdPedido: TfrmQtdPedido;

implementation

{$R *.dfm}

end.
