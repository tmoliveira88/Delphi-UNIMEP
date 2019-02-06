unit untIdCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  TfrmIdCliente = class(TForm)
    gbFiltro: TGroupBox;
    lbFiltro: TLabel;
    edtFiltro: TEdit;
    pnControl2: TPanel;
    btnVoltar: TBitBtn;
    btnEscolhe: TBitBtn;
    btnclientepadrao: TBitBtn;
    gbDados: TGroupBox;
    DBGrid1: TDBGrid;
    ds: TDataSource;
    procedure btnclientepadraoClick(Sender: TObject);
    procedure btnEscolheClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmIdCliente: TfrmIdCliente;
  CampoFiltro : string;

implementation

{$R *.dfm}

uses untDM, untVendaComanda;

procedure TfrmIdCliente.btnclientepadraoClick(Sender: TObject);
begin
      if DM.qryVendaComanda.Locate('ven_id', DM.qryVendaItemCmd.Parameters[0].Value, []) then
      begin
      if DM.qryVendaComanda.FieldByName('ven_cliente').Value = 1 then
      begin
        showmessage('Este cliente já está selecionado');
      end
      else
      begin
      DM.qryVendaComanda.Edit;
      DM.qryVendaComanda.FieldByName('ven_cliente').Value := 1;
      DM.qryVendaComanda.Post;
      self.close;
      end;
      end;
end;

procedure TfrmIdCliente.btnEscolheClick(Sender: TObject);
begin
      if DM.qryVendaComanda.Locate('ven_id', DM.qryVendaItemCmd.Parameters[0].Value, []) then
      begin
      if DM.qryVendaComanda.FieldByName('ven_cliente').Value = ds.DataSet.FieldByName('cli_id').Value then
      begin
        showmessage('Este cliente já está selecionado');
      end
      else
      begin
      DM.qryVendaComanda.Edit;
      DM.qryVendaComanda.FieldByName('ven_cliente').Value := ds.DataSet.FieldByName('cli_id').Value;
      DM.qryVendaComanda.Post;

      self.close;
      end;
      end;
end;

procedure TfrmIdCliente.btnVoltarClick(Sender: TObject);
begin
close;
end;

procedure TfrmIdCliente.DBGrid1TitleClick(Column: TColumn);
begin
      lbFiltro.Caption := column.Title.Caption+': ';
      edtfiltro.Clear;
      campofiltro := column.FieldName;
      ds.DataSet.Filtered := false;

      edtfiltro.SetFocus;
end;

procedure TfrmIdCliente.edtFiltroChange(Sender: TObject);
begin
      if Length(edtfiltro.Text) > 0 then
      begin
        if ds.DataSet.FieldByName(Campofiltro) is TStringField then
        begin
          ds.DataSet.Filter := Campofiltro+' like '+QuotedStr('*'+edtFiltro.Text+'*');
        end
        else
        begin
            try
            StrtoInt(edtfiltro.Text);

            ds.DataSet.Filter := Campofiltro+' = '+edtFiltro.Text;

            except on EConvertError do
            begin

            ShowMessage('Digite apenas números');

            end;


            end;
        end;
        ds.DataSet.Filtered := true;
      end
      else
      ds.DataSet.Filtered := false;
end;

procedure TfrmIdCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
       dm.qryCliFunc.Close;
       dm.qryCliFunc.Parameters[1].Value := frmVendaComanda.dsvenda.DataSet.FieldByName('ven_cliente').Value;
       dm.qryCliFunc.Open;
       frmVendaComanda.edtCliente.Text := dm.qryCliFunc.fieldbyname('cli_nome').AsString;
end;

procedure TfrmIdCliente.FormShow(Sender: TObject);
begin
ds.dataset.open;

     lbfiltro.Caption := dbgrid1.Columns[0].Title.caption+': ';
     edtfiltro.Clear;
     Campofiltro := dbgrid1.Columns[0].FieldName;

     ds.DataSet.Filtered := false;
end;

end.
