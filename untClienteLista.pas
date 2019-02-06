unit untClienteLista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Data.Win.ADODB;

type
  TfrmClienteLista = class(TForm)
    gbFiltro: TGroupBox;
    gbDados: TGroupBox;
    pnControle: TPanel;
    DBGrid1: TDBGrid;
    btnFechar: TBitBtn;
    btnExcluir: TBitBtn;
    btnAdicionar: TBitBtn;
    btnEditar: TBitBtn;
    ds: TDataSource;
    lbFiltro: TLabel;
    edtFiltro: TEdit;
    btnFiltro: TBitBtn;
    btnImprimir: TBitBtn;
    pnTopo: TPanel;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtFiltroChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEditarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFecharClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClienteLista: TfrmClienteLista;
  CampoFiltro : string;

implementation

{$R *.dfm}

uses untClienteDados, untDM, untRelClientes;

procedure TfrmClienteLista.btnAdicionarClick(Sender: TObject);
begin
      ds.dataset.append;

      DM.adoClientecli_data_cadastro.AsDateTime := now;

      Application.CreateForm(TfrmClienteDados, frmClienteDados);
      frmClienteDados.ShowModal;
      frmClienteDados.Free;
end;

procedure TfrmClienteLista.btnEditarClick(Sender: TObject);
begin
      ds.dataset.edit;

      Application.CreateForm(TfrmClienteDados, frmClienteDados);
      frmClienteDados.ShowModal;
      frmClienteDados.Free;
end;

procedure TfrmClienteLista.btnExcluirClick(Sender: TObject);
begin
      if ds.DataSet.RecordCount = 0 then
      begin
           MessageBox(application.Handle, Pchar('Não existem registros para serem excluídos!'), Pchar ('Falha ao excluir registro'), mb_ok+mb_iconerror);
           exit;
      end;

      if messagebox(application.handle, Pchar('Deseja excluir este registro ?'), Pchar('Cofirmar Exclusão'), mb_yesno+mb_iconquestion ) = id_yes then
      ds.dataset.delete;
end;

procedure TfrmClienteLista.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmClienteLista.btnFiltroClick(Sender: TObject);
begin
    if ds.DataSet.FieldByName(CampoFiltro) is TStringField then
    begin
      ds.DataSet.Filter := Campofiltro+' like '+ QuotedStr('*'+edtfiltro.Text+'*');
    end
    else
    begin
      try

      StrtoInt(edtfiltro.Text);

      ds.DataSet.Filter := Campofiltro+' = '+ edtfiltro.Text;

      except on EConvertError do

      begin

      ShowMessage('Digite apenas números');

      end;

      end;
    end;
    ds.DataSet.Filtered := true;

    edtfiltro.SetFocus;
end;

procedure TfrmClienteLista.btnImprimirClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelClientes, frmRelClientes);
  frmRelClientes.ShowModal;
  frmRelClientes.Free;
end;

procedure TfrmClienteLista.DBGrid1TitleClick(Column: TColumn);
begin
      lbFiltro.Caption := column.Title.Caption+': ';
      edtfiltro.Clear;
      campofiltro := column.FieldName;
      ds.DataSet.Filtered := false;

      edtfiltro.SetFocus;
end;

procedure TfrmClienteLista.edtFiltroChange(Sender: TObject);
begin
      if length(edtfiltro.Text) = 0 then
      begin
          ds.DataSet.Filtered := false;
          btnfiltro.Enabled := false;
      end
      else begin
        btnfiltro.Enabled := true;
      end;
end;

procedure TfrmClienteLista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      ds.DataSet.Close;
end;

procedure TfrmClienteLista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;
end;

procedure TfrmClienteLista.FormShow(Sender: TObject);
begin
     ds.DataSet.Close;
     ds.DataSet.Open;

     lbfiltro.Caption := dbgrid1.Columns[0].Title.caption+': ';
     edtfiltro.Clear;
     CampoFiltro := dbgrid1.Columns[0].FieldName;

end;

end.
