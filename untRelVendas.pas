unit untRelVendas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Buttons, frxClass, frxExportBaseDialog, frxExportPDF, Data.DB, frxDBSet,
  Data.Win.ADODB, Vcl.ComCtrls;

type
  TfrmRelVendas = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    btnImprimir: TBitBtn;
    Panel2: TPanel;
    EdtPedidoDe: TLabeledEdit;
    EdtPedidoAte: TLabeledEdit;
    EdtCliente: TLabeledEdit;
    rgPagamento: TRadioGroup;
    Panel4: TPanel;
    Label2: TLabel;
    cbxTipoRelatorio: TComboBox;
    qryRelVendas: TADOQuery;
    frxDBDataset1: TfrxDBDataset;
    frxRelVendasSintetico: TfrxReport;
    qryRelVendasxConfig: TADOQuery;
    frxDBDataset2: TfrxDBDataset;
    frxPDFExport1: TfrxPDFExport;
    qryRelVendasven_id: TLargeintField;
    qryRelVendasven_cliente: TIntegerField;
    qryRelVendasven_caixa: TIntegerField;
    qryRelVendasven_total: TBCDField;
    qryRelVendasven_pago: TBCDField;
    qryRelVendasven_data: TWideStringField;
    qryRelVendasven_status: TStringField;
    qryRelVendasven_hora: TWideStringField;
    qryRelVendasven_caixaid: TLargeintField;
    qryRelVendasven_saida: TBCDField;
    qryRelVendasven_descricao: TStringField;
    qryRelVendasven_forma_pagamento: TStringField;
    qryRelVendascli_id: TAutoIncField;
    qryRelVendascli_nome: TStringField;
    qryRelVendascli_sexo: TStringField;
    qryRelVendascli_email: TStringField;
    qryRelVendascli_data_nascimento: TWideStringField;
    qryRelVendascli_ativo: TStringField;
    qryRelVendascli_data_cadastro: TWideStringField;
    qryRelVendascli_data_inativo: TWideStringField;
    qryRelVendascli_cpf: TStringField;
    qryRelVendascli_rg: TStringField;
    qryRelVendascli_telefone: TStringField;
    qryRelVendascli_celular: TStringField;
    qryRelVendascli_endereco: TStringField;
    qryRelVendascli_num_end: TStringField;
    qryRelVendascli_bairro: TStringField;
    qryRelVendascli_CEP: TStringField;
    qryRelVendascli_cid_id: TIntegerField;
    qryRelVendascli_estado: TStringField;
    qryRelVendascli_tipo: TStringField;
    qryRelVendasven_desconto: TFloatField;
    DateTimeDe: TDateTimePicker;
    DateTimeAte: TDateTimePicker;
    lblPeriodo: TLabel;
    Label3: TLabel;
    frxRelVendasAnalitico: TfrxReport;
    qryVendaxCliente: TADOQuery;
    frxDBDataset4: TfrxDBDataset;
    qryRelVendasxConfigconf_id: TAutoIncField;
    qryRelVendasxConfigconf_razao_social: TStringField;
    qryRelVendasxConfigconf_nome_fantasia: TStringField;
    qryRelVendasxConfigconf_cnpj: TStringField;
    qryRelVendasxConfigconf_ie: TStringField;
    qryRelVendasxConfigconf_tel: TStringField;
    qryRelVendasxConfigconf_cel: TStringField;
    qryRelVendasxConfigconf_email: TStringField;
    qryRelVendasxConfigconf_site: TStringField;
    qryRelVendasxConfigconf_endereco: TStringField;
    qryRelVendasxConfigconf_num_end: TStringField;
    qryRelVendasxConfigconf_bairro: TStringField;
    qryRelVendasxConfigconf_CEP: TStringField;
    qryRelVendasxConfigconf_cid_id: TIntegerField;
    qryRelVendasxConfigconf_estado: TStringField;
    qryRelVendasxConfigcid_id: TAutoIncField;
    qryRelVendasxConfigcid_nome: TStringField;
    qryRelVendasxConfigcid_estado: TStringField;
    qryVendaxClienteven_id: TLargeintField;
    qryVendaxClienteven_cliente: TIntegerField;
    qryVendaxClienteven_caixa: TIntegerField;
    qryVendaxClienteven_total: TBCDField;
    qryVendaxClienteven_pago: TBCDField;
    qryVendaxClienteven_data: TWideStringField;
    qryVendaxClienteven_status: TStringField;
    qryVendaxClienteven_hora: TWideStringField;
    qryVendaxClienteven_caixaid: TLargeintField;
    qryVendaxClienteven_saida: TBCDField;
    qryVendaxClienteven_descricao: TStringField;
    qryVendaxClienteven_forma_pagamento: TStringField;
    qryVendaxClientevi_id: TLargeintField;
    qryVendaxClientevi_produto: TLargeintField;
    qryVendaxClientevi_venda: TLargeintField;
    qryVendaxClientevi_valor: TBCDField;
    qryVendaxClientevi_quantidade: TIntegerField;
    qryVendaxClientevi_total: TBCDField;
    qryVendaxClientevi_peso: TFloatField;
    qryVendaxClientepro_id: TLargeintField;
    qryVendaxClientepro_nome: TStringField;
    qryVendaxClientepro_foto: TBlobField;
    qryVendaxClientepro_preco: TBCDField;
    qryVendaxClientepro_custo: TBCDField;
    qryVendaxClientepro_atividade: TStringField;
    qryVendaxClientepro_quantidade: TIntegerField;
    qryVendaxClientepro_qtd_alerta: TIntegerField;
    qryVendaxClientepro_data_cadastro: TWideStringField;
    qryVendaxClientepro_data_inativo: TWideStringField;
    qryVendaxClientepro_peso: TFloatField;
    qryVendaxClientepro_id_for: TIntegerField;
    qryVendaxClientecli_id: TAutoIncField;
    qryVendaxClientecli_nome: TStringField;
    qryVendaxClientecli_sexo: TStringField;
    qryVendaxClientecli_email: TStringField;
    qryVendaxClientecli_data_nascimento: TWideStringField;
    qryVendaxClientecli_ativo: TStringField;
    qryVendaxClientecli_data_cadastro: TWideStringField;
    qryVendaxClientecli_data_inativo: TWideStringField;
    qryVendaxClientecli_cpf: TStringField;
    qryVendaxClientecli_rg: TStringField;
    qryVendaxClientecli_telefone: TStringField;
    qryVendaxClientecli_celular: TStringField;
    qryVendaxClientecli_endereco: TStringField;
    qryVendaxClientecli_num_end: TStringField;
    qryVendaxClientecli_bairro: TStringField;
    qryVendaxClientecli_CEP: TStringField;
    qryVendaxClientecli_cid_id: TIntegerField;
    qryVendaxClientecli_estado: TStringField;
    qryVendaxClientecli_tipo: TStringField;
    procedure btnImprimirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure Limpar();
  public
    { Public declarations }
  end;

var
  frmRelVendas: TfrmRelVendas;

implementation

{$R *.dfm}

uses untDM;

{ TfrmRelVendas }

procedure TfrmRelVendas.FormShow(Sender: TObject);
var Dia, Mes, Ano : string;
Data : TDateTime;
begin
  Dia := formatdatetime('dd',date);
  Mes:= formatdatetime('mm',date);
  Ano:= formatdatetime('yyyy',date);
  Data:= strtodate(dia+'/'+mes+'/'+ano);
  DateTimeDe.Date := Data;
  DateTimeAte.Date := Data;
end;

procedure TfrmRelVendas.Limpar;
begin
  EdtPedidoDe.Text  := '';
  EdtPedidoAte.Text := '';
  EdtCliente.Text    := '';
  rgPagamento.ItemIndex := 0;
  DateTimeDe.Date := Date;
  DateTimeAte.Date := Date;
end;

procedure TfrmRelVendas.btnImprimirClick(Sender: TObject);
var StrLiga: String;
Data: TDateTime;
begin
StrLiga := 'and ';

      case cbxTipoRelatorio.ItemIndex of
      0:
        begin
          qryVendaxCliente.Close;
          qryRelVendasxConfig.Close;
          with qryVendaxCliente.SQL do
            begin
            Clear;

            Add('SELECT * FROM ven_venda INNER JOIN vi_venda_item ON ven_id = vi_venda INNER JOIN pro_produto ON vi_produto = pro_id INNER JOIN cli_cliente ON ven_cliente = cli_id ');

              if DateTimeDe.Date <= DateTimeAte.Date then
              try
                Data:= DateTimeDe.Date;
                Add(StrLiga+ 'CAST(ven_data as date) >= ''' +
                FormatDateTime('dd/mm/yyyy', Data) + '''');
              except
                  on EConvertError do;
              end;

              if DateTimeDe.Date <= DateTimeAte.Date then
              try
                Data:= DateTimeAte.Date;
                Add(StrLiga+ 'CAST(ven_data as date) <= ''' +
                FormatDateTime('dd/mm/yyyy', Data) + '''');
              except
                  on EConvertError do;
              end;

              case rgPagamento.ItemIndex of
                0: Add('WHERE ven_forma_pagamento < ''E'' ');
                1: Add('WHERE ven_forma_pagamento = ''DINHEIRO'' ');
                2: Add('WHERE ven_forma_pagamento = ''DEBITO'' ');
                3: Add('WHERE ven_forma_pagamento = ''CREDITO'' ');
              end;

              if EdtPedidoDe.Text <> '' then
              try
                StrToInt(EdtPedidoDe.Text);
                Add(StrLiga + ' ven_id > = ' + EdtPedidoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtPedidoAte.Text <> '' then
              try
                StrToInt(EdtPedidoAte.Text);
                Add(StrLiga + 'ven_id < = ' + EdtPedidoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtCliente.Text <> '' then
              begin
                Add(StrLiga + 'cli_nome like ' + #39 + '%' + EdtCliente.Text + '%' + #39 );
              end;

            Add(' order by ven_id');

            end;
          qryVendaxCliente.Open;
          qryRelVendasxConfig.Open;
          frxRelVendasAnalitico.ShowReport;
          Limpar();
        end;

      1:
        begin
          qryRelVendas.Close;
          qryRelVendasxConfig.Close;
          with qryRelVendas.SQL do
            begin
            Clear;
            Add('SELECT * FROM ven_venda INNER JOIN cli_cliente ON ven_cliente = cli_id ');

              if DateTimeDe.Date <= DateTimeAte.Date then
              try
                Data:= DateTimeDe.Date;
                Add(StrLiga+ 'CAST(ven_data as date) >= ''' +
                FormatDateTime('dd/mm/yyyy', Data) + '''');
              except
                  on EConvertError do;
              end;

              if DateTimeDe.Date <= DateTimeAte.Date then
              try
                Data:= DateTimeAte.Date;
                Add(StrLiga+ 'CAST(ven_data as date) <= ''' +
                FormatDateTime('dd/mm/yyyy', Data) + '''');
              except
                  on EConvertError do;
              end;

              case rgPagamento.ItemIndex of
                0: Add('WHERE ven_forma_pagamento < ''E'' ');
                1: Add('WHERE ven_forma_pagamento = ''DINHEIRO'' ');
                2: Add('WHERE ven_forma_pagamento = ''DEBITO'' ');
                3: Add('WHERE ven_forma_pagamento = ''CREDITO'' ');
              end;

              if EdtPedidoDe.Text <> '' then
              try
                StrToInt(EdtPedidoDe.Text);
                Add(StrLiga + ' ven_id > = ' + EdtPedidoDe.Text);
                except
                  on EConvertError do;
              end;

              if EdtPedidoAte.Text <> '' then
              try
                StrToInt(EdtPedidoAte.Text);
                Add(StrLiga + 'ven_id < = ' + EdtPedidoAte.Text);
                except
                  on EConvertError do;
              end;

              if EdtCliente.Text <> '' then
              begin
                Add(StrLiga + 'cli_nome like ' + #39 + '%' + EdtCliente.Text + '%' + #39 );
              end;
            end;
          qryRelVendas.Open;
          qryRelVendasxConfig.Open;
          frxRelVendasSintetico.ShowReport;
          Limpar();
        end;
      end;
end;

end.
