unit untPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, System.Actions, Vcl.ActnList,
  System.ImageList, Vcl.ImgList, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.ToolWin,
  Vcl.Imaging.pngimage;

type
  TfrmPrincipal = class(TForm)
    Image1: TImage;
    stbPrincipal: TStatusBar;
    pgControl: TPageControl;
    PRINCIPAL: TTabSheet;
    tbPrincipal: TToolBar;
    ToolButton21: TToolButton;
    ToolButton9: TToolButton;
    ToolButton2: TToolButton;
    ToolButton20: TToolButton;
    ToolButton1: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton10: TToolButton;
    ToolButton6: TToolButton;
    btnRelatorios: TToolButton;
    ToolButton16: TToolButton;
    ToolButton19: TToolButton;
    ToolButton17: TToolButton;
    ToolButton18: TToolButton;
    ToolButton11: TToolButton;
    ToolButton23: TToolButton;
    Panel1: TPanel;
    PRODUTOS: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    btnEstoque: TToolButton;
    ToolButton22: TToolButton;
    btnProdutos: TToolButton;
    ToolButton4: TToolButton;
    btnFuncionarios: TToolButton;
    ToolButton5: TToolButton;
    btnClientes: TToolButton;
    ToolButton26: TToolButton;
    btnConfiguracao: TToolButton;
    ToolButton29: TToolButton;
    btnBackup: TToolButton;
    Panel2: TPanel;
    tmrDataHora: TTimer;
    ilPrincipal48: TImageList;
    ilPrincipal20: TImageList;
    i64: TImageList;
    btnFornecedores: TToolButton;
    ToolButton30: TToolButton;
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure btnEstoqueClick(Sender: TObject);
    procedure btnProdutosClick(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure btnConfiguracaoClick(Sender: TObject);
    procedure btnBackupClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnFuncionariosClick(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure tmrDataHoraTimer(Sender: TObject);
    procedure btnFornecedoresClick(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
  private
    { Private declarations }
  public
  var iddocaixa:integer;
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

{$R *.dfm}

uses untCaixa, untVendaCaixa, untComandas, untClienteLista, untAlimentarEstoque,
  untProdutoLista, untConsultaRel, untConfig, untBackup, untLogIn, untFuncLista,
  untDM, untForLista, untRelatorios;

procedure TfrmPrincipal.FormShow(Sender: TObject);
begin
    frmLogin:=TfrmLogin.Create(self);
    frmLogin.ShowModal;

   DM.AdoCaixa.Open;
   DM.AdoCaixa.last;
   if DM.adoCaixa.IsEmpty then
   begin
        ToolButton1.Enabled := false;
        ToolButton8.enabled := false;
   end
   else if DM.AdoCaixacai_data_fechamento.value = '' then
   begin
        ToolButton1.Enabled := true;
        ToolButton8.enabled := true;
   end
   else
   begin
        ToolButton1.Enabled := false;
        ToolButton8.enabled := false;
   end;
   DM.AdoCaixa.Close;

    stbPrincipal.Panels[1].Text:='Usuário em sessão: '+ DM.qryLoginfun_usuario.AsString;
    stbPrincipal.Font.Name:='Calibri-Bold';
    stbPrincipal.Font.Size:=10;
end;

procedure TfrmPrincipal.btnFornecedoresClick(Sender: TObject);
begin
    Application.CreateForm(TfrmForLista, frmForLista);
    frmForLista.ShowModal;
    frmForLista.Free;
end;

procedure TfrmPrincipal.tmrDataHoraTimer(Sender: TObject);
begin
      stbPrincipal.Panels[0].Text:=datetostr(date)+ ' - '+timetostr(time);
end;

procedure TfrmPrincipal.ToolButton11Click(Sender: TObject);
begin
      Application.Terminate;
end;

procedure TfrmPrincipal.btnRelatoriosClick(Sender: TObject);
begin
      Application.CreateForm(TfrmRelatorios, frmRelatorios);
      frmRelatorios.ShowModal;
      frmRelatorios.Free;
end;

procedure TfrmPrincipal.btnFuncionariosClick(Sender: TObject);
begin
      Application.CreateForm(TfrmFuncLista, frmFuncLista);
      frmFuncLista.ShowModal;
      frmFuncLista.Free;
end;

procedure TfrmPrincipal.btnProdutosClick(Sender: TObject);
begin
      Application.CreateForm(TfrmProdutoLista, frmProdutoLista);
      frmProdutoLista.ShowModal;
      frmProdutoLista.Free;
end;

procedure TfrmPrincipal.btnConfiguracaoClick(Sender: TObject);
begin
      Application.CreateForm(TfrmConfig, frmConfig);
      frmConfig.ShowModal;
      frmConfig.Free;
end;

procedure TfrmPrincipal.ToolButton17Click(Sender: TObject);
begin
    frmLogin:=TfrmLogin.Create(self);
    frmLogin.ShowModal;
end;

procedure TfrmPrincipal.ToolButton1Click(Sender: TObject);
begin
      Application.CreateForm(TfrmVendaCaixa, frmVendaCaixa);
      frmVendaCaixa.ShowModal;
      frmVendaCaixa.Free;
end;

procedure TfrmPrincipal.btnEstoqueClick(Sender: TObject);
begin
      Application.CreateForm(TfrmAlimentarEstoque, frmAlimentarEstoque);
      frmAlimentarEstoque.ShowModal;
      frmAlimentarEstoque.Free;
end;

procedure TfrmPrincipal.btnClientesClick(Sender: TObject);
begin
      Application.CreateForm(TfrmClienteLista, frmClienteLista);
      frmClienteLista.ShowModal;
      frmClienteLista.Free;
end;

procedure TfrmPrincipal.btnBackupClick(Sender: TObject);
begin
      Application.CreateForm(TfrmBackup, frmBackup);
      frmBackup.ShowModal;
      frmBackup.Free;
end;

procedure TfrmPrincipal.ToolButton8Click(Sender: TObject);
begin
      Application.CreateForm(TfrmComandas, frmComandas);
      frmComandas.ShowModal;
      frmComandas.Free;
end;

procedure TfrmPrincipal.ToolButton9Click(Sender: TObject);
begin
      Application.CreateForm(TfrmCaixa, frmCaixa);
      frmCaixa.ShowModal;
      frmCaixa.Free;
end;

end.
