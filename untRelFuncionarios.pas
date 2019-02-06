unit untRelFuncionarios;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, frxClass, frxExportBaseDialog,
  frxExportPDF, frxDBSet, Data.Win.ADODB, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons;

type
  TfrmRelFuncionarios = class(TForm)
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
    rgNivelPermissao: TRadioGroup;
    rgAtivo: TRadioGroup;
    qryRelFuncionarios: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxRelFuncionarios: TfrxReport;
    qryRelFuncionariosxConfig: TADOQuery;
    qryRelFuncionariosxConfigconf_id: TAutoIncField;
    qryRelFuncionariosxConfigconf_razao_social: TStringField;
    qryRelFuncionariosxConfigconf_nome_fantasia: TStringField;
    qryRelFuncionariosxConfigconf_cnpj: TStringField;
    qryRelFuncionariosxConfigconf_ie: TStringField;
    qryRelFuncionariosxConfigconf_tel: TStringField;
    qryRelFuncionariosxConfigconf_cel: TStringField;
    qryRelFuncionariosxConfigconf_email: TStringField;
    qryRelFuncionariosxConfigconf_site: TStringField;
    qryRelFuncionariosxConfigconf_endereco: TStringField;
    qryRelFuncionariosxConfigconf_num_end: TStringField;
    qryRelFuncionariosxConfigconf_bairro: TStringField;
    qryRelFuncionariosxConfigconf_CEP: TStringField;
    qryRelFuncionariosxConfigconf_cid_id: TIntegerField;
    qryRelFuncionariosxConfigconf_estado: TStringField;
    frxDBDataset2: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    qryRelFuncionariosfun_id: TAutoIncField;
    qryRelFuncionariosfun_nome: TStringField;
    qryRelFuncionariosfun_usuario: TStringField;
    qryRelFuncionariosfun_senha: TStringField;
    qryRelFuncionariosfun_ativo: TStringField;
    qryRelFuncionariosfun_data_cadastro: TWideStringField;
    qryRelFuncionariosfun_data_inativo: TWideStringField;
    qryRelFuncionariosfun_nivel_permissao: TIntegerField;
    qryRelFuncionariosxConfigcid_nome: TStringField;
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar();
  public
    { Public declarations }
  end;

var
  frmRelFuncionarios: TfrmRelFuncionarios;

implementation

{$R *.dfm}

{ TfrmRelFuncionarios }


procedure TfrmRelFuncionarios.Limpar;
begin
  EdtCodigoDe.Text  := '';
  EdtCodigoAte.Text := '';
  EdtNomeDe.Text    := '';
  EdtNomeAte.Text   := '';
  rgOrdenacao.ItemIndex := 0;
  rgNivelPermissao.ItemIndex := -1;
  rgAtivo.ItemIndex := 0;
end;

procedure TfrmRelFuncionarios.btnImprimirClick(Sender: TObject);
var StrLiga: String;
begin
StrLiga := 'and ';

  if rgAtivo.ItemIndex = 0 then
    begin
      qryRelFuncionarios.Close;
      qryRelFuncionariosxConfig.Close;
      with qryRelFuncionarios.SQL do
        begin
          Clear;
          Add('SELECT * FROM fun_funcionario WHERE fun_ativo = ''S'' ');

          if EdtCodigoDe.Text <> '' then
          try
            StrToInt(EdtCodigoDe.Text);
            Add(StrLiga + ' fun_id > = ' + EdtCodigoDe.Text);
            except
              on EConvertError do;
          end;

          if EdtCodigoAte.Text <> '' then
          try
            StrToInt(EdtCodigoAte.Text);
            Add(StrLiga + 'fun_id < = ' + EdtCodigoAte.Text);
            except
              on EConvertError do;
          end;

          if EdtNomeDe.Text <> '' then
          begin
            Add(StrLiga + 'fun_nome >= ''' + EdtNomeDe.Text + '''');
          end;

          if EdtNomeAte.Text <> '' then
          begin
            Add(StrLiga + 'fun_nome <= ''' + EdtNomeAte.Text + 'zzz''');
          end;

          case rgNivelPermissao.ItemIndex of
            0: Add('and fun_nivel_permissao = ''1'' ');
            1: Add('and fun_nivel_permissao = ''2'' ');
            2: Add('and fun_nivel_permissao = ''3'' ');
            3: Add('and fun_nivel_permissao = ''4'' ');
          end;

          case rgOrdenacao.ItemIndex of
            0: Add('order by fun_nivel_permissao, fun_id');
            1: Add('order by fun_nivel_permissao, fun_nome');
          end;
        end;
      qryRelFuncionarios.Open;
      qryRelFuncionariosxConfig.Open;
      frxRelFuncionarios.ShowReport;
      Limpar();
    end
  else if rgAtivo.ItemIndex = 1 then
    begin
      qryRelFuncionarios.Close;
      qryRelFuncionariosxConfig.Close;
      with qryRelFuncionarios.SQL do
        begin
          Clear;
          Add('SELECT * FROM fun_funcionario WHERE fun_ativo = ''N'' ');

          if EdtCodigoDe.Text <> '' then
          try
            StrToInt(EdtCodigoDe.Text);
            Add(StrLiga + ' fun_id > = ' + EdtCodigoDe.Text);
            except
              on EConvertError do;
          end;

          if EdtCodigoAte.Text <> '' then
          try
            StrToInt(EdtCodigoAte.Text);
            Add(StrLiga + 'fun_id < = ' + EdtCodigoAte.Text);
            except
              on EConvertError do;
          end;

          if EdtNomeDe.Text <> '' then
          begin
            Add(StrLiga + 'fun_nome >= ''' + EdtNomeDe.Text + '''');
          end;

          if EdtNomeAte.Text <> '' then
          begin
            Add(StrLiga + 'fun_nome <= ''' + EdtNomeAte.Text + 'zzz''');
          end;

          case rgNivelPermissao.ItemIndex of
            0: Add('and fun_nivel_permissao = ''1'' ');
            1: Add('and fun_nivel_permissao = ''2'' ');
            2: Add('and fun_nivel_permissao = ''3'' ');
            3: Add('and fun_nivel_permissao = ''4'' ');
          end;

          case rgOrdenacao.ItemIndex of
            0: Add('order by fun_nivel_permissao, fun_id');
            1: Add('order by fun_nivel_permissao, fun_nome');
          end;
        end;
      qryRelFuncionarios.Open;
      qryRelFuncionariosxConfig.Open;
      frxRelFuncionarios.ShowReport;
      Limpar();
    end;
end;

end.
