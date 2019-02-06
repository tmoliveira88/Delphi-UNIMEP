object frmAdicionarComanda: TfrmAdicionarComanda
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '.:: Adicionar Produto ::.'
  ClientHeight = 333
  ClientWidth = 641
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 641
    Height = 56
    Align = alTop
    TabOrder = 0
    ExplicitTop = -5
    object lbFiltro: TLabel
      Left = 114
      Top = 19
      Width = 15
      Height = 15
      Hint = 
        'Para efetuar a pesquisa por outro campo, clique no t'#237'tulo do cam' +
        'po correspondente.'
      Alignment = taRightJustify
      Caption = 'ID:'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
    end
    object edtFiltro: TEdit
      Left = 142
      Top = 16
      Width = 203
      Height = 23
      Hint = 
        'Para efetuar a pesquisa por outro campo, clique no t'#237'tulo do cam' +
        'po correspondente.'
      CharCase = ecUpperCase
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = edtFiltroChange
      OnKeyPress = edtFiltroKeyPress
    end
    object Button1: TButton
      Left = 565
      Top = 1
      Width = 75
      Height = 54
      Align = alRight
      Caption = 'SAIR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = Button1Click
    end
    object btnFiltro: TBitBtn
      Left = 368
      Top = 12
      Width = 111
      Height = 32
      Caption = 'Pesquisar'
      Default = True
      Enabled = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      Glyph.Data = {
        82060000424D8206000000000000420000002800000014000000140000000100
        20000300000040060000983A0000983A000000000000000000000000FF0000FF
        0000FF0000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000030000000200000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000000000000000000595449005D5748123E3D3B6213131353080808300000
        0009000000000000000000000000000000000000000000000000000000000000
        000000000000000000000000000000000000000000000009370000000002354C
        9C63828795EC807F7EE64D4D4DB7070707342323230000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000054E00000000030730C0542163F1DF6FA6E1FFC7CCCDFF828180E91515
        1551000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000E5500000000040832C1582264F3E14AA2
        FFFF62C5FEFF83B8E4FF8E9299F2363635650000000300000000000000000000
        0000000000000000000000000000000000000000000000000000000249000000
        000A072FB65D2366F3E24BA3FFFF62C6FFFF52AFFFFF3077F4EF4A60A18A5B55
        461FFFFFFF000000000000000000000000000000000000000000000000070000
        000F00000010000000076561530F52587285295ECAE84BA4FDFF63C7FFFF52AD
        FFFF2C74F8EE0E3ED07100014D09001780000000000000000000000000001A1B
        1C000D0D0E0C292A2D443B3C3D7E4242439B35363794191A1C742323235A8A89
        8ADD86A1BBFF5EB6EAFF50ABFEFF2B72F8EC0D3DCE6E00004408011379000000
        00000000000000000000525355003637391A5B5B5B8C827A6FDCA49377EAB39C
        79E9AD997AE88C8170E4575654DA919292F7D5D6D4FF84A5C2FF2A66D7ED0B39
        C66B0000340700146F000000000000000000000000005353540048494C0F706F
        6D9BA5957BEDD0AE79E5D8B377E2DAB67BE3DDB982E5DCBA85E8BEA784F08D8A
        85FD9C9C9DFA939496EC4853798C0000200A0006380000000000000000000000
        000000000000908E8C0073737460A1957FE9D3B47CE0D5B57BDDD5B47BDED4B3
        79DED5B277E0D9B780E3DFBE89E7BEA785F1595857DC393938656A665F17D5D9
        DC00030200000000000000000000000000000000000063676D0E8B8881B3C5AF
        84E7D6BB87DCD5BC88DCD5BC88DCD5B985DCD4B67FDDD4B277DEDAB984E3DCBC
        8AE98A8071E61516186700000003000000000000000000000000000000000000
        0000000000007C7F84299C9587D2D3BD8EDFD8C497DCD9C599DBD7C497DBD6C0
        90DBD6BD89DCD4B781DDD6B57CDFDEBF8BE6AB9A7EEE303132860000000B0000
        00000000000000000000000000000000000000000000888A8F31A19A8BD8D8C6
        9BDDDFD2B1E0DED2B0DEDBCEA8DBD9C79DDAD7C292DBD5BC89DCD5B67EDDDCBD
        88E4B19E7FED3D3E3F880000000A000000000000000000000000000000000000
        00000000000092949921A19C91CAD5C9A6E1E7E0C8E4E7E2CEE6E2DBC0E0DBCF
        ABDBD8C79DDAD6BF8EDBD5B983DDDBBB86E2A2947CEC3435376E000000030000
        00000000000000000000000000000000000000000000B8BAC305A09F9C9BC4BD
        A4E9EAE6D3E6F2F1E8EFE9E7D6E7DFD6B7DDDACBA3DAD7C191DAD6BB86DCD0B5
        85E6807A70D82122253879797900000000000000000000000000000000000000
        000000000000A7A7A700ACACAE3CAAA89FDBD6D2BCE7ECEAD9E6E8E5D1E4E1DA
        BDDFDACBA3DAD8C292DAD3BA88DFA39680EC58585882000000080B0B0B000000
        00000000000000000000000000000000000000000000C0C0C100F0F0F402ABAB
        AC62AAA9A1DEC4C0ACE8D7CFB2DFD9CEA8DBD4C399DCC6B48EE4A09683E96E6D
        6C982E2F31175858590000000000000000000000000000000000000000000000
        00000000000000000000BEBFC000CBCCCE03AAABAC439F9F9CA7A09D94D3A19D
        8FDF9B968AD98A8883BB7273746747484B107172750000000000000000000000
        000000000000000000000000000000000000000000000000000000000000CED0
        D8008A898B00A9AAAE0A95969A2B8D8E923C808286336C6E7214080B10012F31
        3700000000000000000000000000000000000000000000000000000000000000
        000000000000}
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnFiltroClick
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 56
    Width = 641
    Height = 277
    Align = alClient
    TabOrder = 1
    object dbgProdutos: TDBGrid
      Left = 1
      Top = 1
      Width = 639
      Height = 275
      Align = alClient
      DataSource = dsprodutos
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      OnDblClick = dbgProdutosDblClick
      OnTitleClick = dbgProdutosTitleClick
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_id'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pro_nome'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o Produto'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 225
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_quantidade'
          Title.Alignment = taCenter
          Title.Caption = 'Qtde. (Un)'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_peso'
          Title.Alignment = taCenter
          Title.Caption = 'Peso (g)'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 75
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_preco'
          Title.Alignment = taCenter
          Title.Caption = 'Valor (Un)'
          Title.Font.Charset = DEFAULT_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 100
          Visible = True
        end>
    end
  end
  object dsprodutos: TDataSource
    DataSet = DM.QryProdutos
    Left = 432
    Top = 280
  end
end
