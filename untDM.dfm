object DM: TDM
  OldCreateOrder = False
  Height = 644
  Width = 1017
  object adoConexao: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security In' +
      'fo=False;Initial Catalog=SIS_VENDAS;Data Source=NOTETMOLIVEIRA\S' +
      'QLEXPRESS;Use Procedure for Prepare=1;Auto Translate=True;Packet' +
      ' Size=4096;Workstation ID=NOTETMOLIVEIRA;Use Encryption for Data' +
      '=False;Tag with column collation when possible=False'
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 248
  end
  object adoFuncionario: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'fun_funcionario'
    Left = 56
    Top = 24
    object adoFuncionariofun_id: TAutoIncField
      FieldName = 'fun_id'
      ReadOnly = True
    end
    object adoFuncionariofun_nome: TStringField
      FieldName = 'fun_nome'
      Size = 80
    end
    object adoFuncionariofun_usuario: TStringField
      FieldName = 'fun_usuario'
      Size = 10
    end
    object adoFuncionariofun_senha: TStringField
      FieldName = 'fun_senha'
      Size = 15
    end
    object adoFuncionariofun_ativo: TStringField
      FieldName = 'fun_ativo'
      FixedChar = True
      Size = 1
    end
    object adoFuncionariofun_data_cadastro: TWideStringField
      FieldName = 'fun_data_cadastro'
      Size = 19
    end
    object adoFuncionariofun_data_inativo: TWideStringField
      FieldName = 'fun_data_inativo'
      Size = 19
    end
    object adoFuncionariofun_nivel_permissao: TIntegerField
      FieldName = 'fun_nivel_permissao'
    end
  end
  object qryLogin: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    BeforeOpen = qryLoginBeforeOpen
    Parameters = <
      item
        Name = 'fun_usuario'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end
      item
        Name = 'fun_senha'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 15
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      'fun_usuario, fun_senha'
      'FROM'
      'fun_funcionario'
      'WHERE'
      'fun_usuario = :fun_usuario'
      'AND'
      'fun_senha = :fun_senha')
    Left = 120
    Top = 248
    object qryLoginfun_usuario: TStringField
      FieldName = 'fun_usuario'
      Size = 10
    end
    object qryLoginfun_senha: TStringField
      FieldName = 'fun_senha'
      Size = 15
    end
  end
  object adoCliente: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'cli_cliente'
    Left = 168
    Top = 24
    object adoClientecli_id: TAutoIncField
      FieldName = 'cli_id'
      ReadOnly = True
    end
    object adoClientecli_nome: TStringField
      FieldName = 'cli_nome'
      Size = 80
    end
    object adoClientecli_sexo: TStringField
      FieldName = 'cli_sexo'
      FixedChar = True
      Size = 1
    end
    object adoClientecli_email: TStringField
      FieldName = 'cli_email'
      Size = 80
    end
    object adoClientecli_data_nascimento: TWideStringField
      FieldName = 'cli_data_nascimento'
      EditMask = '!99/99/0000;1;_'
      Size = 10
    end
    object adoClientecli_ativo: TStringField
      FieldName = 'cli_ativo'
      FixedChar = True
      Size = 1
    end
    object adoClientecli_data_cadastro: TWideStringField
      FieldName = 'cli_data_cadastro'
      Size = 19
    end
    object adoClientecli_cpf: TStringField
      FieldName = 'cli_cpf'
      Size = 18
    end
    object adoClientecli_data_inativo: TWideStringField
      FieldName = 'cli_data_inativo'
      Size = 19
    end
    object adoClientecli_rg: TStringField
      FieldName = 'cli_rg'
    end
    object adoClientecli_telefone: TStringField
      FieldName = 'cli_telefone'
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 13
    end
    object adoClientecli_celular: TStringField
      FieldName = 'cli_celular'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 14
    end
    object adoClientecli_endereco: TStringField
      FieldName = 'cli_endereco'
      Size = 50
    end
    object adoClientecli_num_end: TStringField
      FieldName = 'cli_num_end'
      Size = 6
    end
    object adoClientecli_bairro: TStringField
      FieldName = 'cli_bairro'
      Size = 50
    end
    object adoClientecli_CEP: TStringField
      FieldName = 'cli_CEP'
      EditMask = '00.000\-999;1;_'
      Size = 10
    end
    object adoClientecli_cid_id: TIntegerField
      FieldName = 'cli_cid_id'
    end
    object adoClientecli_tipo: TStringField
      FieldName = 'cli_tipo'
      FixedChar = True
      Size = 1
    end
    object adoClientecli_estado: TStringField
      FieldName = 'cli_estado'
      Size = 70
    end
  end
  object adoFornecedores: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'for_fornecedor'
    Left = 264
    Top = 24
    object adoFornecedoresfor_id: TAutoIncField
      FieldName = 'for_id'
      ReadOnly = True
    end
    object adoFornecedoresfor_razaosocial_nome: TStringField
      FieldName = 'for_razaosocial_nome'
      Size = 80
    end
    object adoFornecedoresfor_nome_fantasia: TStringField
      FieldName = 'for_nome_fantasia'
      Size = 50
    end
    object adoFornecedoresfor_email: TStringField
      FieldName = 'for_email'
      Size = 80
    end
    object adoFornecedoresfor_ativo: TStringField
      FieldName = 'for_ativo'
      FixedChar = True
      Size = 1
    end
    object adoFornecedoresfor_data_cadastro: TWideStringField
      FieldName = 'for_data_cadastro'
      Size = 19
    end
    object adoFornecedoresfor_data_inativo: TWideStringField
      FieldName = 'for_data_inativo'
      Size = 19
    end
    object adoFornecedoresfor_cpf_cnpj: TStringField
      FieldName = 'for_cpf_cnpj'
      Size = 18
    end
    object adoFornecedoresfor_rg_ie: TStringField
      FieldName = 'for_rg_ie'
    end
    object adoFornecedoresfor_telefone: TStringField
      FieldName = 'for_telefone'
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 13
    end
    object adoFornecedoresfor_celular: TStringField
      FieldName = 'for_celular'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 14
    end
    object adoFornecedoresfor_endereco: TStringField
      FieldName = 'for_endereco'
      Size = 50
    end
    object adoFornecedoresfor_num_end: TStringField
      FieldName = 'for_num_end'
      Size = 6
    end
    object adoFornecedoresfor_bairro: TStringField
      FieldName = 'for_bairro'
      Size = 50
    end
    object adoFornecedoresfor_CEP: TStringField
      FieldName = 'for_CEP'
      EditMask = '00.000\-999;1;_'
      Size = 10
    end
    object adoFornecedoresfor_cid_id: TIntegerField
      FieldName = 'for_cid_id'
    end
    object adoFornecedoresfor_tipo: TStringField
      FieldName = 'for_tipo'
      FixedChar = True
      Size = 1
    end
    object adoFornecedoresfor_estado: TStringField
      FieldName = 'for_estado'
      Size = 70
    end
  end
  object adoProdutos: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'pro_produto'
    Left = 368
    Top = 24
    object adoProdutospro_id: TLargeintField
      FieldName = 'pro_id'
    end
    object adoProdutospro_nome: TStringField
      FieldName = 'pro_nome'
      Size = 80
    end
    object adoProdutospro_foto: TBlobField
      FieldName = 'pro_foto'
    end
    object adoProdutospro_preco: TBCDField
      FieldName = 'pro_preco'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object adoProdutospro_custo: TBCDField
      FieldName = 'pro_custo'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object adoProdutospro_atividade: TStringField
      FieldName = 'pro_atividade'
      Size = 1
    end
    object adoProdutospro_quantidade: TIntegerField
      FieldName = 'pro_quantidade'
    end
    object adoProdutospro_qtd_alerta: TIntegerField
      FieldName = 'pro_qtd_alerta'
    end
    object adoProdutospro_data_cadastro: TWideStringField
      FieldName = 'pro_data_cadastro'
      Size = 19
    end
    object adoProdutospro_data_inativo: TWideStringField
      FieldName = 'pro_data_inativo'
      Size = 19
    end
    object adoProdutospro_peso: TFloatField
      FieldName = 'pro_peso'
    end
    object adoProdutospro_id_for: TIntegerField
      FieldName = 'pro_id_for'
    end
  end
  object AdoConfig: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'conf_config'
    Left = 464
    Top = 24
    object AdoConfigconf_id: TAutoIncField
      FieldName = 'conf_id'
      ReadOnly = True
    end
    object AdoConfigconf_razao_social: TStringField
      FieldName = 'conf_razao_social'
      Size = 100
    end
    object AdoConfigconf_nome_fantasia: TStringField
      FieldName = 'conf_nome_fantasia'
      Size = 50
    end
    object AdoConfigconf_cnpj: TStringField
      FieldName = 'conf_cnpj'
      Size = 18
    end
    object AdoConfigconf_tel: TStringField
      FieldName = 'conf_tel'
      Size = 13
    end
    object AdoConfigconf_cel: TStringField
      FieldName = 'conf_cel'
      Size = 14
    end
    object AdoConfigconf_email: TStringField
      FieldName = 'conf_email'
      Size = 80
    end
    object AdoConfigconf_site: TStringField
      FieldName = 'conf_site'
      Size = 50
    end
    object AdoConfigconf_endereco: TStringField
      FieldName = 'conf_endereco'
      Size = 50
    end
    object AdoConfigconf_num_end: TStringField
      FieldName = 'conf_num_end'
      Size = 6
    end
    object AdoConfigconf_bairro: TStringField
      FieldName = 'conf_bairro'
      Size = 50
    end
    object AdoConfigconf_CEP: TStringField
      FieldName = 'conf_CEP'
      Size = 10
    end
    object AdoConfigconf_cid_id: TIntegerField
      FieldName = 'conf_cid_id'
    end
    object AdoConfigconf_estado: TStringField
      FieldName = 'conf_estado'
      Size = 70
    end
    object AdoConfigconf_ie: TStringField
      FieldName = 'conf_ie'
    end
  end
  object QryProdutos: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' p.*'
      'FROM'
      ' pro_produto p'
      'WHERE'
      ' p.pro_atividade = '#39'S'#39)
    Left = 368
    Top = 96
    object QryProdutospro_id: TLargeintField
      FieldName = 'pro_id'
    end
    object QryProdutospro_nome: TStringField
      FieldName = 'pro_nome'
      Size = 80
    end
    object QryProdutospro_foto: TBlobField
      FieldName = 'pro_foto'
    end
    object QryProdutospro_preco: TBCDField
      FieldName = 'pro_preco'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object QryProdutospro_custo: TBCDField
      FieldName = 'pro_custo'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object QryProdutospro_atividade: TStringField
      FieldName = 'pro_atividade'
      Size = 1
    end
    object QryProdutospro_quantidade: TIntegerField
      FieldName = 'pro_quantidade'
    end
    object QryProdutospro_qtd_alerta: TIntegerField
      FieldName = 'pro_qtd_alerta'
    end
    object QryProdutospro_data_cadastro: TWideStringField
      FieldName = 'pro_data_cadastro'
      Size = 19
    end
    object QryProdutospro_data_inativo: TWideStringField
      FieldName = 'pro_data_inativo'
      Size = 19
    end
    object QryProdutospro_peso: TFloatField
      FieldName = 'pro_peso'
    end
    object QryProdutospro_id_for: TIntegerField
      FieldName = 'pro_id_for'
    end
  end
  object qryRelCaixa: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'data1'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end
      item
        Name = 'data2'
        DataType = ftWideString
        NumericScale = 255
        Precision = 255
        Size = 10
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' cai_id,'
      ' cai_data_abertura,'
      ' cai_data_fechamento,'
      ' cai_hora_abertura,'
      ' cai_hora_fechamento,'
      ' cai_saldo_inicial,'
      ' cai_saldo_total'
      'FROM'
      ' cai_caixa'
      'WHERE'
      ' cai_data_abertura between :data1 '
      'AND'
      ' :data2'
      'AND'
      ' cai_data_fechamento <> '#39#39)
    Left = 184
    Top = 472
    object qryRelCaixacai_id: TLargeintField
      FieldName = 'cai_id'
      ReadOnly = True
    end
    object qryRelCaixacai_data_abertura: TWideStringField
      FieldName = 'cai_data_abertura'
      Size = 10
    end
    object qryRelCaixacai_data_fechamento: TWideStringField
      FieldName = 'cai_data_fechamento'
      Size = 10
    end
    object qryRelCaixacai_hora_abertura: TWideStringField
      FieldName = 'cai_hora_abertura'
      Size = 8
    end
    object qryRelCaixacai_hora_fechamento: TWideStringField
      FieldName = 'cai_hora_fechamento'
      Size = 8
    end
    object qryRelCaixacai_saldo_inicial: TBCDField
      FieldName = 'cai_saldo_inicial'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryRelCaixacai_saldo_total: TBCDField
      FieldName = 'cai_saldo_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryRelItemCaixa: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'iddocaixa'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' ven_id,'
      ' ven_cliente,'
      ' ven_caixa,'
      ' ven_total,'
      ' ven_data,'
      ' ven_status,'
      ' ven_hora,'
      ' ven_caixaid,'
      ' ven_saida,'
      ' ven_descricao,'
      ' ven_pago,'
      ' ven_forma_pagamento,'
      ' cli_nome'
      'FROM'
      'ven_venda'
      'INNER JOIN cli_cliente'
      'ON ven_cliente = cli_id'
      'WHERE'
      ' ven_caixaid = :iddocaixa')
    Left = 400
    Top = 480
    object qryRelItemCaixaven_id: TLargeintField
      FieldName = 'ven_id'
      ReadOnly = True
    end
    object qryRelItemCaixaven_cliente: TIntegerField
      FieldName = 'ven_cliente'
    end
    object qryRelItemCaixaven_caixa: TIntegerField
      FieldName = 'ven_caixa'
    end
    object qryRelItemCaixaven_total: TBCDField
      FieldName = 'ven_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryRelItemCaixaven_data: TWideStringField
      FieldName = 'ven_data'
      Size = 10
    end
    object qryRelItemCaixaven_status: TStringField
      FieldName = 'ven_status'
      Size = 10
    end
    object qryRelItemCaixaven_hora: TWideStringField
      FieldName = 'ven_hora'
      Size = 8
    end
    object qryRelItemCaixaven_caixaid: TLargeintField
      FieldName = 'ven_caixaid'
    end
    object qryRelItemCaixaven_saida: TBCDField
      FieldName = 'ven_saida'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryRelItemCaixaven_descricao: TStringField
      FieldName = 'ven_descricao'
      Size = 100
    end
    object qryRelItemCaixaven_pago: TBCDField
      FieldName = 'ven_pago'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryRelItemCaixaven_forma_pagamento: TStringField
      FieldName = 'ven_forma_pagamento'
      Size = 8
    end
    object qryRelItemCaixacli_nome: TStringField
      FieldName = 'cli_nome'
      Size = 80
    end
  end
  object qryRelItemVenda: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'v_id'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' vi_id,'
      ' vi_produto,'
      ' vi_venda,'
      ' vi_valor,'
      ' vi_quantidade,'
      ' vi_peso,'
      ' vi_total,'
      ' pro_nome'
      'FROM'
      ' vi_venda_item'
      'INNER JOIN'
      ' pro_produto'
      'ON'
      ' vi_venda_item.vi_produto = pro_produto.pro_id'
      'WHERE'
      ' vi_venda = :v_id')
    Left = 296
    Top = 480
    object qryRelItemVendavi_id: TLargeintField
      FieldName = 'vi_id'
      ReadOnly = True
    end
    object qryRelItemVendavi_produto: TLargeintField
      FieldName = 'vi_produto'
    end
    object qryRelItemVendavi_venda: TLargeintField
      FieldName = 'vi_venda'
    end
    object qryRelItemVendavi_valor: TBCDField
      FieldName = 'vi_valor'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryRelItemVendavi_quantidade: TIntegerField
      FieldName = 'vi_quantidade'
    end
    object qryRelItemVendavi_peso: TFloatField
      FieldName = 'vi_peso'
    end
    object qryRelItemVendavi_total: TBCDField
      FieldName = 'vi_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryRelItemVendapro_nome: TStringField
      FieldName = 'pro_nome'
      Size = 80
    end
  end
  object qryPagamentos: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'idvenda'
        Attributes = [paSigned, paNullable]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' pag_id_venda,'
      ' pag_observacao,'
      ' pag_forma_pagamento,'
      ' pag_id,'
      ' pag_valor,'
      ' pag_n_autorizacao,'
      ' pag_card,'
      ' pag_idcaixa,'
      ' pag_cliente'
      'FROM'
      ' pag_pagamentos'
      'WHERE'
      ' pag_id_venda = :idvenda')
    Left = 552
    Top = 216
    object qryPagamentospag_id_venda: TLargeintField
      FieldName = 'pag_id_venda'
    end
    object qryPagamentospag_observacao: TStringField
      FieldName = 'pag_observacao'
      Size = 30
    end
    object qryPagamentospag_forma_pagamento: TStringField
      FieldName = 'pag_forma_pagamento'
      Size = 8
    end
    object qryPagamentospag_id: TAutoIncField
      FieldName = 'pag_id'
      ReadOnly = True
    end
    object qryPagamentospag_valor: TBCDField
      FieldName = 'pag_valor'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryPagamentospag_n_autorizacao: TIntegerField
      FieldName = 'pag_n_autorizacao'
    end
    object qryPagamentospag_card: TStringField
      FieldName = 'pag_card'
      Size = 10
    end
    object qryPagamentospag_idcaixa: TLargeintField
      FieldName = 'pag_idcaixa'
    end
    object qryPagamentospag_cliente: TIntegerField
      FieldName = 'pag_cliente'
    end
  end
  object adoVenda: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'ven_venda'
    Left = 552
    Top = 24
    object adoVendaven_id: TLargeintField
      FieldName = 'ven_id'
      ReadOnly = True
    end
    object adoVendaven_cliente: TIntegerField
      FieldName = 'ven_cliente'
    end
    object adoVendaven_caixa: TIntegerField
      FieldName = 'ven_caixa'
    end
    object adoVendaven_total: TBCDField
      FieldName = 'ven_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object adoVendaven_pago: TBCDField
      FieldName = 'ven_pago'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object adoVendaven_data: TWideStringField
      FieldName = 'ven_data'
      Size = 10
    end
    object adoVendaven_status: TStringField
      FieldName = 'ven_status'
      Size = 10
    end
    object adoVendaven_hora: TWideStringField
      FieldName = 'ven_hora'
      Size = 8
    end
    object adoVendaven_caixaid: TLargeintField
      FieldName = 'ven_caixaid'
    end
    object adoVendaven_saida: TBCDField
      FieldName = 'ven_saida'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object adoVendaven_descricao: TStringField
      FieldName = 'ven_descricao'
      Size = 100
    end
    object adoVendaven_forma_pagamento: TStringField
      FieldName = 'ven_forma_pagamento'
      Size = 8
    end
  end
  object qryVendaItem: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'vid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' vi.*,'
      ' p.pro_nome,'
      ' p.pro_preco,'
      ' p.pro_quantidade,'
      ' p.pro_peso,'
      ' p.pro_atividade'
      'FROM'
      ' vi_venda_item vi,'
      ' pro_produto p'
      'WHERE'
      
        ' vi.vi_venda = :vid AND vi.vi_produto = p.pro_id AND p.pro_ativi' +
        'dade = '#39'S'#39)
    Left = 552
    Top = 88
    object qryVendaItemvi_produto: TLargeintField
      FieldName = 'vi_produto'
    end
    object qryVendaItemvi_id: TLargeintField
      FieldName = 'vi_id'
      ReadOnly = True
    end
    object qryVendaItemvi_venda: TLargeintField
      FieldName = 'vi_venda'
    end
    object qryVendaItemvi_valor: TBCDField
      FieldName = 'vi_valor'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaItemvi_quantidade: TIntegerField
      FieldName = 'vi_quantidade'
    end
    object qryVendaItemvi_total: TBCDField
      FieldName = 'vi_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaItemvi_peso: TFloatField
      FieldName = 'vi_peso'
    end
    object qryVendaItempro_nome: TStringField
      FieldName = 'pro_nome'
      Size = 80
    end
    object qryVendaItempro_preco: TBCDField
      FieldName = 'pro_preco'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaItempro_quantidade: TIntegerField
      FieldName = 'pro_quantidade'
    end
    object qryVendaItempro_peso: TFloatField
      FieldName = 'pro_peso'
    end
    object qryVendaItempro_atividade: TStringField
      FieldName = 'pro_atividade'
      Size = 1
    end
  end
  object adoCaixa: TADOTable
    Connection = adoConexao
    CursorType = ctStatic
    TableName = 'cai_caixa'
    Left = 624
    Top = 24
    object adoCaixacai_id: TLargeintField
      FieldName = 'cai_id'
      ReadOnly = True
    end
    object adoCaixacai_data_abertura: TWideStringField
      FieldName = 'cai_data_abertura'
      Size = 10
    end
    object adoCaixacai_data_fechamento: TWideStringField
      FieldName = 'cai_data_fechamento'
      Size = 10
    end
    object adoCaixacai_hora_abertura: TWideStringField
      FieldName = 'cai_hora_abertura'
      Size = 8
    end
    object adoCaixacai_hora_fechamento: TWideStringField
      FieldName = 'cai_hora_fechamento'
      Size = 8
    end
    object adoCaixacai_saldo_inicial: TBCDField
      FieldName = 'cai_saldo_inicial'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object adoCaixacai_saldo_total: TBCDField
      FieldName = 'cai_saldo_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
  end
  object qryCalculaTotal: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'idvenda'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' sum(vi_total) as Total'
      'FROM'
      ' vi_venda_item'
      'WHERE'
      ' vi_venda = :idvenda')
    Left = 552
    Top = 152
    object qryCalculaTotalTotal: TFMTBCDField
      FieldName = 'Total'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryTotalPagamentos: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'idvenda'
        Attributes = [paSigned, paNullable]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      'sum(pag_valor) as str'
      'FROM'
      ' pag_pagamentos'
      'WHERE'
      ' pag_pagamentos.pag_id_venda = :idvenda')
    Left = 552
    Top = 272
    object qryTotalPagamentosstr: TFMTBCDField
      FieldName = 'str'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryTotalCaixa: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'caixaid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' sum(ven_pago) as SOMA'
      'FROM'
      ' ven_venda'
      'WHERE'
      ' ven_caixaid = :caixaid AND ven_status <> '#39'ABERTA'#39)
    Left = 552
    Top = 328
    object qryTotalCaixaSOMA: TFMTBCDField
      FieldName = 'SOMA'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryVendaComanda: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' v.*'
      'FROM'
      ' ven_venda v'
      'WHERE'
      ' v.ven_status = '#39'ABERTA'#39)
    Left = 552
    Top = 400
    object qryVendaComandaven_id: TLargeintField
      FieldName = 'ven_id'
      ReadOnly = True
    end
    object qryVendaComandaven_cliente: TIntegerField
      FieldName = 'ven_cliente'
    end
    object qryVendaComandaven_caixa: TIntegerField
      FieldName = 'ven_caixa'
    end
    object qryVendaComandaven_total: TBCDField
      FieldName = 'ven_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaComandaven_pago: TBCDField
      FieldName = 'ven_pago'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaComandaven_data: TWideStringField
      FieldName = 'ven_data'
      Size = 10
    end
    object qryVendaComandaven_status: TStringField
      FieldName = 'ven_status'
      Size = 10
    end
    object qryVendaComandaven_hora: TWideStringField
      FieldName = 'ven_hora'
      Size = 8
    end
    object qryVendaComandaven_caixaid: TLargeintField
      FieldName = 'ven_caixaid'
    end
    object qryVendaComandaven_saida: TBCDField
      FieldName = 'ven_saida'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaComandaven_descricao: TStringField
      FieldName = 'ven_descricao'
      Size = 100
    end
    object qryVendaComandaven_forma_pagamento: TStringField
      FieldName = 'ven_forma_pagamento'
      Size = 8
    end
  end
  object qryClientes: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' c.*'
      'FROM'
      ' cli_cliente c'
      'WHERE'
      ' c.cli_id <> '#39'1'#39' AND c.cli_ativo = '#39'S'#39)
    Left = 168
    Top = 88
    object qryClientescli_id: TAutoIncField
      FieldName = 'cli_id'
      ReadOnly = True
    end
    object qryClientescli_nome: TStringField
      FieldName = 'cli_nome'
      Size = 80
    end
    object qryClientescli_sexo: TStringField
      FieldName = 'cli_sexo'
      FixedChar = True
      Size = 1
    end
    object qryClientescli_email: TStringField
      FieldName = 'cli_email'
      Size = 80
    end
    object qryClientescli_data_nascimento: TWideStringField
      FieldName = 'cli_data_nascimento'
      EditMask = '!99/99/0000;1;_'
      Size = 10
    end
    object qryClientescli_ativo: TStringField
      FieldName = 'cli_ativo'
      FixedChar = True
      Size = 1
    end
    object qryClientescli_data_cadastro: TWideStringField
      FieldName = 'cli_data_cadastro'
      Size = 19
    end
    object qryClientescli_data_inativo: TWideStringField
      FieldName = 'cli_data_inativo'
      Size = 19
    end
    object qryClientescli_rg: TStringField
      FieldName = 'cli_rg'
    end
    object qryClientescli_telefone: TStringField
      FieldName = 'cli_telefone'
      EditMask = '!\(99\)0000-0000;1;_'
      Size = 13
    end
    object qryClientescli_celular: TStringField
      FieldName = 'cli_celular'
      EditMask = '!\(99\)00000-0000;1;_'
      Size = 14
    end
    object qryClientescli_endereco: TStringField
      FieldName = 'cli_endereco'
      Size = 50
    end
    object qryClientescli_num_end: TStringField
      FieldName = 'cli_num_end'
      Size = 6
    end
    object qryClientescli_bairro: TStringField
      FieldName = 'cli_bairro'
      Size = 50
    end
    object qryClientescli_CEP: TStringField
      FieldName = 'cli_CEP'
      EditMask = '00.000\-999;1;_'
      Size = 10
    end
    object qryClientescli_cid_id: TIntegerField
      FieldName = 'cli_cid_id'
    end
    object qryClientescli_tipo: TStringField
      FieldName = 'cli_tipo'
      FixedChar = True
      Size = 1
    end
    object qryClientescli_estado: TStringField
      FieldName = 'cli_estado'
      Size = 70
    end
    object qryClientescli_cpf: TStringField
      FieldName = 'cli_cpf'
      Size = 18
    end
  end
  object qryCliFunc: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'funcid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end
      item
        Name = 'cliid'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    SQL.Strings = (
      'SELECT'
      ' c.cli_nome,'
      ' f.fun_nome'
      'FROM'
      ' fun_funcionario f,'
      ' cli_cliente c'
      'WHERE'
      ' f.fun_id = :funcid AND c.cli_id = :cliid')
    Left = 792
    Top = 128
    object qryCliFunccli_nome: TStringField
      FieldName = 'cli_nome'
      Size = 80
    end
    object qryCliFuncfun_nome: TStringField
      FieldName = 'fun_nome'
      Size = 80
    end
  end
  object qryVendaItemCmd: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'vid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' vi.*,'
      ' p.pro_nome,'
      ' p.pro_preco,'
      ' p.pro_quantidade,'
      ' p.pro_peso,'
      ' p.pro_atividade'
      'FROM'
      ' vi_venda_item vi,'
      ' pro_produto p'
      'WHERE'
      
        ' vi.vi_venda = :vid AND vi.vi_produto = p.pro_id AND p.pro_ativi' +
        'dade = '#39'S'#39)
    Left = 552
    Top = 456
    object qryVendaItemCmdvi_produto: TLargeintField
      FieldName = 'vi_produto'
    end
    object qryVendaItemCmdvi_id: TLargeintField
      FieldName = 'vi_id'
      ReadOnly = True
    end
    object qryVendaItemCmdvi_venda: TLargeintField
      FieldName = 'vi_venda'
    end
    object qryVendaItemCmdvi_valor: TBCDField
      FieldName = 'vi_valor'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaItemCmdvi_quantidade: TIntegerField
      FieldName = 'vi_quantidade'
    end
    object qryVendaItemCmdvi_total: TBCDField
      FieldName = 'vi_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaItemCmdvi_peso: TFloatField
      FieldName = 'vi_peso'
    end
    object qryVendaItemCmdpro_nome: TStringField
      FieldName = 'pro_nome'
      Size = 80
    end
    object qryVendaItemCmdpro_preco: TBCDField
      FieldName = 'pro_preco'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryVendaItemCmdpro_quantidade: TIntegerField
      FieldName = 'pro_quantidade'
    end
    object qryVendaItemCmdpro_peso: TFloatField
      FieldName = 'pro_peso'
    end
    object qryVendaItemCmdpro_atividade: TStringField
      FieldName = 'pro_atividade'
      Size = 1
    end
  end
  object qrySangria: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' sum(ven_saida) as STOTAL,'
      ' ven_status,'
      ' ven_caixaid'
      'FROM'
      ' ven_venda'
      'WHERE'
      
        ' ven_caixaid = (SELECT max(cai_id) from cai_caixa) AND ven_statu' +
        's = '#39'SANGRIA'#39' group by ven_status, ven_caixaid')
    Left = 640
    Top = 216
    object qrySangriaSTOTAL: TFMTBCDField
      FieldName = 'STOTAL'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryAcrescimos: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' sum(ven_total) as ATOTAL,'
      ' ven_status,'
      ' ven_caixaid'
      'FROM'
      ' ven_venda'
      'WHERE'
      
        ' ven_caixaid = (SELECT max(cai_id) from cai_caixa) AND ven_statu' +
        's = '#39'ENTRADA'#39' group by ven_status, ven_caixaid')
    Left = 640
    Top = 272
    object qryAcrescimosATOTAL: TFMTBCDField
      FieldName = 'ATOTAL'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryCDinheiro: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' sum(pag_valor) as DTOTAL,'
      ' pag_forma_pagamento,'
      ' pag_idcaixa'
      'FROM'
      ' pag_pagamentos'
      'WHERE'
      
        ' pag_idcaixa = (SELECT max(cai_id) from cai_caixa) AND pag_forma' +
        '_pagamento = '#39'DINHEIRO'#39' group by pag_forma_pagamento, pag_idcaix' +
        'a')
    Left = 640
    Top = 328
    object qryCDinheiroDTOTAL: TFMTBCDField
      FieldName = 'DTOTAL'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryCCredito: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' sum(pag_valor) as CTOTAL,'
      ' pag_forma_pagamento,'
      ' pag_idcaixa'
      'FROM'
      ' pag_pagamentos'
      'WHERE'
      
        ' pag_idcaixa = (SELECT max(cai_id) from cai_caixa) AND pag_forma' +
        '_pagamento = '#39'CREDITO'#39' group by pag_forma_pagamento, pag_idcaixa'
      '')
    Left = 640
    Top = 400
    object qryCCreditoCTOTAL: TFMTBCDField
      FieldName = 'CTOTAL'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryCDebito: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' sum(pag_valor) as DDTOTAL,'
      ' pag_forma_pagamento,'
      ' pag_idcaixa'
      'FROM'
      ' pag_pagamentos'
      'WHERE'
      
        ' pag_idcaixa = (SELECT max(cai_id) from cai_caixa) AND pag_forma' +
        '_pagamento = '#39'DEBITO'#39' group by pag_forma_pagamento, pag_idcaixa')
    Left = 640
    Top = 456
    object qryCDebitoDDTOTAL: TFMTBCDField
      FieldName = 'DDTOTAL'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryCaixaFinal: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' v.*'
      'FROM'
      ' ven_venda v'
      'WHERE'
      
        ' v.ven_caixaid = (SELECT max(cai_id) from cai_caixa) AND v.ven_s' +
        'tatus <> '#39'ABERTA'#39)
    Left = 640
    Top = 160
    object qryCaixaFinalven_id: TLargeintField
      FieldName = 'ven_id'
      ReadOnly = True
    end
    object qryCaixaFinalven_cliente: TIntegerField
      FieldName = 'ven_cliente'
    end
    object qryCaixaFinalven_caixa: TIntegerField
      FieldName = 'ven_caixa'
    end
    object qryCaixaFinalven_total: TBCDField
      FieldName = 'ven_total'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryCaixaFinalven_pago: TBCDField
      FieldName = 'ven_pago'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryCaixaFinalven_data: TWideStringField
      FieldName = 'ven_data'
      Size = 10
    end
    object qryCaixaFinalven_status: TStringField
      FieldName = 'ven_status'
      Size = 10
    end
    object qryCaixaFinalven_hora: TWideStringField
      FieldName = 'ven_hora'
      Size = 8
    end
    object qryCaixaFinalven_caixaid: TLargeintField
      FieldName = 'ven_caixaid'
    end
    object qryCaixaFinalven_saida: TBCDField
      FieldName = 'ven_saida'
      DisplayFormat = ',R$ #0.00'
      Precision = 18
      Size = 2
    end
    object qryCaixaFinalven_descricao: TStringField
      FieldName = 'ven_descricao'
      Size = 100
    end
    object qryCaixaFinalven_forma_pagamento: TStringField
      FieldName = 'ven_forma_pagamento'
      Size = 8
    end
  end
  object qryTotalCaixas: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT'
      ' sum(ven_total) as SOMA'
      'FROM'
      ' ven_venda'
      'WHERE'
      
        ' ven_caixaid = (SELECT max(cai_id) from cai_caixa) AND ven_statu' +
        's <> '#39'ABERTA'#39)
    Left = 712
    Top = 328
    object qryTotalCaixasSOMA: TFMTBCDField
      FieldName = 'SOMA'
      ReadOnly = True
      DisplayFormat = ',R$ #0.00'
      Precision = 38
      Size = 2
    end
  end
  object qryVerificaCmd: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'caixaid'
        Attributes = [paSigned]
        DataType = ftLargeint
        Precision = 19
        Size = 8
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' ven_caixaid,'
      ' ven_status'
      'FROM'
      ' ven_venda'
      'WHERE'
      ' ven_caixaid = :caixaid and ven_status = '#39'ABERTA'#39)
    Left = 808
    Top = 320
    object qryVerificaCmdven_caixaid: TLargeintField
      FieldName = 'ven_caixaid'
    end
    object qryVerificaCmdven_status: TStringField
      FieldName = 'ven_status'
      Size = 10
    end
  end
  object qryCidade: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'estado'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 100
        Value = Null
      end>
    SQL.Strings = (
      'SELECT'
      ' cid_nome,'
      ' cid_estado,'
      ' cid_id'
      'FROM'
      ' cid_cidade'
      'WHERE'
      ' cid_estado = :estado'
      'ORDER BY cid_nome, cid_estado')
    Left = 168
    Top = 144
    object qryCidadecid_id: TAutoIncField
      FieldName = 'cid_id'
      ReadOnly = True
    end
    object qryCidadecid_nome: TStringField
      FieldName = 'cid_nome'
      Size = 100
    end
  end
  object qryFornecedores: TADOQuery
    Connection = adoConexao
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      'SELECT *'
      'FROM for_fornecedor'
      'WHERE  for_ativo = '#39'S'#39)
    Left = 264
    Top = 88
    object qryFornecedoresfor_id: TAutoIncField
      FieldName = 'for_id'
      ReadOnly = True
    end
    object qryFornecedoresfor_razaosocial_nome: TStringField
      FieldName = 'for_razaosocial_nome'
      Size = 80
    end
    object qryFornecedoresfor_nome_fantasia: TStringField
      FieldName = 'for_nome_fantasia'
      Size = 50
    end
    object qryFornecedoresfor_email: TStringField
      FieldName = 'for_email'
      Size = 80
    end
    object qryFornecedoresfor_ativo: TStringField
      FieldName = 'for_ativo'
      FixedChar = True
      Size = 1
    end
    object qryFornecedoresfor_data_cadastro: TWideStringField
      FieldName = 'for_data_cadastro'
      Size = 19
    end
    object qryFornecedoresfor_data_inativo: TWideStringField
      FieldName = 'for_data_inativo'
      Size = 19
    end
    object qryFornecedoresfor_cpf_cnpj: TStringField
      FieldName = 'for_cpf_cnpj'
      Size = 18
    end
    object qryFornecedoresfor_rg_ie: TStringField
      FieldName = 'for_rg_ie'
    end
    object qryFornecedoresfor_telefone: TStringField
      FieldName = 'for_telefone'
      Size = 13
    end
    object qryFornecedoresfor_celular: TStringField
      FieldName = 'for_celular'
      Size = 14
    end
    object qryFornecedoresfor_endereco: TStringField
      FieldName = 'for_endereco'
      Size = 50
    end
    object qryFornecedoresfor_num_end: TStringField
      FieldName = 'for_num_end'
      Size = 6
    end
    object qryFornecedoresfor_bairro: TStringField
      FieldName = 'for_bairro'
      Size = 50
    end
    object qryFornecedoresfor_CEP: TStringField
      FieldName = 'for_CEP'
      Size = 10
    end
    object qryFornecedoresfor_cid_id: TIntegerField
      FieldName = 'for_cid_id'
    end
    object qryFornecedoresfor_estado: TStringField
      FieldName = 'for_estado'
      Size = 100
    end
    object qryFornecedoresfor_tipo: TStringField
      FieldName = 'for_tipo'
      FixedChar = True
      Size = 1
    end
  end
end
