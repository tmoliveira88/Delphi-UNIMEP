unit untPagamentoCDinheiro;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Data.DB;

type
  TfrmPagamentoCDinheiro = class(TForm)
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
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure edtvalorKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
      private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPagamentoCDinheiro: TfrmPagamentoCDinheiro;

implementation

{$R *.dfm}

uses untDM, untVendaComanda, untPagamentoVComanda;

procedure TfrmPagamentoCDinheiro.BitBtn1Click(Sender: TObject);
begin
    if (edtvalor.Text = '0,00') or (edtvalor.Text = '') then
    begin
        showmessage('Digite um valor ou clique em cancelar');
    end
    else
    begin
        DM.qrypagamentos.Open;
        DM.qrypagamentos.Append;
        DM.qrypagamentospag_idcaixa.Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_caixaid').Value;
        DM.qrypagamentospag_id_venda.Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
        DM.qrypagamentospag_cliente.value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_cliente').Value;
        DM.qrypagamentospag_valor.AsString := edtvalor.Text;
        DM.qrypagamentospag_observacao.AsString := edit1.Text;
        DM.qrypagamentospag_n_autorizacao.AsString := '';
        DM.qrypagamentospag_forma_pagamento.AsString := 'DINHEIRO';
        DM.qrypagamentos.Post;

        DM.qrypagamentos.Refresh;
        DM.qrytotalpagamentos.Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;

       frmPagamentoVComanda.atualizar(Sender);
           close;
    end;
end;

procedure TfrmPagamentoCDinheiro.btnCancelarClick(Sender: TObject);
begin
close;
end;

procedure TfrmPagamentoCDinheiro.Button1Click(Sender: TObject);
begin
edtvalor.Text := FormatFloat('#0.00',(frmPagamentoVComanda.total - DM.qrytotalpagamentos.fieldbyname('str').AsFloat));
end;

procedure TfrmPagamentoCDinheiro.Button2Click(Sender: TObject);
begin
edtvalor.Text := '0,00';
end;

procedure TfrmPagamentoCDinheiro.Button3Click(Sender: TObject);
begin
edtvalor.Text := '5,00';
end;

procedure TfrmPagamentoCDinheiro.Button4Click(Sender: TObject);
begin
edtvalor.Text := '10,00';
end;

procedure TfrmPagamentoCDinheiro.Button5Click(Sender: TObject);
begin
edtvalor.Text := '20,00';
end;

procedure TfrmPagamentoCDinheiro.Button6Click(Sender: TObject);
begin
edtvalor.Text := '50,00';
end;

procedure TfrmPagamentoCDinheiro.Button7Click(Sender: TObject);
begin
edtvalor.Text := '2,00';
end;

procedure TfrmPagamentoCDinheiro.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['a'..'z', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoCDinheiro.edtvalorKeyPress(Sender: TObject;
  var Key: Char);
begin
     if not (CharInSet(key,['0'..'9', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoCDinheiro.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 frmPagamentoVComanda.atualizar(Sender);
 Button1.Caption := '';
 edit1.Clear;
 edtvalor.Text := '0,00';
end;

procedure TfrmPagamentoCDinheiro.FormShow(Sender: TObject);
begin
DM.qrytotalpagamentos.Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
DM.qrytotalpagamentos.open;
Button1.Caption := FormatFloat('#0.00 (Faltando)',(frmPagamentoVComanda.total - DM.qrytotalpagamentos.fieldbyname('str').AsFloat));
end;

end.
