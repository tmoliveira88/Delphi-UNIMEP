object frmAlimentarEstoque: TfrmAlimentarEstoque
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '.:: Alimentar Estoque ::.'
  ClientHeight = 536
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object gbFiltro: TGroupBox
    Left = 0
    Top = 82
    Width = 834
    Height = 54
    Align = alTop
    TabOrder = 0
    object lbFiltro: TLabel
      Left = 195
      Top = 19
      Width = 39
      Height = 15
      Hint = 
        'Para efetuar a pesquisa por outro campo, clique no t'#237'tulo do cam' +
        'po correspondente.'
      Alignment = taRightJustify
      Caption = 'lbFiltro'
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
      Left = 240
      Top = 16
      Width = 250
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
  end
  object gbDados: TGroupBox
    Left = 0
    Top = 136
    Width = 834
    Height = 400
    Align = alClient
    TabOrder = 1
    object imProduto: TImage
      AlignWithMargins = True
      Left = 12
      Top = 15
      Width = 245
      Height = 383
      Margins.Left = 10
      Margins.Top = 0
      Margins.Right = 10
      Margins.Bottom = 0
      Align = alLeft
      Center = True
      ParentShowHint = False
      Proportional = True
      ShowHint = True
      Stretch = True
      ExplicitLeft = 10
      ExplicitHeight = 376
    end
    object DBGrid1: TDBGrid
      Left = 267
      Top = 15
      Width = 565
      Height = 383
      Align = alClient
      DataSource = ds
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
      OnDblClick = DBGrid1DblClick
      OnTitleClick = DBGrid1TitleClick
      Columns = <
        item
          Alignment = taLeftJustify
          Expanded = False
          FieldName = 'pro_id'
          Title.Alignment = taCenter
          Title.Caption = 'C'#243'digo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 90
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'pro_nome'
          Title.Alignment = taCenter
          Title.Caption = 'Descri'#231#227'o'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 200
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_quantidade'
          Title.Alignment = taCenter
          Title.Caption = 'Qtde.'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_peso'
          Title.Alignment = taCenter
          Title.Caption = 'Peso'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'pro_qtd_alerta'
          Title.Alignment = taCenter
          Title.Caption = 'Est.M'#237'nimo'
          Title.Font.Charset = ANSI_CHARSET
          Title.Font.Color = clWindowText
          Title.Font.Height = -13
          Title.Font.Name = 'Calibri'
          Title.Font.Style = [fsBold]
          Width = 70
          Visible = True
        end>
    end
  end
  object pnTopo: TPanel
    Left = 0
    Top = 0
    Width = 834
    Height = 82
    Align = alTop
    TabOrder = 2
    object Label2: TLabel
      Left = 159
      Top = 0
      Width = 489
      Height = 78
      Alignment = taCenter
      Caption = 'Alimentar Estoque'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -64
      Font.Name = 'Calibri'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ds: TDataSource
    DataSet = DM.QryProdutos
    OnDataChange = dsDataChange
    Left = 42
    Top = 456
  end
end
