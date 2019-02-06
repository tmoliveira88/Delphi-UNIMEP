unit untConsultaRel;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.StdCtrls, Vcl.ComCtrls, Vcl.ExtCtrls, Vcl.Buttons, frxClass, frxDBSet,
  frxExportPDF, frxExportBaseDialog, Data.Win.ADODB;

type
  TfrmConsultaRel = class(TForm)
    Panel1: TPanel;
    dtpData1: TDateTimePicker;
    Label1: TLabel;
    dtpData2: TDateTimePicker;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    dshis: TDataSource;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGrid2: TDBGrid;
    pnlBottom: TPanel;
    btnImprimirCaixa: TBitBtn;
    dsven: TDataSource;
    Label3: TLabel;
    Panel2: TPanel;
    btnSair: TBitBtn;
    btnImprimirLancamentos: TBitBtn;
    Label4: TLabel;
    frdCaixa: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    frxReport2: TfrxReport;
    frdVendas: TfrxDBDataset;
    qryRelCaixaxConfig: TADOQuery;
    qryRelCaixaxConfigconf_id: TAutoIncField;
    qryRelCaixaxConfigconf_razao_social: TStringField;
    qryRelCaixaxConfigconf_nome_fantasia: TStringField;
    qryRelCaixaxConfigconf_cnpj: TStringField;
    qryRelCaixaxConfigconf_ie: TStringField;
    qryRelCaixaxConfigconf_tel: TStringField;
    qryRelCaixaxConfigconf_cel: TStringField;
    qryRelCaixaxConfigconf_email: TStringField;
    qryRelCaixaxConfigconf_site: TStringField;
    qryRelCaixaxConfigconf_endereco: TStringField;
    qryRelCaixaxConfigconf_num_end: TStringField;
    qryRelCaixaxConfigconf_bairro: TStringField;
    qryRelCaixaxConfigconf_CEP: TStringField;
    qryRelCaixaxConfigconf_cid_id: TIntegerField;
    qryRelCaixaxConfigconf_estado: TStringField;
    qryRelCaixaxConfigcid_nome: TStringField;
    frxDBDataset2: TfrxDBDataset;
    procedure btnSairClick(Sender: TObject);
    procedure btnImprimirLancamentosClick(Sender: TObject);
    procedure btnImprimirCaixaClick(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure dtpData1Change(Sender: TObject);
    procedure dtpData2Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConsultaRel: TfrmConsultaRel;

implementation

{$R *.dfm}

uses untDM, untItensVenda;

procedure TfrmConsultaRel.btnSairClick(Sender: TObject);
begin
self.Close;
end;

procedure TfrmConsultaRel.btnImprimirLancamentosClick(Sender: TObject);
begin
  frxReport2.ShowReport;
end;

procedure TfrmConsultaRel.btnImprimirCaixaClick(Sender: TObject);
begin
  frxReport1.ShowReport;
end;

procedure TfrmConsultaRel.DBGrid1CellClick(Column: TColumn);
begin
dsven.DataSet.Close;
DM.qryRelItemCaixa.Parameters[0].Value := DM.qryRelCaixacai_id.AsInteger;
dsven.DataSet.Open;
end;

procedure TfrmConsultaRel.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
dsven.DataSet.Close;
DM.qryRelItemCaixa.Parameters[0].Value := DM.qryRelCaixacai_id.Value;
dsven.DataSet.Open;
end;

procedure TfrmConsultaRel.DBGrid2CellClick(Column: TColumn);
begin
     DM.qryRelItemVenda.Parameters[0].Value := DM.qryRelItemCaixaven_id.Value;
end;

procedure TfrmConsultaRel.DBGrid2DblClick(Sender: TObject);
begin
    if dsven.DataSet.IsEmpty then
    begin
      showmessage('Não há vendas disponíveis para consulta!');
    end
    else if (DM.qryRelItemCaixaven_status.Value = 'ENTRADA')   then
    begin
      showmessage('Este item não pode ser visualizado pois é um Acréscimo!');
    end
    else if (DM.qryRelItemCaixaven_status.Value = 'SANGRIA') then
    begin
      showmessage('Este item não pode ser visualizado pois é uma Sangria!');
    end
    else if (DM.qryRelItemCaixaven_status.Value = 'INICIAL') then
    begin
      showmessage('Este item não pode ser visualizado pois é um Saldo Inicial!');
    end
    else
    begin
    Application.CreateForm(TfrmItensVenda, frmItensVenda);
    frmItensVenda.ShowModal;
    frmItensVenda.Free;
    end;
end;

procedure TfrmConsultaRel.dtpData1Change(Sender: TObject);
var valor:real;
begin
dshis.DataSet.close;
DM.qryRelCaixa.Parameters[0].Value := dtpdata1.DateTime;
dshis.DataSet.open;

valor := 0;

  with DM.qryRelCaixa do
  begin
    DM.qryRelCaixa.DisableControls;
    DM.qryRelCaixa.First;

    while not DM.qryRelCaixa.Eof do
    begin
        valor := (valor + DM.qryRelCaixa.FieldByName('cai_saldo_total').AsFloat - DM.qryRelCaixa.FieldByName('cai_saldo_inicial').AsFloat);
        DM.qryRelCaixa.Next;
    end;

    DM.qryRelCaixa.EnableControls;

    label4.Caption := FormatFloat('R$ #,0.00',valor);

  end;
end;

procedure TfrmConsultaRel.dtpData2Change(Sender: TObject);
var valor:real;
begin
dshis.DataSet.close;
DM.qryRelCaixa.Parameters[1].Value := dtpdata2.DateTime;
dshis.DataSet.open;

valor := 0;

  with DM.qryRelCaixa do
  begin
    DM.qryRelCaixa.DisableControls;
    DM.qryRelCaixa.First;

    while not DM.qryRelCaixa.Eof do
    begin
        valor := (valor + DM.qryRelCaixa.FieldByName('cai_saldo_total').AsFloat - DM.qryRelCaixa.FieldByName('cai_saldo_inicial').AsFloat);
        DM.qryRelCaixa.Next;
    end;

    DM.qryRelCaixa.EnableControls;

    label4.Caption := FormatFloat('R$ #,0.00',valor);

  end;
end;

procedure TfrmConsultaRel.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dshis.DataSet.Close;
dsven.DataSet.Close;
end;

procedure TfrmConsultaRel.FormShow(Sender: TObject);
begin
dtpData1.Date := now;
dtpdata2.Date := now;
DM.qryRelCaixa.Parameters[0].Value := dtpdata1.DateTime;
DM.qryRelCaixa.Parameters[1].Value := dtpdata2.DateTime;

dshis.DataSet.Open;
dsven.DataSet.Open;


label4.Caption := '';
end;

end.
