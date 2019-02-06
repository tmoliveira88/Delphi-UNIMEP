object frmComandas: TfrmComandas
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '.:: Mesas e Comandas ::.'
  ClientHeight = 381
  ClientWidth = 726
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 726
    Height = 65
    Align = alTop
    TabOrder = 0
    object lbFiltro: TLabel
      Left = 260
      Top = 25
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
    object Button1: TButton
      AlignWithMargins = True
      Left = 615
      Top = 4
      Width = 107
      Height = 57
      Align = alRight
      Caption = 'SAIR'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Calibri'
      Font.Style = []
      ImageIndex = 12
      Images = frmPrincipal.ilPrincipal48
      ParentFont = False
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      AlignWithMargins = True
      Left = 4
      Top = 4
      Width = 162
      Height = 57
      Align = alLeft
      Caption = 'NOVA COMANDA'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Calibri'
      Font.Style = []
      ImageIndex = 171
      Images = frmPrincipal.ilPrincipal48
      ParentFont = False
      TabOrder = 1
      OnClick = Button2Click
    end
    object edtFiltro: TEdit
      Left = 305
      Top = 22
      Width = 176
      Height = 23
      Hint = 
        'Para efetuar a pesquisa por outro campo, clique no t'#237'tulo do cam' +
        'po correspondente.'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Calibri'
      Font.Style = []
      ParentFont = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnChange = edtFiltroChange
    end
  end
  object DBGrid1: TDBGrid
    AlignWithMargins = True
    Left = 3
    Top = 68
    Width = 696
    Height = 310
    Align = alClient
    DataSource = dsVenda
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = []
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ParentFont = False
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ven_id'
        Title.Alignment = taCenter
        Title.Caption = 'N'#186' Comanda'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 140
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ven_hora'
        Title.Alignment = taCenter
        Title.Caption = 'Hora de Abertura'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 150
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ven_data'
        Title.Alignment = taCenter
        Title.Caption = 'Data de Abertura'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 160
        Visible = True
      end
      item
        Alignment = taCenter
        Expanded = False
        FieldName = 'ven_status'
        Title.Alignment = taCenter
        Title.Caption = 'Status'
        Title.Font.Charset = DEFAULT_CHARSET
        Title.Font.Color = clWindowText
        Title.Font.Height = -13
        Title.Font.Name = 'Calibri'
        Title.Font.Style = [fsBold]
        Width = 180
        Visible = True
      end>
  end
  object Button4: TButton
    Left = 702
    Top = 65
    Width = 24
    Height = 316
    Align = alRight
    ImageIndex = 12
    Images = frmPrincipal.ilPrincipal20
    TabOrder = 2
    OnClick = Button4Click
  end
  object dsVenda: TDataSource
    DataSet = DM.qryVendaComanda
    Left = 466
    Top = 200
  end
end
