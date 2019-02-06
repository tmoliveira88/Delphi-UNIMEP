unit untRelClientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, frxClass,
  frxDBSet, Data.DB, Data.Win.ADODB, Vcl.Buttons, Vcl.DBCtrls,
  frxExportBaseDialog, frxExportPDF;

type
  TfrmRelClientes = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    btnImprimir: TBitBtn;
    qryRelClientes: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxRelClientes: TfrxReport;
    qryRelClientescli_id: TAutoIncField;
    qryRelClientescli_nome: TStringField;
    qryRelClientescli_sexo: TStringField;
    qryRelClientescli_email: TStringField;
    qryRelClientescli_data_nascimento: TWideStringField;
    qryRelClientescli_ativo: TStringField;
    qryRelClientescli_data_cadastro: TWideStringField;
    qryRelClientescli_data_inativo: TWideStringField;
    qryRelClientescli_cpf: TStringField;
    qryRelClientescli_rg: TStringField;
    qryRelClientescli_telefone: TStringField;
    qryRelClientescli_celular: TStringField;
    qryRelClientescli_endereco: TStringField;
    qryRelClientescli_num_end: TStringField;
    qryRelClientescli_bairro: TStringField;
    qryRelClientescli_CEP: TStringField;
    qryRelClientescli_cid_id: TIntegerField;
    qryRelClientescli_estado: TStringField;
    qryRelClientescli_tipo: TStringField;
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
    Panel2: TPanel;
    EdtCodigoDe: TLabeledEdit;
    EdtCodigoAte: TLabeledEdit;
    EdtNomeDe: TLabeledEdit;
    EdtNomeAte: TLabeledEdit;
    rgOrdenacao: TRadioGroup;
    rgTipoCliente: TRadioGroup;
    rgAtivo: TRadioGroup;
    rgSexo: TRadioGroup;
    frxPDFExport1: TfrxPDFExport;
    qryRelClientesxConfigcid_nome: TStringField;
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar();
  public
    { Public declarations }
  end;

var
  frmRelClientes: TfrmRelClientes;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmRelClientes.Limpar;
begin
  EdtCodigoDe.Text  := '';
  EdtCodigoAte.Text := '';
  EdtNomeDe.Text    := '';
  EdtNomeAte.Text   := '';
  rgOrdenacao.ItemIndex := 0;
  rgTipoCliente.ItemIndex := -1;
  rgAtivo.ItemIndex := 0;
  rgSexo.ItemIndex := -1;
end;

procedure TfrmRelClientes.btnImprimirClick(Sender: TObject);
var StrLiga: String;
begin
StrLiga := 'and ';

  if rgAtivo.ItemIndex = 0 then
    begin
      qryRelClientes.Close;
      qryRelClientesxConfig.Close;
      with qryRelClientes.SQL do
        begin
          Clear;
          Add('SELECT * FROM cli_cliente WHERE cli_ativo = ''S'' ');

          if EdtCodigoDe.Text <> '' then
          try
            StrToInt(EdtCodigoDe.Text);
            Add(StrLiga + ' cli_id > = ' + EdtCodigoDe.Text);
            except
              on EConvertError do;
          end;

          if EdtCodigoAte.Text <> '' then
          try
            StrToInt(EdtCodigoAte.Text);
            Add(StrLiga + 'cli_id < = ' + EdtCodigoAte.Text);
            except
              on EConvertError do;
          end;

          if EdtNomeDe.Text <> '' then
          begin
            Add(StrLiga + 'cli_nome >= ''' + EdtNomeDe.Text + '''');
          end;

          if EdtNomeAte.Text <> '' then
          begin
            Add(StrLiga + 'cli_nome <= ''' + EdtNomeAte.Text + 'zzz''');
          end;

          case rgTipoCliente.ItemIndex of
            0: Add('and cli_tipo = ''F'' ');
            1: Add('and cli_tipo = ''J'' ');
          end;

           case rgSexo.ItemIndex of
            0: Add('and cli_sexo = ''M'' ');
            1: Add('and cli_sexo = ''F'' ');
          end;

          case rgOrdenacao.ItemIndex of
            0: Add('order by cli_id');
            1: Add('order by cli_nome');
          end;
        end;
      qryRelClientes.Open;
      qryRelClientesxConfig.Open;
      frxRelClientes.ShowReport;
      Limpar();
    end
  else if rgAtivo.ItemIndex = 1 then
     begin
      qryRelClientes.Close;
      qryRelClientesxConfig.Close;
      with qryRelClientes.SQL do
        begin
          Clear;
          Add('SELECT * FROM cli_cliente WHERE cli_ativo = ''N'' ');

          if EdtCodigoDe.Text <> '' then
          try
            StrToInt(EdtCodigoDe.Text);
            Add(StrLiga + ' cli_id > = ' + EdtCodigoDe.Text);
            except
              on EConvertError do;
          end;

          if EdtCodigoAte.Text <> '' then
          try
            StrToInt(EdtCodigoAte.Text);
            Add(StrLiga + 'cli_id < = ' + EdtCodigoAte.Text);
            except
              on EConvertError do;
          end;

          if EdtNomeDe.Text <> '' then
          begin
            Add(StrLiga + 'cli_nome >= ''' + EdtNomeDe.Text + '''');
          end;

          if EdtNomeAte.Text <> '' then
          begin
            Add(StrLiga + 'cli_nome <= ''' + EdtNomeAte.Text + 'zzz''');
          end;

          case rgTipoCliente.ItemIndex of
            0: Add('and cli_tipo = ''F'' ');
            1: Add('and cli_tipo = ''J'' ');
          end;

          case rgSexo.ItemIndex of
            0: Add('and cli_sexo = ''M'' ');
            1: Add('and cli_sexo = ''F'' ');
          end;

          case rgOrdenacao.ItemIndex of
            0: Add('order by cli_id');
            1: Add('order by cli_nome');
          end;

        end;
      qryRelClientes.Open;
      qryRelClientesxConfig.Open;
      frxRelClientes.ShowReport;
      Limpar();
     end;
end;

end.
