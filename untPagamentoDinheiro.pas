unit untPagamentoDinheiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Data.DB;

type
  TfrmPagamentoDinheiro = class(TForm)
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    edtvalor: TEdit;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnCancelar: TBitBtn;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure edtvalorKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPagamentoDinheiro: TfrmPagamentoDinheiro;

implementation

{$R *.dfm}

uses untPagamentoVCaixa, untDM, untVendaCaixa;

procedure TfrmPagamentoDinheiro.BitBtn1Click(Sender: TObject);
begin
    if (edtvalor.Text = '0,00') or (edtvalor.Text = '') then
    begin
        showmessage('Digite um valor ou clique em cancelar');
    end
    else
    begin
        DM.qrypagamentos.Open;
        DM.qrypagamentos.Append;
        DM.qrypagamentospag_idcaixa.Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_caixaid').Value;
        DM.qrypagamentospag_id_venda.Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
        DM.qrypagamentospag_cliente.value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_cliente').Value;
        DM.qrypagamentospag_valor.AsString := edtvalor.Text;
        DM.qrypagamentospag_observacao.AsString := edit1.Text;
        DM.qrypagamentospag_n_autorizacao.AsString := '';
        DM.qrypagamentospag_forma_pagamento.AsString := 'DINHEIRO';
        DM.qrypagamentos.Post;

        DM.qrypagamentos.Refresh;
        DM.qrytotalpagamentos.Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;

       frmPagamentoVCaixa.atualizar(Sender);
           close;
    end;
end;

procedure TfrmPagamentoDinheiro.btnCancelarClick(Sender: TObject);
begin
close;
end;

procedure TfrmPagamentoDinheiro.Button1Click(Sender: TObject);
begin
edtvalor.Text := FormatFloat('#0.00',(frmPagamentoVCaixa.total - DM.qrytotalpagamentos.fieldbyname('str').AsFloat));
end;

procedure TfrmPagamentoDinheiro.Button2Click(Sender: TObject);
begin
edtvalor.Text := '0,00';
end;

procedure TfrmPagamentoDinheiro.Button3Click(Sender: TObject);
begin
edtvalor.Text := '5,00';
end;

procedure TfrmPagamentoDinheiro.Button4Click(Sender: TObject);
begin
edtvalor.Text := '10,00';
end;

procedure TfrmPagamentoDinheiro.Button5Click(Sender: TObject);
begin
edtvalor.Text := '20,00';
end;

procedure TfrmPagamentoDinheiro.Button6Click(Sender: TObject);
begin
edtvalor.Text := '50,00';
end;

procedure TfrmPagamentoDinheiro.Button7Click(Sender: TObject);
begin
edtvalor.Text := '2,00';
end;

procedure TfrmPagamentoDinheiro.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['a'..'z', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoDinheiro.edtvalorKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not (CharInSet(key,['0'..'9', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoDinheiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
       frmPagamentoVCaixa.atualizar(Sender);
 Button1.Caption := '';
 edit1.Clear;
 edtvalor.Text := '0,00';
end;

procedure TfrmPagamentoDinheiro.FormShow(Sender: TObject);
begin
DM.qrytotalpagamentos.open;
Button1.Caption := FormatFloat('#0.00 (Faltando)',(frmPagamentoVCaixa.total - DM.qrytotalpagamentos.fieldbyname('str').AsFloat));
end;

end.
