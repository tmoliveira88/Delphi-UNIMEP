unit untVendaCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  IWDBStdCtrls, frxClass, frxDBSet,
  frxExportPDF, Data.Win.ADODB;

type
  TfrmVendaCaixa = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    btnRemover: TBitBtn;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    Label1: TLabel;
    Panel2: TPanel;
    Panel4: TPanel;
    Label5: TLabel;
    dbTotal: TLabel;
    Label6: TLabel;
    dbeNPedido: TLabel;
    Panel5: TPanel;
    CheckBox1: TCheckBox;
    edtDesconto: TEdit;
    BitBtn2: TBitBtn;
    dsVenda: TDataSource;
    dsVendaItem: TDataSource;
    dsFuncionario: TDataSource;
    dsprodutos: TDataSource;
    dsCaixa: TDataSource;
    adoAtualizar: TADOCommand;
    edtCaixa: TEdit;
    Button1: TButton;
    Label2: TLabel;
    edtCliente: TEdit;
    dbgItems: TDBGrid;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnRemoverClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure edtDescontoChange(Sender: TObject);
    procedure edtDescontoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure novavenda(Sender: TObject);
  procedure total(sender: tObject);
  var idcliente:integer; idvenda:integer;  desconto:real;
  end;

var
  frmVendaCaixa: TfrmVendaCaixa;
  campo:string;

implementation

{$R *.dfm}

uses untPrincipal, untAdicionarPedido, untPagamentoVCaixa, untDM, untIdeCliente;

procedure TfrmVendaCaixa.BitBtn2Click(Sender: TObject);
begin
      Application.CreateForm(TfrmAdicionarPedido, frmAdicionarPedido);
      frmAdicionarPedido.ShowModal;
      frmAdicionarPedido.Free;
end;

procedure TfrmVendaCaixa.btnCancelarClick(Sender: TObject);
var vlLinha: Integer; va:string;
begin
dbTotal.Caption := '';

      if not dsVendaItem.dataset.IsEmpty then
      begin
      with dbgItems.DataSource.DataSet do
      begin
      First;
      for vlLinha := 0 to RecordCount - 1 do
      begin
      dm.QryProdutos.Open;
      va := dbgItems.columns.items[0].field.text;

      if dsprodutos.DataSet.Locate('pro_id', va, [loCaseInsensitive]) then
      begin
          if dsprodutos.DataSet.FieldByName('pro_peso').AsString <> '' then
          begin
          dsprodutos.DataSet.Edit;
          dsprodutos.DataSet.FieldByName('pro_peso').Value := dsprodutos.DataSet.FieldByName('pro_peso').Value + dsvendaitem.DataSet.FieldByName('vi_peso').Value;
          dsprodutos.DataSet.Post;
          end
          else
          begin
          dsprodutos.DataSet.Edit;
          dsprodutos.DataSet.FieldByName('pro_quantidade').Value := dsprodutos.DataSet.FieldByName('pro_quantidade').Value + dsvendaitem.DataSet.FieldByName('vi_quantidade').Value;
          dsprodutos.DataSet.Post;
          end;
      end;
      dsvendaitem.DataSet.Close;
      adoAtualizar.CommandText := '';
      adoAtualizar.CommandText := 'DELETE FROM vi_venda_item WHERE vi_produto = ''' +va+ ''' AND vi_venda = ''' +dsvenda.DataSet.FieldByName('ven_id').AsString+ ''' ';
      adoAtualizar.Execute;
      dsvendaitem.DataSet.Open;
      Next;
      end;
      First;
      for vlLinha := 0 to RecordCount - 1 do
      begin
      dbgItems.SelectedRows.CurrentRowSelected := True;
      Next;
      end;
      end;
      dbgItems.SelectedRows.Delete;

      end;


      dsvenda.dataset.delete;
//      dsvenda.dataset.close;
//      dsvendaitem.dataset.close;
//      dsprodutos.DataSet.close;
//      dscaixa.DataSet.close;

checkbox1.Checked := false;
btnOk.Enabled := false;
dm.qryCliFunc.Close;
close;
end;

procedure TfrmVendaCaixa.btnOKClick(Sender: TObject);
begin
      Application.CreateForm(TfrmPagamentoVCaixa, frmPagamentoVCaixa);
      frmPagamentoVCaixa.ShowModal;
      frmPagamentoVCaixa.Free;
end;

procedure TfrmVendaCaixa.btnRemoverClick(Sender: TObject);
var va:string;
begin
      if dsvendaitem.DataSet.IsEmpty then
      begin
      showmessage ('Registro vazio');
      end
      else if not  dsvendaitem.DataSet.IsEmpty then
      begin
      dm.QryProdutos.Open;
      va := dbgItems.columns.items[0].field.text;

      if dsprodutos.DataSet.Locate('pro_id', va, [loCaseInsensitive]) then
      begin
          if dsprodutos.DataSet.FieldByName('pro_peso').AsString <> '' then
          begin
          dsprodutos.DataSet.Edit;
          dsprodutos.DataSet.FieldByName('pro_peso').Value := dsprodutos.DataSet.FieldByName('pro_peso').Value + dsvendaitem.DataSet.FieldByName('vi_peso').Value;
          dsprodutos.DataSet.Post;
          end
          else
          begin
          dsprodutos.DataSet.Edit;
          dsprodutos.DataSet.FieldByName('pro_quantidade').Value := dsprodutos.DataSet.FieldByName('pro_quantidade').Value + dsvendaitem.DataSet.FieldByName('vi_quantidade').Value;
          dsprodutos.DataSet.Post;
          end;
      end;
      dsvendaitem.DataSet.Close;
      adoAtualizar.CommandText := '';
      adoAtualizar.CommandText := 'DELETE FROM vi_venda_item WHERE vi_produto = ''' +va+ ''' AND vi_venda = ''' +dsvenda.DataSet.FieldByName('ven_id').AsString+ ''' ';
      adoAtualizar.Execute;
      dsvendaitem.DataSet.Open;
      end;

with DM.qryCalculaTotal do
begin

    Parameters[0].Value := dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
    dsVenda.DataSet.Edit;
    dsVenda.DataSet.FieldByName('ven_total').Value := FieldByName('Total').Value;
    DM.adoCaixa.Active;
    DM.adoCaixa.Edit;
    DM.adoCaixacai_saldo_total.Value := DM.adoCaixacai_saldo_inicial.AsFloat + FieldByName('Total').AsFloat;
    DM.adoCaixa.Post;
end;

   if (dsvenda.DataSet.FieldByName('ven_total').AsString = '') then
     begin
       btnOk.Enabled := false;
           dbTotal.Caption := 'R$ #,0.00';
     end;
total(sender);
dsvendaitem.DataSet.Refresh;
end;

procedure TfrmVendaCaixa.Button1Click(Sender: TObject);
begin
      Application.CreateForm(TfrmIdeCliente, frmIdeCliente);
      frmIdeCliente.ShowModal;
      frmIdeCliente.Free;
end;

procedure TfrmVendaCaixa.CheckBox1Click(Sender: TObject);
begin
      if checkbox1.Checked = true then
      begin
      edtdesconto.Enabled := true;
      end
      else
      begin
        edtdesconto.Enabled := false;
        edtdesconto.Text := ',00';
      end;
end;

procedure TfrmVendaCaixa.edtDescontoChange(Sender: TObject);
begin
     desconto := StrToFloat(edtdesconto.Text);
end;

procedure TfrmVendaCaixa.edtDescontoKeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['0'..'9',',', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmVendaCaixa.novavenda(Sender: TObject);
var
  myDate : TDateTime;
  myHour, myMin, mySec, myMilli : Word;
begin
       dm.qryCliFunc.Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_caixa').Value;
       dm.qryCliFunc.Parameters[1].Value := dsvenda.DataSet.FieldByName('ven_cliente').Value;
       dm.qryCliFunc.Open;
       edtCaixa.Text := dm.qryCliFunc.fieldbyname('fun_nome').AsString;
       edtCliente.Text := dm.qryCliFunc.fieldbyname('cli_nome').AsString;

      dbTotal.Caption := 'R$ 0,00';

      idcliente := 1;

      myDate := now;

      DecodeTime(myDate, myHour, myMin, mySec, myMilli);

      with dsvenda.DataSet do begin

        append;
        fieldbyname('ven_cliente').Value := idcliente;
        fieldbyname('ven_caixa').Value := frmprincipal.iddocaixa;
        fieldbyname('ven_status').Value := 'ABERTO';
        fieldbyname('ven_descricao').Value := 'VENDA NO CAIXA';
        fieldbyname('ven_data').AsDateTime := now;
        fieldbyname('ven_hora').AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
        dm.adoCaixa.Last;
        fieldbyname('ven_caixaid').Value := dm.adoCaixa.FieldByName('cai_id').Value;
        post;
        edit;
        fieldbyname('ven_descricao').Value := 'VENDA NO CAIXA ' + fieldbyname('ven_id').AsString;
        post;
      end;

      DM.qryVendaItem.Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_id').Value;

      dbeNPedido.Caption := DM.adoVendaven_id.AsString;

      dbgItems.Refresh;
      close;
end;

procedure TfrmVendaCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//      dsvenda.dataset.delete;
      dsvenda.dataset.close;
      dsvendaitem.dataset.close;
      dsprodutos.DataSet.close;
      dscaixa.DataSet.close;
end;

procedure TfrmVendaCaixa.FormShow(Sender: TObject);
var
  myDate : TDateTime;
  myHour, myMin, mySec, myMilli : Word;
begin
      dsvenda.dataset.open;
      dsprodutos.DataSet.Open;
      dscaixa.DataSet.Open;

       dm.qryCliFunc.Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_caixa').Value;
       dm.qryCliFunc.Parameters[1].Value := dsvenda.DataSet.FieldByName('ven_cliente').Value;
       dm.qryCliFunc.Open;
       edtCaixa.Text := dm.qryCliFunc.fieldbyname('fun_nome').AsString;
       edtCliente.Text := dm.qryCliFunc.fieldbyname('cli_nome').AsString;

      dbTotal.Caption := 'R$ 0,00';

      idcliente := 1;

      myDate := now;

      DecodeTime(myDate, myHour, myMin, mySec, myMilli);

      with dsvenda.DataSet do begin
        append;
        fieldbyname('ven_cliente').Value := idcliente;
        fieldbyname('ven_caixa').Value := frmprincipal.iddocaixa;
        fieldbyname('ven_status').Value := 'ABERTO';
        fieldbyname('ven_descricao').Value := 'VENDA NO CAIXA';
        fieldbyname('ven_data').AsDateTime := now;
        fieldbyname('ven_hora').AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
        dm.adoCaixa.Last;
        fieldbyname('ven_caixaid').Value := dm.adoCaixa.FieldByName('cai_id').Value;
        post;
        edit;
        fieldbyname('ven_descricao').Value := 'VENDA NO CAIXA - ID Nº ' + fieldbyname('ven_id').AsString;
        post;
      end;

      dsvenda.DataSet.Last;
      DM.qryVendaItem.Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_id').Value;
      dsvendaitem.dataset.open;
      dbeNPedido.Caption := DM.adoVendaven_id.AsString;
end;

procedure TfrmVendaCaixa.total(sender: tObject);
begin
with DM.qryCalculaTotal do
begin
    Parameters[0].Value := dsVenda.DataSet.FieldByName('ven_id').Value;
    Open;
    dbTotal.Caption := FormatFloat('R$ #,0.00',FieldByName('Total').AsFloat);
    Close;
end;
end;

end.


