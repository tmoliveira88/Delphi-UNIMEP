unit untAdicionarPedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmAdicionarPedido = class(TForm)
    Button1: TButton;
    Panel2: TPanel;
    Panel3: TPanel;
    edtFiltro: TEdit;
    lbFiltro: TLabel;
    dsprodutos: TDataSource;
    dbgProdutos: TDBGrid;
    btnFiltro: TBitBtn;
    procedure Button1Click(Sender: TObject);
    procedure dbgProdutosDblClick(Sender: TObject);
    procedure dbgProdutosTitleClick(Column: TColumn);
    procedure edtFiltroChange(Sender: TObject);
    procedure edtFiltroKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  frmAdicionarPedido: TfrmAdicionarPedido;

implementation

{$R *.dfm}

uses untPrincipal, untVendaCaixa, untDM;

procedure TfrmAdicionarPedido.btnFiltroClick(Sender: TObject);
begin
    if dsprodutos.DataSet.FieldByName(Campo) is TStringField then
    begin
      dsprodutos.DataSet.Filter := Campo+' like '+ QuotedStr('*'+edtfiltro.Text+'*');
    end
    else
    begin
      try

      StrtoInt(edtfiltro.Text);

      dsprodutos.DataSet.Filter := Campo+' = '+ edtfiltro.Text;

      except on EConvertError do

      begin

      ShowMessage('Digite apenas números');

      end;

      end;
    end;
    dsprodutos.DataSet.Filtered := true;

    edtfiltro.SetFocus;
end;

procedure TfrmAdicionarPedido.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfrmAdicionarPedido.dbgProdutosDblClick(Sender: TObject);
var qtd:integer;
peso,pesooo:real;
sera:string;
begin

        peso := Trunc(DM.qryProdutospro_peso.Value);
        qtd  := Trunc(DM.qryProdutospro_quantidade.Value);

   if not frmVendaCaixa.dsvendaitem.DataSet.Locate('vi_produto', dsprodutos.DataSet.FieldByName('pro_id').Value, [loCaseInsensitive]) then
   begin
      with frmVendaCaixa.dsvendaitem.dataset do
      begin
      Append;
      if (peso >= 1) then
      begin
      sera := Inputbox('Digite o peso','Qual é o peso da venda?','');
      if sera <> '' then
      begin
        pesooo := strtofloat(sera);
      end;
      if (pesooo = 0) or (pesooo > DM.qryProdutospro_peso.AsFloat) then
      begin
      showmessage('Quantidade Invalida!');
      end
      else
      begin
      fieldbyname('vi_produto').Value := DM.qryProdutospro_id.Value;
      fieldbyname('vi_valor').Value := dsprodutos.DataSet.FieldByName('pro_preco').Value;
      FieldByName('vi_peso').Value := pesooo;
      fieldbyname('vi_total').Value := fieldbyname('vi_peso').value * fieldbyname('vi_valor').Value;
      fieldbyname('vi_venda').AsInteger := frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_id').AsInteger;
      Post;
      DM.qryProdutos.Active;
      DM.qryProdutos.Edit;
      DM.qryProdutospro_peso.Value := DM.qryProdutospro_peso.Value - frmVendaCaixa.dsvendaitem.dataset.fieldbyname('vi_peso').Value;
      DM.qryProdutos.Post;
      peso := peso-FieldByName('vi_peso').Value;
      end
      end
      else if (qtd >= 1) then
      begin
      fieldbyname('vi_produto').Value := dsprodutos.DataSet.FieldByName('pro_id').Value;
      fieldbyname('vi_valor').Value := dsprodutos.DataSet.FieldByName('pro_preco').Value;
      fieldbyname('vi_quantidade').Value := 1;
      fieldbyname('vi_total').Value := fieldbyname('vi_quantidade').Value * fieldbyname('vi_valor').Value;
      fieldbyname('vi_venda').AsInteger := frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_id').AsInteger;
      Post;
      DM.qryProdutos.Active;
      DM.qryProdutos.Edit;
      DM.qryProdutospro_quantidade.Value := DM.qryProdutospro_quantidade.Value - frmVendaCaixa.dsvendaitem.dataset.fieldbyname('vi_quantidade').Value;
      DM.qryProdutos.Post;
      qtd := qtd-1;
      end
      else if (dsprodutos.DataSet.FieldByName('pro_peso').Value = 0) then
      begin
         showmessage('Produto Não Disponivel em Estoque!');
      end
      else if (dsprodutos.DataSet.FieldByName('pro_quantidade').Value = 0) then
      begin
         showmessage('Produto Não Disponivel em Estoque');
      end;
     end;
   end
   else
   begin
    with frmVendaCaixa.dsvendaitem.dataset do
    begin
      if (frmVendaCaixa.dsvendaitem.DataSet.FieldByName('vi_peso').Value >= 1) then
      begin
      sera := Inputbox('Digite o peso','Qual é o peso da venda?','');
      if sera <> '' then
      begin
        pesooo := strtofloat(sera);
      end;
      if (pesooo = 0) or (pesooo > DM.qryProdutospro_peso.AsFloat) then
      begin
      showmessage('Quantidade Invalida!');
      end
      else
      begin
      Edit;
      fieldbyname('vi_peso').Value := fieldbyname('vi_peso').Value + strtofloat(sera);
      fieldbyname('vi_total').Value := fieldbyname('vi_peso').value * fieldbyname('vi_valor').Value;
      Post;
      DM.qryProdutos.Active;
      DM.qryProdutos.Edit;
      DM.qryProdutospro_peso.Value :=  DM.qryProdutospro_peso.Value - pesooo;
      DM.qryProdutos.Post;
      peso := peso-pesooo;
      end;
      end
      else if (frmVendaCaixa.dsvendaitem.DataSet.FieldByName('vi_quantidade').Value >= 1) and (qtd > 0) then
      begin
      Edit;
      fieldbyname('vi_quantidade').Value := fieldbyname('vi_quantidade').Value + 1;
      fieldbyname('vi_total').Value := fieldbyname('vi_quantidade').Value * fieldbyname('vi_valor').Value;
      Post;
      DM.qryProdutos.Active;
      DM.qryProdutos.Edit;
      DM.qryProdutospro_quantidade.Value :=  DM.qryProdutospro_quantidade.Value - 1;
      DM.qryProdutos.Post;
      qtd := qtd-1;
      end
      else if (peso = 0) then
      begin
               showmessage('Produto Não Disponivel em Estoque');
      end
      else if (qtd = 0) then
      begin
               showmessage('Produto Não Disponivel em Estoque');
      end;
    end;
   end;

      frmVendaCaixa.idvenda := frmVendaCaixa.dsvenda.DataSet.fieldbyname('ven_id').value;

with DM.qryCalculaTotal do
begin

    Parameters[0].Value := frmVendaCaixa.dsvenda.DataSet.FieldByName('ven_id').Value;
    Open;
    frmVendaCaixa.dsVenda.DataSet.Edit;
    frmVendaCaixa.dsVenda.DataSet.FieldByName('ven_total').Value := FieldByName('Total').Value;
    Close;
end;

if frmVendaCaixa.btnOk.Enabled = false then
begin
frmVendaCaixa.btnOk.Enabled := true;
end;

      frmVendaCaixa.total(sender);

//DM.qryVendaItem.Close;
//DM.qryVendaItem.Open;
//frmVendaCaixa.dsvendaitem.DataSet.Refresh;
frmVendaCaixa.dsvendaitem.DataSet.Close;
frmVendaCaixa.dsvendaitem.DataSet.Open;
dsprodutos.DataSet.Filter := '';
dsprodutos.DataSet.Filtered :=  false;
edtfiltro.Clear;
end;

procedure TfrmAdicionarPedido.dbgProdutosTitleClick(Column: TColumn);
begin
    campo := column.fieldname;
    lbfiltro.caption := column.title.caption+': ';
    edtfiltro.clear;
end;

procedure TfrmAdicionarPedido.edtFiltroChange(Sender: TObject);
begin
      if length(edtfiltro.Text) = 0 then
      begin
          dsprodutos.DataSet.Filtered := false;
          btnfiltro.Enabled := false;
      end
      else begin
        btnfiltro.Enabled := true;
      end;

//      if Length(edtfiltro.Text) > 0 then
//      begin
//        if dsprodutos.DataSet.FieldByName(Campo) is TStringField then
//        begin
//          dsprodutos.DataSet.Filter := campo+' like '+QuotedStr('*'+edtFiltro.Text+'*');
//        end
//        else
//        begin
//            try
//            StrtoInt(edtfiltro.Text);
//
//              if edtfiltro.Text = dsprodutos.DataSet.FieldByName('pro_id').AsString then
//               begin
//               dbgProdutosDblClick(Sender);
//          	    dsprodutos.DataSet.Filter := campo+' = '+edtFiltro.Text;
//               end;
//
//            except on EConvertError do
//            begin
//
//            ShowMessage('Digite apenas números');
//
//            end;
//
//
//            end;
//        end;
//       dsprodutos.DataSet.Filtered := true;
//      end
//      else
//      dsprodutos.DataSet.Filtered := false;
end;

procedure TfrmAdicionarPedido.edtFiltroKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
    begin
        dbgProdutosDblClick(Sender);
    end;
end;

procedure TfrmAdicionarPedido.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dsprodutos.DataSet.Close;
end;

procedure TfrmAdicionarPedido.FormShow(Sender: TObject);
begin
      dsprodutos.DataSet.Open;

      lbfiltro.Caption := dbgProdutos.Columns[0].Title.caption+': ';
     edtfiltro.Clear;
     Campo := dbgProdutos.Columns[0].FieldName;

      edtFiltro.clear;
end;

end.
