unit untPagamentoVCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Samples.Spin,
  System.ImageList, Vcl.ImgList, system.UITypes, frxClass, frxDBSet,
  frxExportPDF, frxExportBaseDialog, Data.Win.ADODB;

type
  TfrmPagamentoVCaixa = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    btnImprimir: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox3: TGroupBox;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    BitBtn5: TBitBtn;
    Label1: TLabel;
    subtotal: TLabel;
    Label2: TLabel;
    desconto: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    lblfalta: TLabel;
    lblTotalPago: TLabel;
    Label5: TLabel;
    lblTroco: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    SpinEdit1: TSpinEdit;
    Label8: TLabel;
    porpessoa: TLabel;
    totalpagar: TLabel;
    btnCancelar: TBitBtn;
    BitBtn6: TBitBtn;
    dspagamento: TDataSource;
    venda: TfrxReport;
    empresa: TfrxDBDataset;
    frxvenda: TfrxDBDataset;
    pago: TfrxReport;
    frxDBDataset2: TfrxDBDataset;
    dbgItems: TDBGrid;
    DBGrid1: TDBGrid;
    frxPDFExport1: TfrxPDFExport;
    qryRelClientesxConfig: TADOQuery;
    qryRelClientesxConfigconf_id: TAutoIncField;
    qryRelClientesxConfigconf_razao_social: TStringField;
    qryRelClientesxConfigconf_nome_fantasia: TStringField;
    qryRelClientesxConfigconf_cnpj: TStringField;
    qryRelClientesxConfigconf_ie: TStringField;
    qryRelClientesxConfigconf_tel: TStringField;
    qryRelClientesxConfigconf_cel: TStringField;
    qryRelClientesxConfigconf_email: TStringField;
    qryRelClientesxConfigconf_site: TStringField;
    qryRelClientesxConfigconf_endereco: TStringField;
    qryRelClientesxConfigconf_num_end: TStringField;
    qryRelClientesxConfigconf_bairro: TStringField;
    qryRelClientesxConfigconf_CEP: TStringField;
    qryRelClientesxConfigconf_cid_id: TIntegerField;
    qryRelClientesxConfigconf_estado: TStringField;
    qryRelClientesxConfigcid_nome: TStringField;
    frxDBDatasetConfig: TfrxDBDataset;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    procedure novavenda(Sender: TObject);
    { Private declarations }
  public
    procedure atualizar(Sender: TObject);
    var total:real; total2:real;
  end;

var
  frmPagamentoVCaixa: TfrmPagamentoVCaixa;

implementation

{$R *.dfm}

uses untVendaCaixa, untPrincipal, untPagamentoDinheiro, untPagamentoDebito,
  untPagamentoCredito, untDM;

procedure TfrmPagamentoVCaixa.BitBtn1Click(Sender: TObject);
begin
DM.qryTotalPagamentos.Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
DM.qryTotalPagamentos.Open;

      if (DM.qryTotalPagamentos.fieldbyname('str').Value < total) then
      begin
        showmessage('Pagamento insuficiente!');
      end
      else if (DM.qryTotalPagamentos.fieldbyname('str').Value > frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_total').Value)  then
      begin
      DM.qryPagamentos.Edit;
      DM.qryPagamentospag_valor.AsFloat := (DM.qryPagamentospag_valor.AsFloat - (DM.qryTotalPagamentos.fieldbyname('str').AsFloat - total));
      DM.qryPagamentos.Post;

      with frmVendaCaixa.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaCaixa.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaCaixa.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaCaixa.btnOk.Enabled := false;

      novavenda(Sender);
      end
      else
      begin
      with frmVendaCaixa.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaCaixa.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaCaixa.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaCaixa.btnOk.Enabled := false;

      novavenda(Sender);
      end;
end;

procedure TfrmPagamentoVCaixa.novavenda(Sender: TObject);
begin

      frmVendaCaixa.dbeNPedido.Caption := DM.adoVendaven_id.AsString;

      frmVendaCaixa.dbTotal.Caption := 'R$ 0,00';

      with DM.qryCalculaTotal do
begin
    Parameters[0].Value := 0;
    Open;
   subtotal.Caption := FormatFloat('R$ #,0.00',DM.qryCalculaTotal.FieldByName('Total').AsFloat);
   totalpagar.Caption := FormatFloat('R$ #,0.00',(DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaCaixa.desconto));
   total := (DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaCaixa.desconto);
    Close;
end;

with DM.qryPagamentos do
begin
    Parameters[0].Value := 0;
end;

with DM.qrytotalpagamentos do
begin
    Parameters[0].Value := 0;
    Open;
    lbltotalpago.Caption := fieldbyname('str').AsString;
    lblfalta.Caption := FormatFloat('R$ #,0.00',(total - fieldbyname('str').AsFloat));
    lbltroco.Caption := FormatFloat('R$ #,0.00',(fieldbyname('str').AsFloat) - total);
    close;
end;

      porpessoa.Caption := FormatFloat('R$ #,0.00',(total/spinedit1.Value));

        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;

//      frmVendaCaixa.novavenda(sender);
     frmVendaCaixa.close;
     frmVendaCaixa.dsvenda.dataset.close;
     frmVendaCaixa.dsvendaitem.dataset.close;
     frmVendaCaixa.dsprodutos.DataSet.close;
     frmVendaCaixa.dscaixa.DataSet.close;
     close;
end;

procedure TfrmPagamentoVCaixa.SpinEdit1Change(Sender: TObject);
begin
      porpessoa.Caption := FormatFloat('R$ #,0.00',(total/spinedit1.Value));
end;

procedure TfrmPagamentoVCaixa.BitBtn2Click(Sender: TObject);
begin
        frmVendaCaixa.dsvenda.DataSet.Edit;
        frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_forma_pagamento').Value := 'DINHEIRO';
        frmVendaCaixa.dsvenda.DataSet.post;
      Application.CreateForm(TfrmPagamentoDinheiro, frmPagamentoDinheiro);
      frmPagamentoDinheiro.ShowModal;
      frmPagamentoDinheiro.Free;
end;

procedure TfrmPagamentoVCaixa.BitBtn3Click(Sender: TObject);
begin
        frmVendaCaixa.dsvenda.DataSet.Edit;
        frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_forma_pagamento').Value := 'DEBITO';
        frmVendaCaixa.dsvenda.DataSet.post;
      Application.CreateForm(TfrmPagamentoDebito, frmPagamentoDebito);
      frmPagamentoDebito.ShowModal;
      frmPagamentoDebito.Free;
end;

procedure TfrmPagamentoVCaixa.BitBtn4Click(Sender: TObject);
begin
        frmVendaCaixa.dsvenda.DataSet.Edit;
        frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_forma_pagamento').Value := 'CREDITO';
        frmVendaCaixa.dsvenda.DataSet.post;
      Application.CreateForm(TfrmPagamentoCredito, frmPagamentoCredito);
      frmPagamentoCredito.ShowModal;
      frmPagamentoCredito.Free;
end;

procedure TfrmPagamentoVCaixa.BitBtn5Click(Sender: TObject);
begin
venda.ShowReport;
end;

procedure TfrmPagamentoVCaixa.BitBtn6Click(Sender: TObject);
begin
If MessageBox(Handle,'Deseja apagar o pagamento Selecionado?', 'Favor confirmar...', MB_YESNO+MB_SYSTEMMODAL+MB_ICONQUESTION+MB_DEFBUTTON1 ) = ID_Yes then
begin
if dspagamento.dataset.IsEmpty then
begin
showmessage('Não há nenhum pagamento');
end
else
dspagamento.DataSet.Delete;
        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;
        atualizar(sender);
end;
end;

procedure TfrmPagamentoVCaixa.btnCancelarClick(Sender: TObject);
var vlLinha: Integer;
begin
      if dspagamento.dataset.IsEmpty then
      begin
            atualizar(sender);
      end
      else
      begin
      with DBGrid1.DataSource.DataSet do
      begin
      First;
      for vlLinha := 0 to RecordCount - 1 do
      begin
      DBGrid1.SelectedRows.CurrentRowSelected := True;
      Next;
      end;
      end;
      DBGrid1.SelectedRows.Delete;
      atualizar(sender);
      end;
        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;
      close;
end;

procedure TfrmPagamentoVCaixa.btnImprimirClick(Sender: TObject);
begin
DM.qryTotalPagamentos.Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
DM.qryTotalPagamentos.Open;

      if (DM.qryTotalPagamentos.fieldbyname('str').Value < total) then
      begin
        showmessage('Pagamento insuficiente!');
      end
      else if (DM.qryTotalPagamentos.fieldbyname('str').Value > frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_total').Value)  then
      begin
      DM.qryPagamentos.Edit;
      DM.qryPagamentospag_valor.AsFloat := (DM.qryPagamentospag_valor.AsFloat - (DM.qryTotalPagamentos.fieldbyname('str').AsFloat - total));
      DM.qryPagamentos.Post;

      with frmVendaCaixa.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaCaixa.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaCaixa.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaCaixa.btnOk.Enabled := false;

      novavenda(Sender);
      end
      else
      begin
      with frmVendaCaixa.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaCaixa.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaCaixa.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaCaixa.btnOk.Enabled := false;

      novavenda(Sender);
      end;
pago.ShowReport;
end;

procedure TfrmPagamentoVCaixa.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;

dspagamento.DataSet.Close;
end;

procedure TfrmPagamentoVCaixa.FormShow(Sender: TObject);
begin

Desconto.caption := FloatToStr(frmVendaCaixa.desconto);

        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;

with DM.qryCalculaTotal do
begin
    Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
   subtotal.Caption := FormatFloat('R$ #,0.00',DM.qryCalculaTotal.FieldByName('Total').AsFloat);
   totalpagar.Caption := FormatFloat('R$ #,0.00',(DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaCaixa.desconto));
   total := (DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaCaixa.desconto);
    Close;
end;

with DM.qrypagamentos do
begin
    Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
end;

dspagamento.DataSet.Open;

with DM.qrytotalpagamentos do
begin
    Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
    lbltotalpago.Caption := fieldbyname('str').AsString;
    lblfalta.Caption := FormatFloat('R$ #,0.00',(total - fieldbyname('str').AsFloat));
    lbltroco.Caption := FormatFloat('R$ #,0.00',(fieldbyname('str').AsFloat) - total);
    close;
end;

      porpessoa.Caption := FormatFloat('R$ #,0.00',(total/spinedit1.Value));
end;

procedure TfrmPagamentoVCaixa.atualizar(Sender: TObject);
begin

with DM.qryCalculaTotal do
begin
    Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
   subtotal.Caption := FormatFloat('R$ #,0.00',DM.qryCalculaTotal.FieldByName('Total').AsFloat);
   totalpagar.Caption := FormatFloat('R$ #,0.00',(DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaCaixa.desconto));
   total := (DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaCaixa.desconto);
    Close;
end;

with DM.qrypagamentos do
begin
    Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
end;


with DM.qrytotalpagamentos do
begin
    Parameters[0].Value := frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
    lbltotalpago.Caption := FormatFloat('R$ #,0.00',(fieldbyname('str').AsFloat));
    total2 := (fieldbyname('str').AsFloat);
    lblfalta.Caption := FormatFloat('R$ #,0.00',(total - fieldbyname('str').AsFloat));
    lbltroco.Caption := FormatFloat('R$ #,0.00',(fieldbyname('str').AsFloat) - total);
    porpessoa.Caption := FormatFloat('R$ #,0.00',(total/spinedit1.Value));
    close;
end;
      if total2 >= total  then
      begin
        bitbtn2.Enabled := false;
        bitbtn3.Enabled := false;
        bitbtn4.Enabled := false;
        bitbtn1.Enabled := true;
        btnImprimir.Enabled := true;
      end;
end;

end.
