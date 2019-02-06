unit untVendaComanda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Grids,
  Vcl.DBGrids, Vcl.ExtCtrls, Vcl.Buttons, Vcl.DBCtrls, Vcl.Mask,
  IWVCLBaseControl, IWBaseControl, IWBaseHTMLControl, IWControl, IWCompLabel,
  IWDBStdCtrls, frxClass, frxDBSet,
  frxExportPDF, Data.Win.ADODB;

type
  TfrmVendaComanda = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    dbgItems: TDBGrid;
    btnOK: TBitBtn;
    Label1: TLabel;
    Panel4: TPanel;
    dbTotal: TLabel;
    Panel5: TPanel;
    dsVenda: TDataSource;
    dsVendaItem: TDataSource;
    dsCaixa: TDataSource;
    dsprodutos: TDataSource;
    Panel6: TPanel;
    Label2: TLabel;
    Label3: TLabel;
    dbeNPedido: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    edtDesconto: TEdit;
    Button1: TButton;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    adoAtualizar: TADOCommand;
    edtCliente: TEdit;
    edtCaixa: TEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
  procedure total(sender: tObject);
  var idcliente:integer; idvenda:integer;  desconto:real;
  end;

var
  frmVendaComanda: TfrmVendaComanda;
  campo:string;

implementation

{$R *.dfm}

uses untPrincipal, untAdicionarComanda, untPagamentoVComanda, untDM,
  untComandas, untIdCliente;

procedure TfrmVendaComanda.BitBtn1Click(Sender: TObject);
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
    if dsVenda.DataSet.FieldByName('ven_total').Value <> FieldByName('Total').Value then
    begin
    dsVenda.DataSet.Edit;
    dsVenda.DataSet.FieldByName('ven_total').Value := FieldByName('Total').Value;
    dsVenda.DataSet.Post;
    end;
    DM.adoCaixa.Active;
    DM.adoCaixa.Edit;
    DM.adoCaixacai_saldo_total.Value := DM.adoCaixacai_saldo_inicial.AsFloat + FieldByName('Total').AsFloat;
    DM.adoCaixa.Post;
    if FieldByName('Total').AsFloat > 0 then
    begin
      btnOK.Enabled := true;
    end;
end;

   if (dsvenda.DataSet.FieldByName('ven_total').AsString = '') then
     begin
       btnOk.Enabled := false;
           dbTotal.Caption := 'R$ #,0.00';
     end;
total(sender);
dsvendaitem.DataSet.Refresh;
end;

procedure TfrmVendaComanda.BitBtn2Click(Sender: TObject);
begin
      Application.CreateForm(TfrmAdicionarComanda, frmAdicionarComanda);
      frmAdicionarComanda.ShowModal;
      frmAdicionarComanda.Free;
end;

procedure TfrmVendaComanda.BitBtn3Click(Sender: TObject);
begin
close;
end;

procedure TfrmVendaComanda.btnOKClick(Sender: TObject);
begin
      Application.CreateForm(TfrmPagamentoVComanda, frmPagamentoVComanda);
      frmPagamentoVComanda.ShowModal;
      frmPagamentoVComanda.Free;
end;

procedure TfrmVendaComanda.Button1Click(Sender: TObject);
begin
      Application.CreateForm(TfrmIdCliente, frmIdCliente);
      frmIdCliente.ShowModal;
      frmIdCliente.Free;
end;

procedure TfrmVendaComanda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dbTotal.Caption := '';

      dsvendaitem.dataset.Close;
      dsprodutos.DataSet.Close;
      dsvenda.DataSet.close;
      dsvenda.DataSet.open;
      checkbox1.Checked := false;
      btnOk.Enabled := false;

      dm.qryCliFunc.Close;
end;

procedure TfrmVendaComanda.total(sender: tObject);
begin
with DM.qryCalculaTotal do
begin
    Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_id').Value;
    Open;
    if FieldByName('Total').AsFloat > 0 then
    begin
      btnOK.Enabled := true;
    end;
    dbTotal.Caption := FormatFloat('R$ #,0.00',FieldByName('Total').AsFloat);
    Close;
end;
end;

procedure TfrmVendaComanda.FormShow(Sender: TObject);
begin
      dsvenda.DataSet.Open;

      dsprodutos.DataSet.Open;
      dscaixa.DataSet.Open;

       dm.qryCliFunc.Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_caixa').Value;
       dm.qryCliFunc.Parameters[1].Value := dsvenda.DataSet.FieldByName('ven_cliente').Value;
       dm.qryCliFunc.Open;
       edtCaixa.Text := dm.qryCliFunc.fieldbyname('fun_nome').AsString;
       edtCliente.Text := dm.qryCliFunc.fieldbyname('cli_nome').AsString;

      DM.qryVendaItemCmd.Parameters[0].Value := frmComandas.idvenda;
      dsvendaitem.dataset.open;
      total(sender);

      dbeNPedido.Caption := dm.qryVendaComandaven_id.AsString;
end;

end.


