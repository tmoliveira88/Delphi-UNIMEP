unit untPagamentoVComanda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Samples.Spin,
  System.ImageList, Vcl.ImgList, system.UITypes, frxClass, frxDBSet,
  frxExportPDF, frxExportBaseDialog, Data.Win.ADODB;

type
  TfrmPagamentoVComanda = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    dbgItems: TDBGrid;
    btnImprimir: TBitBtn;
    BitBtn1: TBitBtn;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
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
    frxPDFExport1: TfrxPDFExport;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    dspagamento: TDataSource;
    venda: TfrxReport;
    pago: TfrxReport;
    frxvenda: TfrxDBDataset;
    frxDBDataset2: TfrxDBDataset;
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
    procedure BitBtn6Click(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
      procedure atualizar(Sender: TObject);
    var total, totalpag, fiado:real; total2:real;
  end;

var
  frmPagamentoVComanda: TfrmPagamentoVComanda;

implementation

{$R *.dfm}

uses untPagamentoCDinheiro, untPagamentoDebito, untPagamentoCDebito,
  untPagamentoCCredito, untVendaComanda, untDM, untComandas;


procedure TfrmPagamentoVComanda.BitBtn1Click(Sender: TObject);
begin
DM.qryTotalPagamentos.Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
DM.qryTotalPagamentos.Open;

      if (DM.qryTotalPagamentos.fieldbyname('str').Value < total) then
      begin
        showmessage('Pagamento insuficiente!');
      end
      else if (DM.qryTotalPagamentos.fieldbyname('str').Value > frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_total').Value)  then
      begin
      showmessage(floattostr(DM.qryTotalPagamentos.fieldbyname('str').asfloat)+' '+floattostr(frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_total').asfloat));
      DM.qryPagamentos.Edit;
      DM.qryPagamentospag_valor.AsFloat := (DM.qryPagamentospag_valor.AsFloat - (DM.qryTotalPagamentos.fieldbyname('str').AsFloat - total));
      DM.qryPagamentos.Post;

      with frmVendaComanda.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaComanda.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaComanda.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaComanda.btnOk.Enabled := false;

      end
      else
      begin
      with frmVendaComanda.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaComanda.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaComanda.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaComanda.btnOk.Enabled := false;

      end;

      frmComandas.dsVenda.DataSet.Close;
      frmComandas.dsVenda.DataSet.Open;

      close;
      frmVendaComanda.Close;
      dspagamento.DataSet.Close;
end;

procedure TfrmPagamentoVComanda.BitBtn2Click(Sender: TObject);
begin
        frmVendaComanda.dsvenda.DataSet.Edit;
        frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_forma_pagamento').Value := 'DINHEIRO';
        DM.qryCalculaTotal.Parameters[0].Value := frmVendaComanda.dsvenda.DataSet.FieldByName('ven_id').Value;
        DM.qryCalculaTotal.Open;
        frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_total').AsFloat := DM.qryCalculaTotal.FieldByName('Total').AsFloat;
        DM.qryCalculaTotal.Close;
        frmVendaComanda.dsvenda.DataSet.post;
      Application.CreateForm(TfrmPagamentoCDinheiro, frmPagamentoCDinheiro);
      frmPagamentoCDinheiro.ShowModal;
      frmPagamentoCDinheiro.Free;
end;

procedure TfrmPagamentoVComanda.BitBtn3Click(Sender: TObject);
begin
        frmVendaComanda.dsvenda.DataSet.Edit;
        frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_forma_pagamento').Value := 'DEBITO';
        DM.qryCalculaTotal.Parameters[0].Value := frmVendaComanda.dsvenda.DataSet.FieldByName('ven_id').Value;
        DM.qryCalculaTotal.Open;
        frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_total').AsFloat := DM.qryCalculaTotal.FieldByName('Total').AsFloat;
        DM.qryCalculaTotal.Close;
        frmVendaComanda.dsvenda.DataSet.post;
      Application.CreateForm(TfrmPagamentoCDebito, frmPagamentoCDebito);
      frmPagamentoCDebito.ShowModal;
      frmPagamentoCDebito.Free;
end;

procedure TfrmPagamentoVComanda.BitBtn4Click(Sender: TObject);
begin
        frmVendaComanda.dsvenda.DataSet.Edit;
        frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_forma_pagamento').Value := 'CREDITO';
        DM.qryCalculaTotal.Parameters[0].Value := frmVendaComanda.dsvenda.DataSet.FieldByName('ven_id').Value;
        DM.qryCalculaTotal.Open;
        frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_total').AsFloat := DM.qryCalculaTotal.FieldByName('Total').AsFloat;
        DM.qryCalculaTotal.Close;
        frmVendaComanda.dsvenda.DataSet.post;
      Application.CreateForm(TfrmPagamentoCCredito, frmPagamentoCCredito);
      frmPagamentoCCredito.ShowModal;
      frmPagamentoCCredito.Free;
end;

procedure TfrmPagamentoVComanda.BitBtn5Click(Sender: TObject);
begin
venda.ShowReport;
end;

procedure TfrmPagamentoVComanda.BitBtn6Click(Sender: TObject);
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

procedure TfrmPagamentoVComanda.btnCancelarClick(Sender: TObject);
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

procedure TfrmPagamentoVComanda.btnImprimirClick(Sender: TObject);
begin
DM.qryTotalPagamentos.Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
DM.qryTotalPagamentos.Open;

      if (DM.qryTotalPagamentos.fieldbyname('str').Value < total) then
      begin
        showmessage('Pagamento insuficiente!');
      end
      else if (DM.qryTotalPagamentos.fieldbyname('str').Value > frmVendaComanda.dsvenda.DataSet.fieldbyname('ven_total').Value)  then
      begin
      DM.qryPagamentos.Edit;
      DM.qryPagamentospag_valor.AsFloat := (DM.qryPagamentospag_valor.AsFloat - (DM.qryTotalPagamentos.fieldbyname('str').AsFloat - total));
      DM.qryPagamentos.Post;

      with frmVendaComanda.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaComanda.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaComanda.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaComanda.btnOk.Enabled := false;

      end
      else
      begin
      with frmVendaComanda.dsvenda.DataSet do
      begin
        edit;
        fieldbyname('ven_status').Value := 'PAGO';
        fieldbyname('ven_pago').AsFloat := (fieldbyname('ven_total').AsFloat - frmVendaComanda.desconto);
        post;
        end;

      with DM.qryTotalCaixa do
      begin
      Parameters[0].Value := frmVendaComanda.dsvenda.dataset.fieldbyname('ven_caixaid').Value;
      Open;
      dm.adoCaixa.Active;
      dm.adoCaixa.Edit;
      dm.adoCaixacai_saldo_total.Value := FieldByName('SOMA').Value;
      dm.adoCaixa.Post;
      close;
      end;

      DM.qryPagamentos.Refresh;

      frmVendaComanda.btnOk.Enabled := false;

      end;

      frmComandas.dsVenda.DataSet.Close;
      frmComandas.dsVenda.DataSet.Open;
      close;
      frmVendaComanda.Close;
      pago.ShowReport;
end;

procedure TfrmPagamentoVComanda.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;

DM.qryCalculaTotal.Close;
DM.qrypagamentos.Close;
DM.qrytotalpagamentos.Close;

dspagamento.DataSet.Close;
end;

procedure TfrmPagamentoVComanda.FormShow(Sender: TObject);
begin

Desconto.caption := FloatToStr(frmVendaComanda.desconto);

        bitbtn2.Enabled := true;
        bitbtn3.Enabled := true;
        bitbtn4.Enabled := true;
        bitbtn1.Enabled := false;
        btnImprimir.Enabled := false;

with DM.qryCalculaTotal do
begin
    Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
   subtotal.Caption := FormatFloat('R$ #,0.00',DM.qryCalculaTotal.FieldByName('Total').AsFloat);
   totalpagar.Caption := FormatFloat('R$ #,0.00',(DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaComanda.desconto));
   total := (DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaComanda.desconto);
    Close;
end;

with DM.qrypagamentos do
begin
    Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
end;
dspagamento.DataSet.Open;
with DM.qrytotalpagamentos do
begin
    Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
    lbltotalpago.Caption := fieldbyname('str').AsString;
    lblfalta.Caption := FormatFloat('R$ #,0.00',(total - fieldbyname('str').AsFloat));
    lbltroco.Caption := FormatFloat('R$ #,0.00',(fieldbyname('str').AsFloat) - total);
    close;
end;

      porpessoa.Caption := FormatFloat('R$ #,0.00',(total/spinedit1.Value));
end;

procedure TfrmPagamentoVComanda.atualizar(Sender: TObject);
begin

with DM.qryCalculaTotal do
begin
    Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
   subtotal.Caption := FormatFloat('R$ #,0.00',DM.qryCalculaTotal.FieldByName('Total').AsFloat);
   totalpagar.Caption := FormatFloat('R$ #,0.00',(DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaComanda.desconto));
   total := (DM.qryCalculaTotal.FieldByName('Total').AsFloat - frmVendaComanda.desconto);
    Close;
end;

with DM.qrypagamentos do
begin
    close;
    Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
    open;
end;


with DM.qrytotalpagamentos do
begin
    Parameters[0].Value := frmVendaComanda.dsVenda.DataSet.FieldByName('ven_id').Value;
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
