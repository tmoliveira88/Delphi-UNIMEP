unit untForDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmForDados = class(TForm)
    ds: TDataSource;
    pnControle: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    dbcAtivo: TDBComboBox;
    dbcTipo: TDBComboBox;
    dbcEstado: TDBComboBox;
    dblookupCidades: TDBLookupComboBox;
    dsCidade: TDataSource;
    Panel1: TPanel;
    gbdados: TGroupBox;
    lblNome: TLabel;
    lblEmail: TLabel;
    lblCPF: TLabel;
    lblRG: TLabel;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    lblAtivo: TLabel;
    lblDataCadastro: TLabel;
    lblInativoDesde: TLabel;
    lblID: TLabel;
    lblNumero: TLabel;
    lblBairro: TLabel;
    lblCEP: TLabel;
    lblCidade: TLabel;
    lblEstado: TLabel;
    lblTipo: TLabel;
    lblCelular: TLabel;
    dbeNome: TDBEdit;
    dbeEmail: TDBEdit;
    dbeRG: TDBEdit;
    dbeEndereco: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeCadastro: TDBEdit;
    dbeInativo: TDBEdit;
    dbeID: TDBEdit;
    dbeCPF: TDBEdit;
    dbeNumero: TDBEdit;
    dbeBairro: TDBEdit;
    dbeCEP: TDBEdit;
    dbeCelular: TDBEdit;
    Label2: TLabel;
    lblNomeFantasia: TLabel;
    dbeNomeFantasia: TDBEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbcEstadoExit(Sender: TObject);
    procedure dbcTipoExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmForDados: TfrmForDados;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmForDados.btnCancelarClick(Sender: TObject);
begin
      ds.DataSet.Cancel;
      close;
end;

procedure TfrmForDados.btnFecharClick(Sender: TObject);
begin
      self.close;
end;

procedure TfrmForDados.btnSalvarClick(Sender: TObject);
begin
  if DM.adoFornecedoresfor_ativo.Value = 'N' then
  begin
    DM.adoFornecedoresfor_data_inativo.AsDateTime := now;
  end
  else if DM.adoFornecedoresfor_ativo.Value = 'S' then
  begin
    DM.adoFornecedoresfor_data_inativo.Clear;
  end;

  if (dbcTipo.Text = '') then
  begin
    Application.MessageBox('Informe o [Tipo] do Fornecedor.','Aviso',MB_OK+MB_ICONWARNING);

    dbcTipo.SetFocus;
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
    Application.MessageBox('Informe o [Nome/Razão Social] do Fornecedor.','Aviso',MB_OK+MB_ICONWARNING);

    dbeNome.SetFocus;
    Abort;
  end;

  if (dbeCPF.Text = '') or (dbeCPF.Text = '   .   .   -  ') or
  (dbeCPF.Text = '  .   .   /    -  ') then
  begin
    Application.MessageBox('Informe o [CPF/CNPJ] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeCPF.SetFocus;
    Abort;
  end;


  if (dbeRG.Text = '') then
  begin
    Application.MessageBox('Informe o [RG/IE] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeRG.SetFocus;
    Abort;
  end;

  if (dbeEndereco.Text = '') then
  begin
    Application.MessageBox('Informe o [Endereço] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeEndereco.SetFocus;
    Abort;
  end;

  if (dbeNumero.Text = '') then
  begin
    Application.MessageBox('Informe o [Nº do Endereço] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeNumero.SetFocus;
    Abort;
  end;

  if (dbeBairro.Text = '') then
  begin
    Application.MessageBox('Informe o [Bairro] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeBairro.SetFocus;
    Abort;
  end;

  if (dbeCEP.Text = '') or (dbeCEP.Text = '  .   -   ') then
  begin
    Application.MessageBox('Informe o [CEP] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeCEP.SetFocus;
    Abort;
  end;

  if (dbcEstado.Text = '') then
  begin
    Application.MessageBox('Informe o [Estado] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbcEstado.SetFocus;
    Abort;
  end;

  if (dblookupCidades.Text = '') then
  begin
    Application.MessageBox('Informe a [Cidade] do Fornecedor.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dblookupCidades.SetFocus;
    Abort;
  end;

  if (dbeEmail.Text = '') then
  begin
    Application.MessageBox('Informe o [E-mail] do Cliente.',
    'Aviso',MB_OK+MB_ICONWARNING);

    dbeEmail.SetFocus;
    Abort;
  end;

  DM.adoFornecedores.Post;
end;

procedure TfrmForDados.dbcEstadoExit(Sender: TObject);
begin
  dsCidade.DataSet.Close;
  DM.qryCidade.Parameters[0].Value := DM.adoFornecedoresfor_estado.Value;
  dsCidade.DataSet.Open;
end;

procedure TfrmForDados.dbcTipoExit(Sender: TObject);
begin
  if dbcTipo.Text = 'F' then
    begin
      lblCPF.Caption:= 'CPF:';
      lblRG.Caption:= 'RG:';
      lblNome.Caption:= 'Nome:';
      DM.adoFornecedoresfor_cpf_cnpj.EditMask:= '999.999.999-99;1;_';
    end
  else if dbcTipo.Text = 'J' then
    begin
      lblCPF.Caption:= 'CNPJ:';
      lblRG.Caption:= 'IE:';
      lblNome.Caption:= 'Razão Social:';
      DM.adoFornecedoresfor_cpf_cnpj.EditMask:= '99.999.999/9999-99;1;_';
    end
  else
    begin
      Application.MessageBox('Informe o [Tipo] do Fornecedor.','Aviso',MB_OK+MB_ICONWARNING);
      dbcTipo.SetFocus;
      abort;
    end;
end;

procedure TfrmForDados.dsStateChange(Sender: TObject);
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

procedure TfrmForDados.FormActivate(Sender: TObject);
begin
  dsCidade.DataSet.Open;
end;

procedure TfrmForDados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;

end;

end.
