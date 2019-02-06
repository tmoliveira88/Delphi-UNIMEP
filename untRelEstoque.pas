unit untRelEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, frxClass, frxExportBaseDialog,
  frxExportPDF, frxDBSet, Data.Win.ADODB, Vcl.DBCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmRelEstoque = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    btnImprimir: TBitBtn;
    Panel2: TPanel;
    Label3: TLabel;
    EdtCodigoDe: TLabeledEdit;
    EdtCodigoAte: TLabeledEdit;
    EdtNomeDe: TLabeledEdit;
    EdtNomeAte: TLabeledEdit;
    rgAtivo: TRadioGroup;
    cbxFornecedor: TDBLookupComboBox;
    qryRelEstoque: TADOQuery;
    qryRelEstoquepro_id: TLargeintField;
    qryRelEstoquepro_nome: TStringField;
    qryRelEstoquepro_foto: TBlobField;
    qryRelEstoquepro_preco: TBCDField;
    qryRelEstoquepro_custo: TBCDField;
    qryRelEstoquepro_atividade: TStringField;
    qryRelEstoquepro_quantidade: TIntegerField;
    qryRelEstoquepro_qtd_alerta: TIntegerField;
    qryRelEstoquepro_data_cadastro: TWideStringField;
    qryRelEstoquepro_data_inativo: TWideStringField;
    qryRelEstoquepro_peso: TFloatField;
    qryRelEstoquepro_id_for: TIntegerField;
    qryRelEstoquefor_razaosocial_nome: TStringField;
    qryRelEstoquefor_nome_fantasia: TStringField;
    frxDBDataset1: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    qryRelEstoquexConfig: TADOQuery;
    qryRelEstoquexConfigconf_id: TAutoIncField;
    qryRelEstoquexConfigconf_razao_social: TStringField;
    qryRelEstoquexConfigconf_nome_fantasia: TStringField;
    qryRelEstoquexConfigconf_cnpj: TStringField;
    qryRelEstoquexConfigconf_ie: TStringField;
    qryRelEstoquexConfigconf_tel: TStringField;
    qryRelEstoquexConfigconf_cel: TStringField;
    qryRelEstoquexConfigconf_email: TStringField;
    qryRelEstoquexConfigconf_site: TStringField;
    qryRelEstoquexConfigconf_endereco: TStringField;
    qryRelEstoquexConfigconf_num_end: TStringField;
    qryRelEstoquexConfigconf_bairro: TStringField;
    qryRelEstoquexConfigconf_CEP: TStringField;
    qryRelEstoquexConfigconf_cid_id: TIntegerField;
    qryRelEstoquexConfigconf_estado: TStringField;
    dsFornecedor: TDataSource;
    frxDBDataset2: TfrxDBDataset;
    frxRelEstoque: TfrxReport;
    rgEstoque: TRadioGroup;
    qryRelEstoquefor_email: TStringField;
    qryRelEstoquefor_telefone: TStringField;
    qryRelEstoquexConfigcid_nome: TStringField;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar();
  public
    { Public declarations }
  end;

var
  frmRelEstoque: TfrmRelEstoque;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmRelEstoque.FormActivate(Sender: TObject);
begin
  DM.adoFornecedores.Close;
  DM.adoFornecedores.Open;
end;

procedure TfrmRelEstoque.Limpar;
begin
  EdtCodigoDe.Text       := '';
  EdtCodigoAte.Text      := '';
  EdtNomeDe.Text         := '';
  EdtNomeAte.Text        := '';
  rgAtivo.ItemIndex      := 0;
  rgEstoque.ItemIndex    := 0;
  cbxFornecedor.KeyValue := 0;
end;

procedure TfrmRelEstoque.btnImprimirClick(Sender: TObject);
var StrLiga : String;
begin
StrLiga := 'and ';

  if rgAtivo.ItemIndex = 0 then
    begin
      qryRelEstoque.Close;
      qryRelEstoquexConfig.Close;
        with qryRelEstoque.SQL do
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

              case rgEstoque.ItemIndex of
                1: Add(' WHERE (pro_quantidade <= pro_qtd_alerta) or (pro_peso <= pro_qtd_alerta) ');
              end;

             Add('order by for_nome_fantasia');

            end;
        qryRelEstoque.Open;
        qryRelEstoquexConfig.Open;
        frxRelEstoque.ShowReport;
        Limpar();
    end
  else if rgAtivo.ItemIndex = 1 then
    begin
      qryRelEstoque.Close;
      qryRelEstoquexConfig.Close;
        with qryRelEstoque.SQL do
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

              case rgEstoque.ItemIndex of
                1: Add(' WHERE (pro_quantidade <= pro_qtd_alerta) or (pro_peso <= pro_qtd_alerta) ');
              end;

              Add('order by for_nome_fantasia');

            end;
        qryRelEstoque.Open;
        qryRelEstoquexConfig.Open;
        frxRelEstoque.ShowReport;
        Limpar();
    end;
end;

end.
