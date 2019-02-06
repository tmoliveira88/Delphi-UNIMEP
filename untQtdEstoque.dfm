object frmQtdEstoque: TfrmQtdEstoque
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Adicionar'
  ClientHeight = 108
  ClientWidth = 430
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 56
    Width = 430
    Height = 52
    Align = alBottom
    TabOrder = 0
    object btnCancelar: TBitBtn
      Left = 224
      Top = 6
      Width = 106
      Height = 36
      Caption = 'Cancelar'
      TabOrder = 0
      OnClick = btnCancelarClick
    end
    object btnDepositar: TBitBtn
      Left = 112
      Top = 6
      Width = 106
      Height = 36
      Caption = 'Confirmar'
      Default = True
      TabOrder = 1
      OnClick = btnDepositarClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 56
    Align = alClient
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 16
      Width = 214
      Height = 19
      Alignment = taRightJustify
      Caption = 'Quanto voc'#234' deseja adicionar:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtValor: TEdit
      Left = 244
      Top = 10
      Width = 153
      Height = 31
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnKeyPress = edtValorKeyPress
    end
  end
end
