object frmBackup: TfrmBackup
  Left = 335
  Top = 372
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = '.:: Backup ::.'
  ClientHeight = 259
  ClientWidth = 500
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblMensagem: TLabel
    Left = 240
    Top = 100
    Width = 233
    Height = 26
    Alignment = taCenter
    AutoSize = False
    Font.Charset = ANSI_CHARSET
    Font.Color = clBackground
    Font.Height = -16
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Button1: TButton
    Left = 8
    Top = 48
    Width = 201
    Height = 63
    Caption = 'Realizar Backup'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ImageIndex = 118
    Images = frmPrincipal.ilPrincipal48
    ParentFont = False
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 656
    Top = 196
    Width = 201
    Height = 63
    Caption = 'Restaurar Backup'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ImageIndex = 104
    Images = frmPrincipal.ilPrincipal48
    ParentFont = False
    TabOrder = 1
    Visible = False
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 152
    Width = 201
    Height = 63
    Caption = 'Fechar'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ImageIndex = 12
    Images = frmPrincipal.ilPrincipal48
    ParentFont = False
    TabOrder = 2
    OnClick = Button3Click
  end
  object ProgressBar1: TProgressBar
    Left = 288
    Top = 132
    Width = 150
    Height = 17
    TabOrder = 3
  end
  object ADOCommand: TADOCommand
    Connection = DM.adoConexao
    Parameters = <>
    Left = 256
    Top = 32
  end
  object restore: TOpenDialog
    Left = 328
    Top = 184
  end
end
