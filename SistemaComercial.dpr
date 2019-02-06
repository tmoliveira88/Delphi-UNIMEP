program SistemaComercial;

uses
  Vcl.Forms,
  untPrincipal in 'untPrincipal.pas' {frmPrincipal},
  Vcl.Themes,
  Vcl.Styles,
  untCaixa in 'untCaixa.pas' {frmCaixa},
  untLancamentos in 'untLancamentos.pas' {frmLancamentos},
  untVendaCaixa in 'untVendaCaixa.pas' {frmVendaCaixa},
  untAdicionarPedido in 'untAdicionarPedido.pas' {frmAdicionarPedido},
  untPagamentoVCaixa in 'untPagamentoVCaixa.pas' {frmPagamentoVCaixa},
  untPagamentoCredito in 'untPagamentoCredito.pas' {frmPagamentoCredito},
  untPagamentoDinheiro in 'untPagamentoDinheiro.pas' {frmPagamentoDinheiro},
  untPagamentoDebito in 'untPagamentoDebito.pas' {frmPagamentoDebito},
  untLogIn in 'untLogIn.pas' {frmLogIn},
  untDM in 'untDM.pas' {DM: TDataModule},
  untComandas in 'untComandas.pas' {frmComandas},
  untVendaComanda in 'untVendaComanda.pas' {frmVendaComanda},
  untAdicionarComanda in 'untAdicionarComanda.pas' {frmAdicionarComanda},
  untPagamentoCCredito in 'untPagamentoCCredito.pas' {frmPagamentoCCredito},
  untPagamentoCDebito in 'untPagamentoCDebito.pas' {frmPagamentoCDebito},
  untPagamentoCDinheiro in 'untPagamentoCDinheiro.pas' {frmPagamentoCDinheiro},
  untAlimentarEstoque in 'untAlimentarEstoque.pas' {frmAlimentarEstoque},
  untPagamentoVComanda in 'untPagamentoVComanda.pas' {frmPagamentoVComanda},
  untClienteDados in 'untClienteDados.pas' {frmClienteDados},
  untClienteLista in 'untClienteLista.pas' {frmModeloLista},
  untQtdEstoque in 'untQtdEstoque.pas' {frmQtdEstoque},
  untProdutoDados in 'untProdutoDados.pas' {frmProdutoDados},
  untProdutoLista in 'untProdutoLista.pas' {frmProdutoLista},
  untFuncDados in 'untFuncDados.pas' {frmFuncDados},
  untFuncLista in 'untFuncLista.pas' {frmFuncLista},
  untConsultaRel in 'untConsultaRel.pas' {frmConsultaRel},
  untConfig in 'untConfig.pas' {frmConfig},
  untBackup in 'untBackup.pas' {frmBackup},
  untItensVenda in 'untItensVenda.pas' {frmItensVenda},
  untIdCliente in 'untIdCliente.pas' {frmIdCliente},
  untIdeCliente in 'untIdeCliente.pas' {frmIdeCliente},
  untForDados in 'untForDados.pas' {frmForDados},
  untForLista in 'untForLista.pas' {frmForLista},
  untRelatorios in 'untRelatorios.pas' {frmRelatorios},
  untRelClientes in 'untRelClientes.pas' {frmRelClientes},
  untRelFornecedores in 'untRelFornecedores.pas' {frmRelFornecedores},
  untRelFuncionarios in 'untRelFuncionarios.pas' {frmRelFuncionarios},
  untRelProdutos in 'untRelProdutos.pas' {frmRelProdutos},
  untRelEstoque in 'untRelEstoque.pas' {frmRelEstoque},
  untRelVendas in 'untRelVendas.pas' {frmRelVendas};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := ':: Saturn ::';
  TStyleManager.TrySetStyle('Turquoise Gray');
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.CreateForm(TDM, DM);
  Application.Run;
end.
