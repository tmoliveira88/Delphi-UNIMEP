unit untComandas;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ButtonGroup, Data.DB, Vcl.Grids, Vcl.DBGrids, system.UITypes;

type
  TfrmComandas = class(TForm)
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    lbFiltro: TLabel;
    edtFiltro: TEdit;
    Button4: TButton;
    dsVenda: TDataSource;
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    procedure newcommand(Sender: TObject);
    { Private declarations }
  public
    var idvenda,co1:integer;
  end;

var
  frmComandas: TfrmComandas;
    CampoFiltro : string;

implementation

{$R *.dfm}

uses untVendaComanda, untDM, untPrincipal;

procedure TfrmComandas.Button1Click(Sender: TObject);
begin
close;
end;

procedure TfrmComandas.Button2Click(Sender: TObject);
var  myDate : TDateTime;
  myHour, myMin, mySec, myMilli : Word;
begin
      myDate := now;

      DecodeTime(myDate, myHour, myMin, mySec, myMilli);

      with dsvenda.DataSet do begin

        append;
        fieldbyname('ven_cliente').Value := 1;
        fieldbyname('ven_caixa').Value := frmprincipal.iddocaixa;
        fieldbyname('ven_status').Value := 'ABERTA';
        fieldbyname('ven_descricao').Value := 'COMANDA';
        fieldbyname('ven_data').AsDateTime := now;
        fieldbyname('ven_hora').AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
        dm.adoCaixa.Last;
        fieldbyname('ven_caixaid').Value := dm.adoCaixa.FieldByName('cai_id').Value;
        post;
        edit;
        fieldbyname('ven_descricao').Value := 'COMANDA ' + fieldbyname('ven_id').AsString;
        post;
      end;
//      dsvenda.DataSet.close;
//      dsvenda.DataSet.open;
      dsvenda.DataSet.FindLast;
      DBGrid1DblClick(sender);
end;

procedure TfrmComandas.Button4Click(Sender: TObject);
begin
If MessageBox(Handle,'Deseja apagar a comanda Selecionado?', 'Favor confirmar...', MB_YESNO+MB_SYSTEMMODAL+MB_ICONQUESTION+MB_DEFBUTTON1 ) = ID_Yes then
begin
if dsvenda.dataset.IsEmpty then
begin
showmessage('Não há nenhuma comanda!');
end
else
dsvenda.DataSet.Delete;
dsvenda.DataSet.Close;
dsvenda.DataSet.Open;
end;
end;

procedure TfrmComandas.DBGrid1DblClick(Sender: TObject);
begin
      if dsvenda.DataSet.IsEmpty then
      begin
          showmessage('Nenhuma comanda aberta');
      end
      else
      begin
      DM.qryVendaItemCmd.Parameters[0].Value := dsvenda.DataSet.FieldByName('ven_id').Value;
      idvenda := dsvenda.DataSet.FieldByName('ven_id').Value;
      newcommand(Sender);
      end;
end;


procedure TfrmComandas.DBGrid1TitleClick(Column: TColumn);
begin
      lbFiltro.Caption := column.Title.Caption+': ';
      edtfiltro.Clear;
      campofiltro := column.FieldName;
      dsvenda.DataSet.Filtered := false;

      edtfiltro.SetFocus;
end;

procedure TfrmComandas.edtFiltroChange(Sender: TObject);
begin
      if Length(edtfiltro.Text) > 0 then
      begin
        if dsvenda.DataSet.FieldByName(Campofiltro) is TStringField then
        begin
          dsvenda.DataSet.Filter := Campofiltro+' like '+QuotedStr('*'+edtFiltro.Text+'*');
        end
        else
        begin
            try
            StrtoInt(edtfiltro.Text);

            dsvenda.DataSet.Filter := Campofiltro+' = '+edtFiltro.Text;

            except on EConvertError do
            begin

            ShowMessage('Digite apenas números');

            end;


            end;
        end;
        dsvenda.DataSet.Filtered := true;
      end
      else
      dsvenda.DataSet.Filtered := false;
end;

procedure TfrmComandas.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dsVenda.DataSet.close;
DM.adoCaixa.Close;
end;

procedure TfrmComandas.FormShow(Sender: TObject);
begin
dsVenda.DataSet.Open;
DM.adoCaixa.Open;

     lbfiltro.Caption := dbgrid1.Columns[0].Title.caption+': ';
     edtfiltro.Clear;
     CampoFiltro := dbgrid1.Columns[0].FieldName;

     dsvenda.DataSet.Filtered := false;
end;

procedure TfrmComandas.newcommand(Sender: TObject);
begin
      Application.CreateForm(TfrmVendaComanda, frmVendaComanda);
      frmVendaComanda.ShowModal;
      frmVendaComanda.Free;
end;

end.
