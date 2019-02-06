unit untForLista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TfrmForLista = class(TForm)
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
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnFecharClick(Sender: TObject);
    procedure btnAdicionarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnFiltroClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure edtFiltroChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnEditarClick(Sender: TObject);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmForLista: TfrmForLista;
  CampoFiltro : string;

implementation

{$R *.dfm}

uses untDM, untForDados, untRelFornecedores;

procedure TfrmForLista.btnAdicionarClick(Sender: TObject);
begin
      ds.dataset.append;

      DM.adoFornecedoresfor_data_cadastro.AsDateTime := now;

      Application.CreateForm(TfrmForDados, frmForDados);
      frmForDados.ShowModal;
      frmForDados.Free;
end;

procedure TfrmForLista.btnEditarClick(Sender: TObject);
begin
      ds.dataset.edit;

      Application.CreateForm(TfrmForDados, frmForDados);
      frmForDados.ShowModal;
      frmForDados.Free;
end;

procedure TfrmForLista.btnExcluirClick(Sender: TObject);
begin
      if ds.DataSet.RecordCount = 0 then
      begin
           MessageBox(application.Handle, Pchar('Não existem registros para serem excluidos!'), Pchar ('Falha ao excluir registro'), mb_ok+mb_iconerror);
           exit;
      end;

      if messagebox(application.handle, Pchar('Deseja excluir este registro ?'), Pchar('Cofirmar Exclusão'), mb_yesno+mb_iconquestion ) = id_yes then
          ds.dataset.delete;
end;

procedure TfrmForLista.btnFecharClick(Sender: TObject);
begin
  Self.Close;
end;

procedure TfrmForLista.btnFiltroClick(Sender: TObject);
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

procedure TfrmForLista.btnImprimirClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelFornecedores, frmRelFornecedores);
  frmRelFornecedores.ShowModal;
  frmRelFornecedores.Free;
end;

procedure TfrmForLista.DBGrid1TitleClick(Column: TColumn);
begin
      lbFiltro.Caption := column.Title.Caption+': ';
      edtfiltro.Clear;
      campofiltro := column.FieldName;
      ds.DataSet.Filtered := false;

      edtfiltro.SetFocus;
end;

procedure TfrmForLista.edtFiltroChange(Sender: TObject);
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

procedure TfrmForLista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      ds.DataSet.Close;
end;

procedure TfrmForLista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;
end;

procedure TfrmForLista.FormShow(Sender: TObject);
begin
     ds.DataSet.Open;

     lbfiltro.Caption := dbgrid1.Columns[0].Title.caption+': ';
     edtfiltro.Clear;
     CampoFiltro := dbgrid1.Columns[0].FieldName;

     ds.DataSet.Filtered := false;
end;

end.
