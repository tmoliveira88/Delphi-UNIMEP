unit untRelProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet, Data.DB, Data.Win.ADODB, frxBarcode,
  Vcl.DBCtrls;

type
  TfrmRelProdutos = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    btnImprimir: TBitBtn;
    Panel2: TPanel;
    EdtCodigoDe: TLabeledEdit;
    EdtCodigoAte: TLabeledEdit;
    EdtNomeDe: TLabeledEdit;
    EdtNomeAte: TLabeledEdit;
    rgOrdenacao: TRadioGroup;
    rgAtivo: TRadioGroup;
    qryRelProdutos: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxRelProdutosAnalitico: TfrxReport;
    qryRelProdutosxConfig: TADOQuery;
    qryRelProdutosxConfigconf_id: TAutoIncField;
    qryRelProdutosxConfigconf_razao_social: TStringField;
    qryRelProdutosxConfigconf_nome_fantasia: TStringField;
    qryRelProdutosxConfigconf_cnpj: TStringField;
    qryRelProdutosxConfigconf_ie: TStringField;
    qryRelProdutosxConfigconf_tel: TStringField;
    qryRelProdutosxConfigconf_cel: TStringField;
    qryRelProdutosxConfigconf_email: TStringField;
    qryRelProdutosxConfigconf_site: TStringField;
    qryRelProdutosxConfigconf_endereco: TStringField;
    qryRelProdutosxConfigconf_num_end: TStringField;
    qryRelProdutosxConfigconf_bairro: TStringField;
    qryRelProdutosxConfigconf_CEP: TStringField;
    qryRelProdutosxConfigconf_cid_id: TIntegerField;
    qryRelProdutosxConfigconf_estado: TStringField;
    frxDBDataset2: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    frxRelProdEtiquetas: TfrxReport;
    cbxTipoRelatorio: TComboBox;
    Label2: TLabel;
    frxRelProdutosSintetico: TfrxReport;
    qryRelProdutospro_id: TLargeintField;
    qryRelProdutospro_nome: TStringField;
    qryRelProdutospro_foto: TBlobField;
    qryRelProdutospro_preco: TBCDField;
    qryRelProdutospro_custo: TBCDField;
    qryRelProdutospro_atividade: TStringField;
    qryRelProdutospro_quantidade: TIntegerField;
    qryRelProdutospro_qtd_alerta: TIntegerField;
    qryRelProdutospro_data_cadastro: TWideStringField;
    qryRelProdutospro_data_inativo: TWideStringField;
    qryRelProdutospro_peso: TFloatField;
    qryRelProdutospro_id_for: TIntegerField;
    qryRelProdutosfor_razaosocial_nome: TStringField;
    qryRelProdutosfor_nome_fantasia: TStringField;
    Panel4: TPanel;
    frxBarCodeObject1: TfrxBarCodeObject;
    cbxFornecedor: TDBLookupComboBox;
    Label3: TLabel;
    dsFornecedor: TDataSource;
    qryRelProdutosxConfigcid_nome: TStringField;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar();
  public
    { Public declarations }
  end;

var
  frmRelProdutos: TfrmRelProdutos;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmRelProdutos.FormActivate(Sender: TObject);
begin
  DM.adoFornecedores.Close;
  DM.adoFornecedores.Open;
end;

procedure TfrmRelProdutos.Limpar;
begin
  EdtCodigoDe.Text  := '';
  EdtCodigoAte.Text := '';
  EdtNomeDe.Text    := '';
  EdtNomeAte.Text   := '';
  rgOrdenacao.ItemIndex := 0;
  rgAtivo.ItemIndex := 0;
  cbxFornecedor.KeyValue := 0;
end;

procedure TfrmRelProdutos.btnImprimirClick(Sender: TObject);
var StrLiga: String;
begin
StrLiga := 'and ';

  if rgAtivo.ItemIndex = 0 then
    begin
      case cbxTipoRelatorio.ItemIndex of
      0:
        begin
          qryRelProdutos.Close;
          qryRelProdutosxConfig.Close;
          with qryRelProdutos.SQL do
            begin
            Clear;
            Add('SELECT * FROM pro_produto INNER JOIN for_fornecedor ON pro_id_for = for_id '
            + 'and pro_atividade = ''S'' ');

              if EdtCodigoDe.Text <> '' then
              try
                StrToInt(EdtCodigoDe.Text);
                Add(StrLiga + ' pro_id > = ' + EdtCodigoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtCodigoAte.Text <> '' then
              try
                StrToInt(EdtCodigoAte.Text);
                Add(StrLiga + 'pro_id < = ' + EdtCodigoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtNomeDe.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome >= ''' + EdtNomeDe.Text + '''');
              end;

              if EdtNomeAte.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome <= ''' + EdtNomeAte.Text + 'zzz''');
              end;

              if cbxFornecedor.Text <> '' then
              begin
                Add(StrLiga + 'for_nome_fantasia = ''' + cbxFornecedor.Text + '''');
              end;

              case rgOrdenacao.ItemIndex of
                0: Add('order by pro_id');
                1: Add('order by pro_nome');
              end;
            end;
          qryRelProdutos.Open;
          frxRelProdutosAnalitico.ShowReport;
          Limpar();
        end;

      1:
        begin
          qryRelProdutos.Close;
          qryRelProdutosxConfig.Close;
          with qryRelProdutos.SQL do
            begin
            Clear;
            Add('SELECT * FROM pro_produto INNER JOIN for_fornecedor ON pro_id_for = for_id '
            + 'and pro_atividade = ''S'' ');

              if EdtCodigoDe.Text <> '' then
              try
                StrToInt(EdtCodigoDe.Text);
                Add(StrLiga + ' pro_id > = ' + EdtCodigoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtCodigoAte.Text <> '' then
              try
                StrToInt(EdtCodigoAte.Text);
                Add(StrLiga + 'pro_id < = ' + EdtCodigoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtNomeDe.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome >= ''' + EdtNomeDe.Text + '''');
              end;

              if EdtNomeAte.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome <= ''' + EdtNomeAte.Text + 'zzz''');
              end;

              if cbxFornecedor.Text <> '' then
              begin
                Add(StrLiga + 'for_nome_fantasia = ''' + cbxFornecedor.Text + '''');
              end;

              case rgOrdenacao.ItemIndex of
                0: Add('order by pro_id');
                1: Add('order by pro_nome');
              end;
            end;
          qryRelProdutos.Open;
          frxRelProdutosSintetico.ShowReport;
          Limpar();
        end;
      2:
        begin
          qryRelProdutos.Close;
          qryRelProdutosxConfig.Close;
          with qryRelProdutos.SQL do
            begin
            Clear;
            Add('SELECT * FROM pro_produto INNER JOIN for_fornecedor ON pro_id_for = for_id '
            + 'and pro_atividade = ''S'' ');

              if EdtCodigoDe.Text <> '' then
              try
                StrToInt(EdtCodigoDe.Text);
                Add(StrLiga + ' pro_id > = ' + EdtCodigoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtCodigoAte.Text <> '' then
              try
                StrToInt(EdtCodigoAte.Text);
                Add(StrLiga + 'pro_id < = ' + EdtCodigoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtNomeDe.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome >= ''' + EdtNomeDe.Text + '''');
              end;

              if EdtNomeAte.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome <= ''' + EdtNomeAte.Text + 'zzz''');
              end;

              if cbxFornecedor.Text <> '' then
              begin
                Add(StrLiga + 'for_nome_fantasia = ''' + cbxFornecedor.Text + '''');
              end;

              case rgOrdenacao.ItemIndex of
                0: Add('order by pro_id');
                1: Add('order by pro_nome');
              end;
            end;
          qryRelProdutos.Open;
          frxRelProdEtiquetas.ShowReport;
          Limpar();
        end;
      end;
    end
  else if rgAtivo.ItemIndex = 1 then
    begin
      case cbxTipoRelatorio.ItemIndex of
      0:
        begin
          qryRelProdutos.Close;
          qryRelProdutosxConfig.Close;
          with qryRelProdutos.SQL do
            begin
            Clear;
            Add('SELECT * FROM pro_produto INNER JOIN for_fornecedor ON pro_id_for = for_id '
            + 'and pro_atividade = ''N'' ');

              if EdtCodigoDe.Text <> '' then
              try
                StrToInt(EdtCodigoDe.Text);
                Add(StrLiga + ' pro_id > = ' + EdtCodigoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtCodigoAte.Text <> '' then
              try
                StrToInt(EdtCodigoAte.Text);
                Add(StrLiga + 'pro_id < = ' + EdtCodigoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtNomeDe.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome >= ''' + EdtNomeDe.Text + '''');
              end;

              if EdtNomeAte.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome <= ''' + EdtNomeAte.Text + 'zzz''');
              end;

              if cbxFornecedor.Text <> '' then
              begin
                Add(StrLiga + 'for_nome_fantasia = ''' + cbxFornecedor.Text + '''');
              end;

              case rgOrdenacao.ItemIndex of
                0: Add('order by pro_id');
                1: Add('order by pro_nome');
              end;
            end;
          qryRelProdutos.Open;
          frxRelProdutosAnalitico.ShowReport;
          Limpar();
        end;

      1:
        begin
          qryRelProdutos.Close;
          qryRelProdutosxConfig.Close;
          with qryRelProdutos.SQL do
            begin
            Clear;
            Add('SELECT * FROM pro_produto INNER JOIN for_fornecedor ON pro_id_for = for_id '
            + 'and pro_atividade = ''N'' ');

              if EdtCodigoDe.Text <> '' then
              try
                StrToInt(EdtCodigoDe.Text);
                Add(StrLiga + ' pro_id > = ' + EdtCodigoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtCodigoAte.Text <> '' then
              try
                StrToInt(EdtCodigoAte.Text);
                Add(StrLiga + 'pro_id < = ' + EdtCodigoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtNomeDe.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome >= ''' + EdtNomeDe.Text + '''');
              end;

              if EdtNomeAte.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome <= ''' + EdtNomeAte.Text + 'zzz''');
              end;

              if cbxFornecedor.Text <> '' then
              begin
                Add(StrLiga + 'for_nome_fantasia = ''' + cbxFornecedor.Text + '''');
              end;

              case rgOrdenacao.ItemIndex of
                0: Add('order by pro_id');
                1: Add('order by pro_nome');
              end;
            end;
          qryRelProdutos.Open;
          frxRelProdutosSintetico.ShowReport;
          Limpar();
        end;
      2:
        begin
          qryRelProdutos.Close;
          qryRelProdutosxConfig.Close;
          with qryRelProdutos.SQL do
            begin
            Clear;
            Add('SELECT * FROM pro_produto INNER JOIN for_fornecedor ON pro_id_for = for_id '
            + 'and pro_atividade = ''N'' ');

              if EdtCodigoDe.Text <> '' then
              try
                StrToInt(EdtCodigoDe.Text);
                Add(StrLiga + ' pro_id > = ' + EdtCodigoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtCodigoAte.Text <> '' then
              try
                StrToInt(EdtCodigoAte.Text);
                Add(StrLiga + 'pro_id < = ' + EdtCodigoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtNomeDe.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome >= ''' + EdtNomeDe.Text + '''');
              end;

              if EdtNomeAte.Text <> '' then
              begin
                Add(StrLiga + 'pro_nome <= ''' + EdtNomeAte.Text + 'zzz''');
              end;

              if cbxFornecedor.Text <> '' then
              begin
                Add(StrLiga + 'for_nome_fantasia = ''' + cbxFornecedor.Text + '''');
              end;

              case rgOrdenacao.ItemIndex of
                0: Add('order by pro_id');
                1: Add('order by pro_nome');
              end;
            end;
          qryRelProdutos.Open;
          frxRelProdEtiquetas.ShowReport;
          Limpar();
        end;
      end;
    end

end;

end.
