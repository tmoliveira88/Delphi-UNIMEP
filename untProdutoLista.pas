unit untProdutoLista;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, jpeg, Vcl.ExtDlgs;

type
  TfrmProdutoLista = class(TForm)
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
    imProduto: TImage;
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
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure btnImprimirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutoLista: TfrmProdutoLista;
  CampoFiltro : string;

implementation

{$R *.dfm}

uses untProdutoDados, untDM, untRelProdutos;

procedure TfrmProdutoLista.btnAdicionarClick(Sender: TObject);
begin
      ds.dataset.append;

      DM.adoProdutospro_data_cadastro.AsDateTime := now;

      Application.CreateForm(TfrmProdutoDados, frmProdutoDados);
      frmProdutoDados.ShowModal;
      frmProdutoDados.Free;
end;

procedure TfrmProdutoLista.btnEditarClick(Sender: TObject);
begin
      ds.dataset.edit;

      Application.CreateForm(TfrmProdutoDados, frmProdutoDados);
      frmProdutoDados.ShowModal;
      frmProdutoDados.Free;
end;

procedure TfrmProdutoLista.btnExcluirClick(Sender: TObject);
begin
      if ds.DataSet.RecordCount = 0 then
      begin
           MessageBox(application.Handle, Pchar('Não existem registros para serem excluidos!'), Pchar ('Falha ao excluir registro'), mb_ok+mb_iconerror);
           exit;
      end;

      if messagebox(application.handle, Pchar('Deseja excluir este registro ?'), Pchar('Cofirmar Exclusão'), mb_yesno+mb_iconquestion ) = id_yes then
          ds.dataset.delete;
end;

procedure TfrmProdutoLista.btnFecharClick(Sender: TObject);
begin
      self.close;
end;

procedure TfrmProdutoLista.btnFiltroClick(Sender: TObject);
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

procedure TfrmProdutoLista.btnImprimirClick(Sender: TObject);
begin
  Application.CreateForm(TfrmRelProdutos, frmRelProdutos);
  frmRelProdutos.ShowModal;
  frmRelProdutos.Free;
end;

procedure TfrmProdutoLista.DBGrid1TitleClick(Column: TColumn);
begin
      lbFiltro.Caption := column.Title.Caption+': ';
      edtfiltro.Clear;
      campofiltro := column.FieldName;
      ds.DataSet.Filtered := false;

      edtfiltro.SetFocus;
end;

procedure TfrmProdutoLista.dsDataChange(Sender: TObject; Field: TField);
var
    Jpg : TJPEGImage;
    stream : TMemoryStream;
begin
  if not (DM.adoProdutospro_foto.IsNull) then begin
    try
    jpg:=TJPEGImage.Create;
    stream:=TMemoryStream.Create;

    DM.adoProdutospro_foto.SaveToStream(stream);
    stream.Seek(0, sofrombeginning);
    jpg.LoadFromStream(stream);
    imProduto.Picture.Assign(jpg);

    jpg.Free;
    stream.Free;
    except
          On e:exception do begin
            jpg.free;
            stream.Free;

            messagebox(application.Handle, Pchar(e.Message), Pchar('Falha ao Carregar imagem do Produto'), MB_OK+mb_iconwarning);
          end;
    end;
  end
  else begin
     imProduto.Picture.Assign(nil);
  end;
end;

procedure TfrmProdutoLista.edtFiltroChange(Sender: TObject);
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

procedure TfrmProdutoLista.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      ds.DataSet.Close;
end;

procedure TfrmProdutoLista.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;
end;

procedure TfrmProdutoLista.FormShow(Sender: TObject);
begin
     ds.DataSet.Open;

     lbfiltro.Caption := dbgrid1.Columns[0].Title.caption+': ';
     edtfiltro.Clear;
     CampoFiltro := dbgrid1.Columns[0].FieldName;

     ds.DataSet.Filtered := false;
end;

end.
