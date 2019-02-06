unit untConfig;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, jpeg, Vcl.ExtDlgs;

type
  TfrmConfig = class(TForm)
    ds: TDataSource;
    pnControle: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    gbdados: TGroupBox;
    lblNomeFantasia: TLabel;
    lblRazaoSocial: TLabel;
    lblCNPJ: TLabel;
    lblTelefone: TLabel;
    lblEndereco: TLabel;
    lblNEndereco: TLabel;
    lblBairro: TLabel;
    lblCidade: TLabel;
    lblCEP: TLabel;
    lblEstado: TLabel;
    dbeNomeFantasia: TDBEdit;
    dbeRazaoSocial: TDBEdit;
    dbeCNPJ: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeEndereco: TDBEdit;
    dbeNumero: TDBEdit;
    dbeBairro: TDBEdit;
    dbeCEP: TDBEdit;
    lblCelular: TLabel;
    dbeCelular: TDBEdit;
    lblSite: TLabel;
    dbeSite: TDBEdit;
    dbcEstado: TDBComboBox;
    dblookupCidade: TDBLookupComboBox;
    dsCidade: TDataSource;
    lblEmail: TLabel;
    dbeEmail: TDBEdit;
    label25: TLabel;
    dbeIE: TDBEdit;
    Panel1: TPanel;
    Label13: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure dbcEstadoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfig: TfrmConfig;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmConfig.btnCancelarClick(Sender: TObject);
begin
      ds.DataSet.Cancel;
end;

procedure TfrmConfig.btnFecharClick(Sender: TObject);
begin
      self.close;
end;

procedure TfrmConfig.btnSalvarClick(Sender: TObject);
begin
    if (dbeRazaoSocial.Text = '') then
    begin
      Application.MessageBox('Informe a [Razão Social] da Empresa.','Aviso',MB_OK+MB_ICONWARNING);
      dbeRazaoSocial.SetFocus;
      Abort;
    end;

  if (dbeNomeFantasia.Text = '') then
    begin
      Application.MessageBox('Informe o [Nome Fantasia] da Empresa.','Aviso',MB_OK+MB_ICONWARNING);
      dbeNomeFantasia.SetFocus;
      Abort;
    end;

  if (dbeCNPJ.Text = '') or (dbeCNPJ.Text = '  .   .   /    -  ') then
    begin
      Application.MessageBox('Informe o [CNPJ] da Empresa.','Aviso',MB_OK+MB_ICONWARNING);
      dbeCNPJ.SetFocus;
      Abort;
    end;

  if (dbeIE.Text = '') then
    begin
      Application.MessageBox('Informe o [Nome Fantasia] da Empresa.','Aviso',MB_OK+MB_ICONWARNING);
      dbeNomeFantasia.SetFocus;
      Abort;
    end;

  if (dbeEndereco.Text = '') then
    begin
      Application.MessageBox('Informe o [Endereço] da Empresa.',
      'Aviso',MB_OK+MB_ICONWARNING);
      dbeEndereco.SetFocus;
      Abort;
    end;

  if (dbeNumero.Text = '') then
    begin
      Application.MessageBox('Informe o [Nº do Endereço] da Empresa.',
      'Aviso',MB_OK+MB_ICONWARNING);
      dbeNumero.SetFocus;
      Abort;
    end;

  if (dbeBairro.Text = '') then
    begin
      Application.MessageBox('Informe o [Bairro] da Empresa.',
      'Aviso',MB_OK+MB_ICONWARNING);
      dbeBairro.SetFocus;
      Abort;
    end;

  if (dbeCEP.Text = '') or (dbeCEP.Text = '  .   -   ') then
    begin
      Application.MessageBox('Informe o [CEP] da Empresa.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeCEP.SetFocus;
      Abort;
    end;

  if (dbcEstado.Text = '') then
    begin
      Application.MessageBox('Informe o [Estado] da Empresa.',
      'Aviso',MB_OK+MB_ICONWARNING);
      dbcEstado.SetFocus;
      Abort;
    end;

  if (dblookupCidade.Text = '') then
    begin
      Application.MessageBox('Informe a [Cidade] da Empresa.',
      'Aviso',MB_OK+MB_ICONWARNING);
      dblookupCidade.SetFocus;
      Abort;
    end;



      ds.DataSet.Post;
end;

procedure TfrmConfig.dbcEstadoExit(Sender: TObject);
begin
  dsCidade.DataSet.Close;
  DM.qryCidade.Parameters[0].Value := DM.AdoConfigconf_estado.Value;
  dsCidade.DataSet.Open;
end;

procedure TfrmConfig.dsStateChange(Sender: TObject);
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

procedure TfrmConfig.FormActivate(Sender: TObject);
begin
  dsCidade.DataSet.Open;
end;

procedure TfrmConfig.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;

end;

procedure TfrmConfig.FormShow(Sender: TObject);
begin
ds.DataSet.Open;
end;

end.
