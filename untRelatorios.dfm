object frmRelatorios: TfrmRelatorios
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '.:: Relat'#243'rios Gerenciais ::.'
  ClientHeight = 447
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 752
    Height = 82
    Align = alTop
    FullRepaint = False
    TabOrder = 0
    object Label1: TLabel
      Left = 155
      Top = 12
      Width = 410
      Height = 59
      Alignment = taCenter
      Caption = 'Relat'#243'rios Gerenciais'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -48
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 82
    Width = 752
    Height = 365
    Align = alClient
    TabOrder = 1
    object tbRelatoriosB: TToolBar
      Left = 8
      Top = 160
      Width = 734
      Height = 90
      Align = alNone
      ButtonHeight = 74
      ButtonWidth = 95
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      Images = frmPrincipal.ilPrincipal48
      ParentFont = False
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = False
      TabOrder = 0
      Transparent = False
      object ToolButton10: TToolButton
        Left = 0
        Top = 0
        Width = 60
        Caption = 'ToolButton10'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnRelCaixa: TToolButton
        Left = 60
        Top = 0
        Caption = '      Caixa       '
        ImageIndex = 0
        OnClick = btnRelCaixaClick
      end
      object ToolButton6: TToolButton
        Left = 155
        Top = 0
        Width = 36
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnRelVendas: TToolButton
        Left = 191
        Top = 0
        Caption = 'Vendas'
        ImageIndex = 166
        OnClick = btnRelVendasClick
      end
      object ToolButton7: TToolButton
        Left = 286
        Top = 0
        Width = 36
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
    object tbRelatoriosA: TToolBar
      Left = 8
      Top = 40
      Width = 737
      Height = 90
      Align = alNone
      ButtonHeight = 74
      ButtonWidth = 94
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Calibri'
      Font.Style = []
      Images = frmPrincipal.ilPrincipal48
      ParentFont = False
      ParentShowHint = False
      ShowCaptions = True
      ShowHint = False
      TabOrder = 1
      Transparent = False
      object ToolButton12: TToolButton
        Left = 0
        Top = 0
        Width = 60
        Margins.Left = 0
        Caption = 'ToolButton10'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnRelClientes: TToolButton
        Left = 60
        Top = 0
        Caption = 'Clientes'
        ImageIndex = 152
        OnClick = btnRelClientesClick
      end
      object ToolButton14: TToolButton
        Left = 154
        Top = 0
        Width = 36
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnRelFornecedores: TToolButton
        Left = 190
        Top = 0
        Caption = 'Fornecedores'
        ImageIndex = 176
        OnClick = btnRelFornecedoresClick
      end
      object ToolButton16: TToolButton
        Left = 284
        Top = 0
        Width = 36
        Caption = 'ToolButton7'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnRelFuncionarios: TToolButton
        Left = 320
        Top = 0
        Caption = 'Funcion'#225'rios'
        ImageIndex = 160
        OnClick = btnRelFuncionariosClick
      end
      object ToolButton18: TToolButton
        Left = 414
        Top = 0
        Width = 36
        Caption = 'ToolButton8'
        ImageIndex = 5
        Style = tbsSeparator
      end
      object btnRelProdutos: TToolButton
        Left = 450
        Top = 0
        Caption = 'Produtos'
        ImageIndex = 164
        OnClick = btnRelProdutosClick
      end
      object ToolButton20: TToolButton
        Left = 544
        Top = 0
        Width = 36
        Caption = 'ToolButton9'
        ImageIndex = 6
        Style = tbsSeparator
      end
      object btnRelEstoque: TToolButton
        Left = 580
        Top = 0
        Caption = 'Estoque'
        ImageIndex = 161
        OnClick = btnRelEstoqueClick
      end
      object ToolButton22: TToolButton
        Left = 674
        Top = 0
        Width = 60
        Caption = 'ToolButton11'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
  end
end
