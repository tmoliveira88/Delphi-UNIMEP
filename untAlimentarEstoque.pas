unit untAlimentarEstoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Data.DB, Vcl.Grids, Vcl.DBGrids, jpeg;

type
  TfrmAlimentarEstoque = class(TForm)
    gbFiltro: TGroupBox;
    gbDados: TGroupBox;
    DBGrid1: TDBGrid;
    lbFiltro: TLabel;
    edtFiltro: TEdit;
    imProduto: TImage;
    ds: TDataSource;
    pnTopo: TPanel;
    Label2: TLabel;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure dsDataChange(Sender: TObject; Field: TField);
    procedure edtFiltroChange(Sender: TObject);
    procedure edtFiltroKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAlimentarEstoque: TfrmAlimentarEstoque;
  CampoFiltro : string;

implementation

{$R *.dfm}

uses untDM, untQtdEstoque;

procedure TfrmAlimentarEstoque.DBGrid1DblClick(Sender: TObject);
begin
  Application.CreateForm(TfrmQtdEstoque, frmQtdEstoque);
  frmQtdEstoque.ShowModal;
  frmQtdEstoque.Free;

  ds.DataSet.Refresh;
  ds.DataSet.Filter := '';
  ds.DataSet.Filtered :=  false;
  edtfiltro.Clear;
end;

procedure TfrmAlimentarEstoque.DBGrid1TitleClick(Column: TColumn);
begin
  lbFiltro.Caption := column.Title.Caption+': ';
  edtfiltro.Clear;
  campofiltro := column.FieldName;
  ds.DataSet.Filtered := false;

  edtfiltro.SetFocus;
end;

procedure TfrmAlimentarEstoque.dsDataChange(Sender: TObject; Field: TField);
var
    Jpg : TJPEGImage;
    stream : TMemoryStream;
begin
  if not (DM.qryProdutospro_foto.IsNull) then begin
    try
    jpg:=TJPEGImage.Create;
    stream:=TMemoryStream.Create;

    DM.qryProdutospro_foto.SaveToStream(stream);
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

procedure TfrmAlimentarEstoque.edtFiltroChange(Sender: TObject);
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

              if edtfiltro.Text = ds.DataSet.FieldByName('pro_id').AsString then
               begin
               DBGrid1DblClick(Sender);
               ds.DataSet.Filter := Campofiltro+' = '+edtFiltro.Text;
               end;

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

procedure TfrmAlimentarEstoque.edtFiltroKeyPress(Sender: TObject;
  var Key: Char);
begin
if key = #13 then
    begin
        DBGrid1DblClick(Sender);
    end;
end;

procedure TfrmAlimentarEstoque.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  DM.adoProdutos.Close;
  ds.DataSet.Close;
end;

procedure TfrmAlimentarEstoque.FormShow(Sender: TObject);
begin
DM.adoProdutos.Open;
ds.DataSet.open;

      Campofiltro := 'pro_id';
      ds.dataset.Filtered := false;
      lbfiltro.caption := 'ID: ';
      edtFiltro.clear;
end;

end.
