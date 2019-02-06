unit untDM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.ComCtrls, Data.DB, Vcl.Menus,
  Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.StdCtrls, System.Actions,
  Vcl.ActnList, System.ImageList, Vcl.ImgList, Vcl.ToolWin, Data.Win.ADODB;

type
  TDM = class(TDataModule)
    adoConexao: TADOConnection;
    adoFuncionario: TADOTable;
    adoFuncionariofun_id: TAutoIncField;
    adoFuncionariofun_nome: TStringField;
    adoFuncionariofun_usuario: TStringField;
    adoFuncionariofun_senha: TStringField;
    adoFuncionariofun_ativo: TStringField;
    adoFuncionariofun_data_cadastro: TWideStringField;
    adoFuncionariofun_data_inativo: TWideStringField;
    adoFuncionariofun_nivel_permissao: TIntegerField;
    qryLogin: TADOQuery;
    adoCliente: TADOTable;
    adoClientecli_id: TAutoIncField;
    adoClientecli_nome: TStringField;
    adoClientecli_sexo: TStringField;
    adoClientecli_email: TStringField;
    adoClientecli_data_nascimento: TWideStringField;
    adoClientecli_ativo: TStringField;
    adoClientecli_data_cadastro: TWideStringField;
    adoClientecli_data_inativo: TWideStringField;
    adoClientecli_rg: TStringField;
    adoClientecli_telefone: TStringField;
    adoClientecli_celular: TStringField;
    adoClientecli_endereco: TStringField;
    adoClientecli_num_end: TStringField;
    adoClientecli_bairro: TStringField;
    adoClientecli_CEP: TStringField;
    adoClientecli_cid_id: TIntegerField;
    adoClientecli_tipo: TStringField;
    qryLoginfun_usuario: TStringField;
    qryLoginfun_senha: TStringField;
    adoFornecedores: TADOTable;
    adoFornecedoresfor_id: TAutoIncField;
    adoFornecedoresfor_razaosocial_nome: TStringField;
    adoFornecedoresfor_nome_fantasia: TStringField;
    adoFornecedoresfor_email: TStringField;
    adoFornecedoresfor_ativo: TStringField;
    adoFornecedoresfor_data_cadastro: TWideStringField;
    adoFornecedoresfor_data_inativo: TWideStringField;
    adoFornecedoresfor_rg_ie: TStringField;
    adoFornecedoresfor_telefone: TStringField;
    adoFornecedoresfor_celular: TStringField;
    adoFornecedoresfor_endereco: TStringField;
    adoFornecedoresfor_num_end: TStringField;
    adoFornecedoresfor_bairro: TStringField;
    adoFornecedoresfor_CEP: TStringField;
    adoFornecedoresfor_cid_id: TIntegerField;
    adoFornecedoresfor_tipo: TStringField;
    adoProdutos: TADOTable;
    adoProdutospro_id: TLargeintField;
    adoProdutospro_nome: TStringField;
    adoProdutospro_foto: TBlobField;
    adoProdutospro_preco: TBCDField;
    adoProdutospro_custo: TBCDField;
    adoProdutospro_atividade: TStringField;
    adoProdutospro_quantidade: TIntegerField;
    adoProdutospro_qtd_alerta: TIntegerField;
    adoProdutospro_data_cadastro: TWideStringField;
    adoProdutospro_data_inativo: TWideStringField;
    adoProdutospro_peso: TFloatField;
    adoProdutospro_id_for: TIntegerField;
    AdoConfig: TADOTable;
    AdoConfigconf_id: TAutoIncField;
    AdoConfigconf_razao_social: TStringField;
    AdoConfigconf_nome_fantasia: TStringField;
    AdoConfigconf_cnpj: TStringField;
    AdoConfigconf_tel: TStringField;
    AdoConfigconf_cel: TStringField;
    AdoConfigconf_email: TStringField;
    AdoConfigconf_site: TStringField;
    AdoConfigconf_endereco: TStringField;
    AdoConfigconf_num_end: TStringField;
    AdoConfigconf_bairro: TStringField;
    AdoConfigconf_CEP: TStringField;
    AdoConfigconf_cid_id: TIntegerField;
    QryProdutos: TADOQuery;
    qryRelCaixa: TADOQuery;
    qryRelItemCaixa: TADOQuery;
    qryRelCaixacai_id: TLargeintField;
    qryRelCaixacai_data_abertura: TWideStringField;
    qryRelCaixacai_data_fechamento: TWideStringField;
    qryRelCaixacai_hora_abertura: TWideStringField;
    qryRelCaixacai_hora_fechamento: TWideStringField;
    qryRelCaixacai_saldo_inicial: TBCDField;
    qryRelCaixacai_saldo_total: TBCDField;
    qryRelItemCaixaven_id: TLargeintField;
    qryRelItemCaixaven_cliente: TIntegerField;
    qryRelItemCaixaven_caixa: TIntegerField;
    qryRelItemCaixaven_total: TBCDField;
    qryRelItemCaixaven_data: TWideStringField;
    qryRelItemCaixaven_status: TStringField;
    qryRelItemCaixaven_hora: TWideStringField;
    qryRelItemCaixaven_caixaid: TLargeintField;
    qryRelItemCaixaven_saida: TBCDField;
    qryRelItemCaixaven_descricao: TStringField;
    qryRelItemCaixaven_pago: TBCDField;
    qryRelItemCaixaven_forma_pagamento: TStringField;
    qryRelItemVenda: TADOQuery;
    qryPagamentos: TADOQuery;
    qryPagamentospag_id_venda: TLargeintField;
    qryPagamentospag_observacao: TStringField;
    qryPagamentospag_forma_pagamento: TStringField;
    qryPagamentospag_id: TAutoIncField;
    qryPagamentospag_valor: TBCDField;
    qryPagamentospag_n_autorizacao: TIntegerField;
    qryPagamentospag_card: TStringField;
    qryPagamentospag_idcaixa: TLargeintField;
    qryPagamentospag_cliente: TIntegerField;
    adoVenda: TADOTable;
    qryVendaItem: TADOQuery;
    adoCaixa: TADOTable;
    qryCalculaTotal: TADOQuery;
    adoCaixacai_id: TLargeintField;
    adoCaixacai_data_abertura: TWideStringField;
    adoCaixacai_data_fechamento: TWideStringField;
    adoCaixacai_hora_abertura: TWideStringField;
    adoCaixacai_hora_fechamento: TWideStringField;
    adoCaixacai_saldo_inicial: TBCDField;
    adoCaixacai_saldo_total: TBCDField;
    qryVendaItemvi_id: TLargeintField;
    qryVendaItemvi_produto: TLargeintField;
    qryVendaItemvi_venda: TLargeintField;
    qryVendaItemvi_valor: TBCDField;
    qryVendaItemvi_quantidade: TIntegerField;
    qryVendaItemvi_total: TBCDField;
    qryVendaItemvi_peso: TFloatField;
    qryVendaItempro_nome: TStringField;
    qryVendaItempro_preco: TBCDField;
    qryVendaItempro_quantidade: TIntegerField;
    qryVendaItempro_peso: TFloatField;
    qryVendaItempro_atividade: TStringField;
    QryProdutospro_id: TLargeintField;
    QryProdutospro_nome: TStringField;
    QryProdutospro_foto: TBlobField;
    QryProdutospro_preco: TBCDField;
    QryProdutospro_custo: TBCDField;
    QryProdutospro_atividade: TStringField;
    QryProdutospro_quantidade: TIntegerField;
    QryProdutospro_qtd_alerta: TIntegerField;
    QryProdutospro_data_cadastro: TWideStringField;
    QryProdutospro_data_inativo: TWideStringField;
    QryProdutospro_peso: TFloatField;
    QryProdutospro_id_for: TIntegerField;
    adoVendaven_id: TLargeintField;
    adoVendaven_cliente: TIntegerField;
    adoVendaven_caixa: TIntegerField;
    adoVendaven_total: TBCDField;
    adoVendaven_pago: TBCDField;
    adoVendaven_data: TWideStringField;
    adoVendaven_status: TStringField;
    adoVendaven_hora: TWideStringField;
    adoVendaven_caixaid: TLargeintField;
    adoVendaven_saida: TBCDField;
    adoVendaven_descricao: TStringField;
    adoVendaven_forma_pagamento: TStringField;
    qryRelItemVendavi_id: TLargeintField;
    qryRelItemVendavi_produto: TLargeintField;
    qryRelItemVendavi_venda: TLargeintField;
    qryRelItemVendavi_valor: TBCDField;
    qryRelItemVendavi_quantidade: TIntegerField;
    qryRelItemVendavi_peso: TFloatField;
    qryRelItemVendavi_total: TBCDField;
    qryRelItemVendapro_nome: TStringField;
    qryTotalPagamentos: TADOQuery;
    qryTotalCaixa: TADOQuery;
    qryVendaComanda: TADOQuery;
    qryVendaComandaven_id: TLargeintField;
    qryVendaComandaven_cliente: TIntegerField;
    qryVendaComandaven_caixa: TIntegerField;
    qryVendaComandaven_total: TBCDField;
    qryVendaComandaven_pago: TBCDField;
    qryVendaComandaven_data: TWideStringField;
    qryVendaComandaven_status: TStringField;
    qryVendaComandaven_hora: TWideStringField;
    qryVendaComandaven_caixaid: TLargeintField;
    qryVendaComandaven_saida: TBCDField;
    qryVendaComandaven_descricao: TStringField;
    qryVendaComandaven_forma_pagamento: TStringField;
    qryClientes: TADOQuery;
    qryClientescli_id: TAutoIncField;
    qryClientescli_nome: TStringField;
    qryClientescli_sexo: TStringField;
    qryClientescli_email: TStringField;
    qryClientescli_data_nascimento: TWideStringField;
    qryClientescli_ativo: TStringField;
    qryClientescli_data_cadastro: TWideStringField;
    qryClientescli_data_inativo: TWideStringField;
    qryClientescli_rg: TStringField;
    qryClientescli_telefone: TStringField;
    qryClientescli_celular: TStringField;
    qryClientescli_endereco: TStringField;
    qryClientescli_num_end: TStringField;
    qryClientescli_bairro: TStringField;
    qryClientescli_CEP: TStringField;
    qryClientescli_cid_id: TIntegerField;
    qryClientescli_tipo: TStringField;
    qryCliFunc: TADOQuery;
    qryCliFunccli_nome: TStringField;
    qryCliFuncfun_nome: TStringField;
    qryVendaItemCmd: TADOQuery;
    qryVendaItemCmdvi_id: TLargeintField;
    qryVendaItemCmdvi_produto: TLargeintField;
    qryVendaItemCmdvi_venda: TLargeintField;
    qryVendaItemCmdvi_valor: TBCDField;
    qryVendaItemCmdvi_quantidade: TIntegerField;
    qryVendaItemCmdvi_total: TBCDField;
    qryVendaItemCmdvi_peso: TFloatField;
    qryVendaItemCmdpro_nome: TStringField;
    qryVendaItemCmdpro_preco: TBCDField;
    qryVendaItemCmdpro_quantidade: TIntegerField;
    qryVendaItemCmdpro_peso: TFloatField;
    qryVendaItemCmdpro_atividade: TStringField;
    qryTotalPagamentosstr: TFMTBCDField;
    qryTotalCaixaSOMA: TFMTBCDField;
    qryCalculaTotalTotal: TFMTBCDField;
    qrySangria: TADOQuery;
    qrySangriaSTOTAL: TFMTBCDField;
    qryAcrescimos: TADOQuery;
    qryCDinheiro: TADOQuery;
    qryCCredito: TADOQuery;
    qryCDebito: TADOQuery;
    qryAcrescimosATOTAL: TFMTBCDField;
    qryCDinheiroDTOTAL: TFMTBCDField;
    qryCCreditoCTOTAL: TFMTBCDField;
    qryCDebitoDDTOTAL: TFMTBCDField;
    qryCaixaFinal: TADOQuery;
    qryCaixaFinalven_id: TLargeintField;
    qryCaixaFinalven_cliente: TIntegerField;
    qryCaixaFinalven_caixa: TIntegerField;
    qryCaixaFinalven_total: TBCDField;
    qryCaixaFinalven_pago: TBCDField;
    qryCaixaFinalven_data: TWideStringField;
    qryCaixaFinalven_status: TStringField;
    qryCaixaFinalven_hora: TWideStringField;
    qryCaixaFinalven_caixaid: TLargeintField;
    qryCaixaFinalven_saida: TBCDField;
    qryCaixaFinalven_descricao: TStringField;
    qryCaixaFinalven_forma_pagamento: TStringField;
    qryTotalCaixas: TADOQuery;
    qryTotalCaixasSOMA: TFMTBCDField;
    qryVerificaCmd: TADOQuery;
    qryVerificaCmdven_caixaid: TLargeintField;
    qryVerificaCmdven_status: TStringField;
    qryClientescli_estado: TStringField;
    adoClientecli_estado: TStringField;
    qryCidade: TADOQuery;
    qryCidadecid_id: TAutoIncField;
    qryCidadecid_nome: TStringField;
    AdoConfigconf_estado: TStringField;
    adoFornecedoresfor_estado: TStringField;
    AdoConfigconf_ie: TStringField;
    qryFornecedores: TADOQuery;
    qryFornecedoresfor_id: TAutoIncField;
    qryFornecedoresfor_razaosocial_nome: TStringField;
    qryFornecedoresfor_nome_fantasia: TStringField;
    qryFornecedoresfor_email: TStringField;
    qryFornecedoresfor_ativo: TStringField;
    qryFornecedoresfor_data_cadastro: TWideStringField;
    qryFornecedoresfor_data_inativo: TWideStringField;
    qryFornecedoresfor_cpf_cnpj: TStringField;
    qryFornecedoresfor_rg_ie: TStringField;
    qryFornecedoresfor_telefone: TStringField;
    qryFornecedoresfor_celular: TStringField;
    qryFornecedoresfor_endereco: TStringField;
    qryFornecedoresfor_num_end: TStringField;
    qryFornecedoresfor_bairro: TStringField;
    qryFornecedoresfor_CEP: TStringField;
    qryFornecedoresfor_cid_id: TIntegerField;
    qryFornecedoresfor_estado: TStringField;
    qryFornecedoresfor_tipo: TStringField;
    adoClientecli_cpf: TStringField;
    qryClientescli_cpf: TStringField;
    adoFornecedoresfor_cpf_cnpj: TStringField;
    qryRelItemCaixacli_nome: TStringField;
    procedure qryLoginBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untPrincipal, untLogIn;

{$R *.dfm}

procedure TDM.qryLoginBeforeOpen(DataSet: TDataSet);
begin
      qryLogin.Parameters.Parambyname('fun_usuario').Value := frmLogin.edtUsuario.Text;
      qryLogin.Parameters.Parambyname('fun_senha').Value := frmLogin.edtSenha.Text;

   frmprincipal.stbPrincipal.Panels[1].Text:='Usuário em sessão: '+frmLogin.edtUsuario.Text;

   adoFuncionario.Open;
   adoFuncionario.Active;

   if adoFuncionario.Locate('fun_usuario', qryLogin.Parameters.ParamByName('fun_usuario').Value, [loCaseInsensitive]) then
   begin
   frmprincipal.iddocaixa := DM.adoFuncionariofun_id.AsInteger;

         if adoFuncionariofun_nivel_permissao.Value = 1 then
         begin
           frmprincipal.ToolBar1.Visible := true;
           frmprincipal.btnEstoque.Visible := true;
           frmprincipal.btnProdutos.Visible := true;
           frmprincipal.btnFuncionarios.Visible := true;
           frmPrincipal.btnRelatorios.Visible := true;
           frmprincipal.ToolButton9.Visible := true;
         end
         else if adoFuncionariofun_nivel_permissao.Value = 2 then
         begin
           frmprincipal.ToolBar1.Visible := true;
           frmprincipal.btnEstoque.Visible := true;
           frmprincipal.btnProdutos.Visible := true;
           frmprincipal.btnFuncionarios.Visible := false;
           frmPrincipal.btnRelatorios.Visible := true;
           frmprincipal.ToolButton9.Visible := true;
         end
         else if adoFuncionariofun_nivel_permissao.Value = 3 then
         begin
           frmprincipal.ToolBar1.Visible := true;
           frmprincipal.btnEstoque.Visible := true;
           frmprincipal.btnProdutos.Visible := false;
           frmprincipal.btnFuncionarios.Visible := false;
           frmPrincipal.btnRelatorios.Visible := false;
           frmprincipal.ToolButton9.Visible := true;
         end
         else if adoFuncionariofun_nivel_permissao.Value = 4 then
         begin
           frmprincipal.ToolBar1.Visible := false;
           frmprincipal.btnEstoque.Visible := false;
           frmprincipal.btnProdutos.Visible := false;
           frmprincipal.btnFuncionarios.Visible := false;
           frmPrincipal.btnRelatorios.Visible := false;
           frmprincipal.ToolButton9.Visible := false;
         end;
   end;
end;

end.
