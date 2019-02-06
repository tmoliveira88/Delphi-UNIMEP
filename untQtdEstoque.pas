unit untQtdEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls;

type
  TfrmQtdEstoque = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtValor: TEdit;
    btnCancelar: TBitBtn;
    btnDepositar: TBitBtn;
    procedure btnDepositarClick(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmQtdEstoque: TfrmQtdEstoque;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmQtdEstoque.btnCancelarClick(Sender: TObject);
begin
close;
end;

procedure TfrmQtdEstoque.btnDepositarClick(Sender: TObject);
var qtd:real;
begin
      qtd := strtofloat(edtValor.Text);

      if DM.QryProdutospro_peso.AsString <> '' then
      begin
      DM.QryProdutos.Edit;
      DM.QryProdutos.FieldByName('pro_peso').AsFloat := DM.QryProdutos.FieldByName('pro_peso').AsFloat + qtd;
      DM.QryProdutos.Post;
      end
      else
      begin
      DM.QryProdutos.Edit;
      DM.QryProdutos.FieldByName('pro_quantidade').AsFloat := DM.QryProdutos.FieldByName('pro_quantidade').AsFloat + qtd;
      DM.QryProdutos.Post;
      end;

self.Close;
edtvalor.Clear;
end;

procedure TfrmQtdEstoque.edtValorKeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['0'..'9', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmQtdEstoque.FormShow(Sender: TObject);
begin
      edtvalor.SetFocus;

      if DM.QryProdutospro_peso.AsString <> '' then
      begin
      Label1.Caption := 'Quantos g. deseja adicionar';
      end
      else
      begin
      Label1.Caption := 'Quantas un. deseja adicionar';
      end;
end;

end.
