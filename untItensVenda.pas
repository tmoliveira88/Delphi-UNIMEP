unit untItensVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TfrmItensVenda = class(TForm)
    Panel2: TPanel;
    lbFiltro: TLabel;
    edtFiltro: TEdit;
    Button1: TButton;
    Panel3: TPanel;
    dsVendaItem: TDataSource;
    dbgProdutos: TDBGrid;
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItensVenda: TfrmItensVenda;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmItensVenda.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfrmItensVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dsvendaitem.DataSet.Close;
DM.qryPagamentos.Close;
end;

procedure TfrmItensVenda.FormShow(Sender: TObject);
begin
dsvendaitem.DataSet.Open;
DM.qryPagamentos.Open;
dsvendaitem.DataSet.Refresh;
DM.qryPagamentos.Refresh;
dsvendaitem.DataSet.First;
end;

end.
