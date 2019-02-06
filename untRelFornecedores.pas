unit untRelFornecedores;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB, frxClass, frxExportBaseDialog, frxExportPDF, frxDBSet, Data.Win.ADODB;

type
  TfrmRelFornecedores = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    btnImprimir: TBitBtn;
    Panel2: TPanel;
    EdtCodigoDe: TLabeledEdit;
    EdtCodigoAte: TLabeledEdit;
    EdtNomeDe: TLabeledEdit;
    EdtNomeAte: TLabeledEdit;
    rgOrdenacao: TRadioGroup;
    rgTipoFornecedor: TRadioGroup;
    rgAtivo: TRadioGroup;
    Label1: TLabel;
    qryRelFornecedores: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxRelFornecedores: TfrxReport;
    qryRelFornecedoresxConfig: TADOQuery;
    qryRelFornecedoresxConfigconf_id: TAutoIncField;
    qryRelFornecedoresxConfigconf_razao_social: TStringField;
    qryRelFornecedoresxConfigconf_nome_fantasia: TStringField;
    qryRelFornecedoresxConfigconf_cnpj: TStringField;
    qryRelFornecedoresxConfigconf_ie: TStringField;
    qryRelFornecedoresxConfigconf_tel: TStringField;
    qryRelFornecedoresxConfigconf_cel: TStringField;
    qryRelFornecedoresxConfigconf_email: TStringField;
    qryRelFornecedoresxConfigconf_site: TStringField;
    qryRelFornecedoresxConfigconf_endereco: TStringField;
    qryRelFornecedoresxConfigconf_num_end: TStringField;
    qryRelFornecedoresxConfigconf_bairro: TStringField;
    qryRelFornecedoresxConfigconf_CEP: TStringField;
    qryRelFornecedoresxConfigconf_cid_id: TIntegerField;
    qryRelFornecedoresxConfigconf_estado: TStringField;
    frxDBDataset2: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    qryRelFornecedoresfor_id: TAutoIncField;
    qryRelFornecedoresfor_razaosocial_nome: TStringField;
    qryRelFornecedoresfor_nome_fantasia: TStringField;
    qryRelFornecedoresfor_email: TStringField;
    qryRelFornecedoresfor_ativo: TStringField;
    qryRelFornecedoresfor_data_cadastro: TWideStringField;
    qryRelFornecedoresfor_data_inativo: TWideStringField;
    qryRelFornecedoresfor_cpf_cnpj: TStringField;
    qryRelFornecedoresfor_rg_ie: TStringField;
    qryRelFornecedoresfor_telefone: TStringField;
    qryRelFornecedoresfor_celular: TStringField;
    qryRelFornecedoresfor_endereco: TStringField;
    qryRelFornecedoresfor_num_end: TStringField;
    qryRelFornecedoresfor_bairro: TStringField;
    qryRelFornecedoresfor_CEP: TStringField;
    qryRelFornecedoresfor_cid_id: TIntegerField;
    qryRelFornecedoresfor_estado: TStringField;
    qryRelFornecedoresfor_tipo: TStringField;
    qryRelFornecedoresxConfigcid_nome: TStringField;
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar();
  public
    { Public declarations }
  end;

var
  frmRelFornecedores: TfrmRelFornecedores;

implementation

{$R *.dfm}

{ TfrmRelFornecedores }

procedure TfrmRelFornecedores.Limpar;
begin
  EdtCodigoDe.Text  := '';
  EdtCodigoAte.Text := '';
  EdtNomeDe.Text    := '';
  EdtNomeAte.Text   := '';
  rgOrdenacao.ItemIndex := 0;
  rgTipoFornecedor.ItemIndex := -1;
  rgAtivo.ItemIndex := 0;
end;

procedure TfrmRelFornecedores.btnImprimirClick(Sender: TObject);
var StrLiga: String;
begin
StrLiga := 'and ';

  if rgAtivo.ItemIndex = 0 then
    begin
      qryRelFornecedores.Close;
      qryRelFornecedoresxConfig.Close;
      with qryRelFornecedores.SQL do
        begin
          Clear;
          Add('SELECT * FROM for_fornecedor WHERE for_ativo = ''S'' ');

          if EdtCodigoDe.Text <> '' then
          try
            StrToInt(EdtCodigoDe.Text);
            Add(StrLiga + ' for_id > = ' + EdtCodigoDe.Text);
            except
              on EConvertError do;
          end;

          if EdtCodigoAte.Text <> '' then
          try
            StrToInt(EdtCodigoAte.Text);
            Add(StrLiga + 'for_id < = ' + EdtCodigoAte.Text);
            except
              on EConvertError do;
          end;

          if EdtNomeDe.Text <> '' then
          begin
            Add(StrLiga + 'for_razaosocial_nome >= ''' + EdtNomeDe.Text + '''');
          end;

          if EdtNomeAte.Text <> '' then
          begin
            Add(StrLiga + 'for_razaosocial_nome <= ''' + EdtNomeAte.Text + 'zzz''');
          end;

          case rgTipoFornecedor.ItemIndex of
            0: Add('and for_tipo = ''F'' ');
            1: Add('and for_tipo = ''J'' ');
          end;

          case rgOrdenacao.ItemIndex of
            0: Add('order by for_id');
            1: Add('order by for_razaosocial_nome');
          end;
        end;
      qryRelFornecedores.Open;
      qryRelFornecedoresxConfig.Open;
      frxRelFornecedores.ShowReport;
      Limpar();
    end
  else if rgAtivo.ItemIndex = 1 then
    begin
      qryRelFornecedores.Close;
      qryRelFornecedoresxConfig.Close;
      with qryRelFornecedores.SQL do
        begin
          Clear;
          Add('SELECT * FROM for_fornecedor WHERE for_ativo = ''N'' ');

          if EdtCodigoDe.Text <> '' then
          try
            StrToInt(EdtCodigoDe.Text);
            Add(StrLiga + ' for_id > = ' + EdtCodigoDe.Text);
            except
              on EConvertError do;
          end;

          if EdtCodigoAte.Text <> '' then
          try
            StrToInt(EdtCodigoAte.Text);
            Add(StrLiga + 'for_id < = ' + EdtCodigoAte.Text);
            except
              on EConvertError do;
          end;

          if EdtNomeDe.Text <> '' then
          begin
            Add(StrLiga + 'for_razaosocial_nome >= ''' + EdtNomeDe.Text + '''');
          end;

          if EdtNomeAte.Text <> '' then
          begin
            Add(StrLiga + 'for_razaosocial_nome <= ''' + EdtNomeAte.Text + 'zzz''');
          end;

          case rgTipoFornecedor.ItemIndex of
            0: Add('and for_tipo = ''F'' ');
            1: Add('and for_tipo = ''J'' ');
          end;

          case rgOrdenacao.ItemIndex of
            0: Add('order by for_id');
            1: Add('order by for_razaosocial_nome');
          end;
        end;
      qryRelFornecedores.Open;
      qryRelFornecedoresxConfig.Open;
      frxRelFornecedores.ShowReport;
      Limpar();
    end;
end;

end.
