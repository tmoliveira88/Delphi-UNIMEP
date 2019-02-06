unit untProdutoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, jpeg, Vcl.ExtDlgs;

type
  TfrmProdutoDados = class(TForm)
    ds: TDataSource;
    pnControle: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    gbdados: TGroupBox;
    Panel1: TPanel;
    imProduto: TImage;
    Panel2: TPanel;
    lblID: TLabel;
    lblNome: TLabel;
    lblPreco: TLabel;
    lblCusto: TLabel;
    lblQuantidade: TLabel;
    lblEstoqueMinimo: TLabel;
    lblAtivo: TLabel;
    lblPeso: TLabel;
    lblDataCadastro: TLabel;
    lblInativoDesde: TLabel;
    dbeCusto: TDBEdit;
    dbeID: TDBEdit;
    dbeNome: TDBEdit;
    dbePreco: TDBEdit;
    dbeQtd: TDBEdit;
    dbeQtdA: TDBEdit;
    dbePeso: TDBEdit;
    dbcAtivo: TDBComboBox;
    dbeCadastro: TDBEdit;
    dbeInativo: TDBEdit;
    BitBtn1: TBitBtn;
    odfoto: TOpenPictureDialog;
    lblFornecedor: TLabel;
    dsFornecedor: TDataSource;
    dbLookupFornecedor: TDBLookupComboBox;
    pnTopo: TPanel;
    Label2: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn1Click(Sender: TObject);
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure dbeQtdExit(Sender: TObject);
    procedure dbePesoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmProdutoDados: TfrmProdutoDados;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmProdutoDados.BitBtn1Click(Sender: TObject);
var jpg : TjpegImage;
begin

  if odFoto.Execute then
  try
  begin
        ds.dataset.edit;
        jpg := TJPEGImage.Create;
        DM.adoProdutospro_foto.LoadFromFile(odfoto.FileName);
        jpg.loadfromfile(odfoto.FileName);

        imProduto.Picture.Assign(jpg);
        jpg.Free;
  end;
  except
        on E:exception do begin
          jpg.Free;
          Messagebox(application.Handle, Pchar('É permitido apenas arquivos JPG!'), Pchar('Falha ao carregar imagem'), MB_OK+mb_iconwarning);
        end;

  end;
end;

procedure TfrmProdutoDados.btnCancelarClick(Sender: TObject);
begin
      ds.DataSet.Cancel;
      close;
end;

procedure TfrmProdutoDados.btnFecharClick(Sender: TObject);
begin
      self.close;
end;

procedure TfrmProdutoDados.btnSalvarClick(Sender: TObject);
begin
  if DM.adoProdutospro_atividade.Value = 'N' then
  begin
    DM.adoProdutospro_data_inativo.AsDateTime := now;
  end
  else if DM.adoProdutospro_atividade.Value = 'S' then
  begin
    DM.adoProdutospro_data_inativo.Clear;
  end;

  if (dbeID.Text = '') then
  begin
    Application.MessageBox('Informe o [Código] do Produto.','Aviso',MB_OK+MB_ICONWARNING);
    dbeID.SetFocus;
    Abort;
  end;

  if (dbcAtivo.Text = '') then
  begin
    Application.MessageBox('O campo [Ativo] é de preenchimento obrigatório.','Aviso',MB_OK+MB_ICONWARNING);
    dbcAtivo.SetFocus;
    Abort;
  end;

  if (dbeNome.Text = '') then
  begin
    Application.MessageBox('Informe a [Descrição] do Produto.','Aviso',MB_OK+MB_ICONWARNING);

    dbeNome.SetFocus;
    Abort;
  end;

  if (dbLookupFornecedor.Text = '') then
  begin
    Application.MessageBox('Informe o [Fornecedor] do Produto.','Aviso',MB_OK+MB_ICONWARNING);

    dbLookupFornecedor.SetFocus;
    Abort;
  end;

  if (dbeCusto.Text = '') then
  begin
    Application.MessageBox('Informe o [Custo] do Produto.','Aviso',MB_OK+MB_ICONWARNING);

    dbeCusto.SetFocus;
    Abort;
  end;

  if (dbePreco.Text = '') then
  begin
    Application.MessageBox('Informe o [Preço] do Produto.','Aviso',MB_OK+MB_ICONWARNING);

    dbePreco.SetFocus;
    Abort;
  end;

  DM.adoProdutos.Post;
end;

procedure TfrmProdutoDados.dbeQtdExit(Sender: TObject);
begin
  if (dbeQtd.Text <> '') then
    begin
      dbePeso.Enabled := False;
      dbePeso.Text := '';
      dbeQtdA.SetFocus;
    end
  else
    begin
      dbePeso.Enabled := True;
      dbePeso.SetFocus;
    end;
end;

procedure TfrmProdutoDados.dbePesoExit(Sender: TObject);
begin
  if (dbePeso.Text <> '') then
    begin
      dbeQtd.Enabled := False;
      dbeQtd.Text := '';
      dbeQtdA.SetFocus;
    end
  else
    begin
      dbeQtd.Enabled := True;
      dbeQtd.SetFocus;
    end;
end;


procedure TfrmProdutoDados.dsDataChange(Sender: TObject; Field: TField);
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

procedure TfrmProdutoDados.dsStateChange(Sender: TObject);
begin
      if ds.State in [dsInsert, dsEdit] then
      begin
        btnSalvar.Enabled := true;
        btnCancelar.Enabled := true;
      end
      else begin
        btnSalvar.Enabled := false;
        btnCancelar.Enabled := false;
      end;

end;

procedure TfrmProdutoDados.FormActivate(Sender: TObject);
begin
  dsFornecedor.DataSet.Close;
  dsFornecedor.DataSet.Open;
end;

procedure TfrmProdutoDados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;

end;

end.
