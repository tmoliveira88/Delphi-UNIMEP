unit untRelatorios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.ToolWin;

type
  TfrmRelatorios = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    tbRelatoriosB: TToolBar;
    btnRelCaixa: TToolButton;
    btnRelVendas: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton10: TToolButton;
    tbRelatoriosA: TToolBar;
    ToolButton12: TToolButton;
    btnRelClientes: TToolButton;
    ToolButton14: TToolButton;
    btnRelFornecedores: TToolButton;
    ToolButton16: TToolButton;
    btnRelFuncionarios: TToolButton;
    ToolButton18: TToolButton;
    btnRelProdutos: TToolButton;
    ToolButton20: TToolButton;
    btnRelEstoque: TToolButton;
    ToolButton22: TToolButton;
    procedure btnFecharClick(Sender: TObject);
    procedure btnRelCaixaClick(Sender: TObject);
    procedure btnRelClientesClick(Sender: TObject);
    procedure btnRelFornecedoresClick(Sender: TObject);
    procedure btnRelFuncionariosClick(Sender: TObject);
    procedure btnRelProdutosClick(Sender: TObject);
    procedure btnRelEstoqueClick(Sender: TObject);
    procedure btnRelVendasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRelatorios: TfrmRelatorios;

implementation

{$R *.dfm}

uses untPrincipal, untConsultaRel, untRelClientes, untRelFornecedores,
  untRelFuncionarios, untRelProdutos, untRelEstoque, untRelVendas;

procedure TfrmRelatorios.btnRelClientesClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelClientes, frmRelClientes);
  frmRelClientes.ShowModal;
  frmRelClientes.Free;
end;

procedure TfrmRelatorios.btnRelFornecedoresClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelFornecedores, frmRelFornecedores);
  frmRelFornecedores.ShowModal;
  frmRelFornecedores.Free;
end;

procedure TfrmRelatorios.btnRelFuncionariosClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelFuncionarios, frmRelFuncionarios);
  frmRelFuncionarios.ShowModal;
  frmRelFuncionarios.Free;
end;

procedure TfrmRelatorios.btnRelProdutosClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelProdutos, frmRelProdutos);
  frmRelProdutos.ShowModal;
  frmRelProdutos.Free;
end;

procedure TfrmRelatorios.btnRelEstoqueClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelEstoque, frmRelEstoque);
  frmRelEstoque.ShowModal;
  frmRelEstoque.Free;
end;

procedure TfrmRelatorios.btnRelCaixaClick(Sender: TObject);
begin
  Application.CreateForm(TfrmConsultaRel, frmConsultaRel);
  frmConsultaRel.ShowModal;
  frmConsultaRel.Free;
end;

procedure TfrmRelatorios.btnRelVendasClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelVendas, frmRelVendas);
  frmRelVendas.ShowModal;
  frmRelVendas.Free;
end;

procedure TfrmRelatorios.btnFecharClick(Sender: TObject);
begin
  self.close;
end;

end.

