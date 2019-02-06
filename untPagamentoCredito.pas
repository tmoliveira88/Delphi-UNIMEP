unit untPagamentoCredito;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Mask,
  Vcl.DBCtrls, Vcl.Buttons, Vcl.Imaging.pngimage, Data.DB;

type
  TfrmPagamentoCredito = class(TForm)
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
    GroupBox2: TGroupBox;
    Image1: TImage;
    CheckBox1: TCheckBox;
    Image2: TImage;
    CheckBox2: TCheckBox;
    Image3: TImage;
    CheckBox3: TCheckBox;
    Image4: TImage;
    CheckBox4: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure CheckBox3Click(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Image4Click(Sender: TObject);
    procedure edtvalorKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmPagamentoCredito: TfrmPagamentoCredito;

implementation

{$R *.dfm}

uses untPagamentoVCaixa, untDM, untVendaCaixa;

procedure TfrmPagamentoCredito.BitBtn1Click(Sender: TObject);
var val1:currency; val2:currency;
begin

     val1 := strtofloat(edtvalor.Text);
     val2 := (frmPagamentoVCaixa.total - DM.qryTotalPagamentos.fieldbyname('str').AsFloat);

    if (edtvalor.Text = '0,00') or (edtvalor.Text = '') then
    begin
        showmessage('Digite um valor ou clique em cancelar');
    end
    else if (checkbox1.Checked = false) and  (checkbox2.Checked = false) and  (checkbox3.Checked = false) and  (checkbox4.Checked = false) then
    begin
        showmessage('Selecione uma bandeira de cartão');
    end
    else if (val1 > val2) then
    begin
        showmessage('Operação inválida. Pagamento superior ao da compra: revise as informações');
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
        if (checkbox1.Checked = true) then
        begin
          DM.qrypagamentospag_forma_pagamento.AsString := 'CREDITO';
          DM.qrypagamentospag_card.asstring := 'VISA';
        end
        else if (checkbox2.Checked = true) then
        begin
          DM.qrypagamentospag_forma_pagamento.AsString := 'CREDITO';
          DM.qrypagamentospag_card.asstring := 'ELO';
        end
        else if (checkbox3.Checked = true) then
        begin
          DM.qrypagamentospag_forma_pagamento.AsString := 'CREDITO';
          DM.qrypagamentospag_card.asstring := 'MASTERCARD';
        end
        else if (checkbox4.Checked = true) then
        begin
          DM.qrypagamentospag_forma_pagamento.AsString := 'CREDITO';
          DM.qrypagamentospag_card.asstring := 'OUTROS';
        end;
        DM.qrypagamentos.Post;

        DM.qrypagamentos.Refresh;

       frmPagamentoVCaixa.atualizar(Sender);
       close;
    end;
end;

procedure TfrmPagamentoCredito.btnCancelarClick(Sender: TObject);
begin
close;
end;

procedure TfrmPagamentoCredito.Button1Click(Sender: TObject);
begin
edtvalor.Text := FormatFloat('#0.00',(frmPagamentoVCaixa.total - DM.qryTotalPagamentos.fieldbyname('str').AsFloat));
end;

procedure TfrmPagamentoCredito.Button2Click(Sender: TObject);
begin
edtvalor.Text := '0,00';
end;

procedure TfrmPagamentoCredito.Button3Click(Sender: TObject);
begin
edtvalor.Text := '5,00';
end;

procedure TfrmPagamentoCredito.Button4Click(Sender: TObject);
begin
edtvalor.Text := '10,00';
end;

procedure TfrmPagamentoCredito.Button5Click(Sender: TObject);
begin
edtvalor.Text := '20,00';
end;

procedure TfrmPagamentoCredito.Button6Click(Sender: TObject);
begin
edtvalor.Text := '50,00';
end;

procedure TfrmPagamentoCredito.Button7Click(Sender: TObject);
begin
edtvalor.Text := '2,00';
end;

procedure TfrmPagamentoCredito.CheckBox1Click(Sender: TObject);
begin
if Checkbox1.checked = true then
begin
 Checkbox2.checked := false;
 Checkbox3.checked := false;
 Checkbox4.checked := false;
end;
end;

procedure TfrmPagamentoCredito.CheckBox2Click(Sender: TObject);
begin
if Checkbox2.checked = true then
begin
 Checkbox1.checked := false;
 Checkbox3.checked := false;
 Checkbox4.checked := false;
end;
end;

procedure TfrmPagamentoCredito.CheckBox3Click(Sender: TObject);
begin
if Checkbox3.checked = true then
begin
 Checkbox2.checked := false;
 Checkbox1.checked := false;
 Checkbox4.checked := false;
end;
 end;

procedure TfrmPagamentoCredito.CheckBox4Click(Sender: TObject);
begin
if Checkbox4.checked = true then
begin
 Checkbox2.checked := false;
 Checkbox3.checked := false;
 Checkbox1.checked := false;
end;
end;

procedure TfrmPagamentoCredito.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['a'..'z', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoCredito.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['0'..'9', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoCredito.edtvalorKeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['0'..'9', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmPagamentoCredito.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
       frmPagamentoVCaixa.atualizar(Sender);
 Checkbox1.checked := false;
 Checkbox2.checked := false;
 Checkbox3.checked := false;
 Checkbox4.checked := false;

 Button1.Caption := '';
 edit1.Clear;
 edit2.Clear;
 edtvalor.Text := '0,00';
end;

procedure TfrmPagamentoCredito.FormShow(Sender: TObject);
begin
DM.qryTotalPagamentos.open;
Button1.Caption := FormatFloat('#0.00 (Faltando)',(frmPagamentoVCaixa.total - DM.qryTotalPagamentos.fieldbyname('str').AsFloat));
end;

procedure TfrmPagamentoCredito.Image1Click(Sender: TObject);
begin
Checkbox1.checked := true;
if Checkbox1.checked = true then
begin
 Checkbox2.checked := false;
 Checkbox3.checked := false;
 Checkbox4.checked := false;
end;
end;

procedure TfrmPagamentoCredito.Image2Click(Sender: TObject);
begin
Checkbox2.checked := true;
if Checkbox2.checked = true then
begin
 Checkbox1.checked := false;
 Checkbox3.checked := false;
 Checkbox4.checked := false;
end;
end;

procedure TfrmPagamentoCredito.Image3Click(Sender: TObject);
begin
Checkbox3.checked := true;
if Checkbox3.checked = true then
begin
 Checkbox2.checked := false;
 Checkbox1.checked := false;
 Checkbox4.checked := false;
end;
end;

procedure TfrmPagamentoCredito.Image4Click(Sender: TObject);
begin
Checkbox4.checked := true;
if Checkbox4.checked = true then
begin
 Checkbox2.checked := false;
 Checkbox3.checked := false;
 Checkbox1.checked := false;
end;
end;

end.
