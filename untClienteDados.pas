unit untClienteDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask, Data.Win.ADODB;

type
  TfrmClienteDados = class(TForm)
    ds: TDataSource;
    gbdados: TGroupBox;
    lblNome: TLabel;
    lblSexo: TLabel;
    lblEmail: TLabel;
    lblCPF: TLabel;
    lblRG: TLabel;
    lblEndereco: TLabel;
    lblTelefone: TLabel;
    lblAtivo: TLabel;
    lblDataCadastro: TLabel;
    lblInativoDesde: TLabel;
    lblID: TLabel;
    lblDataNascimento: TLabel;
    dbeNome: TDBEdit;
    dbeEmail: TDBEdit;
    dbeRG: TDBEdit;
    dbeEndereco: TDBEdit;
    dbeTelefone: TDBEdit;
    dbeCadastro: TDBEdit;
    dbeInativo: TDBEdit;
    dbeID: TDBEdit;
    dbcAtivo: TDBComboBox;
    dbcSexo: TDBComboBox;
    dbeDNasc: TDBEdit;
    dbeCPF: TDBEdit;
    pnControle: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    lblNumero: TLabel;
    dbeNumero: TDBEdit;
    lblBairro: TLabel;
    dbeBairro: TDBEdit;
    lblCEP: TLabel;
    dbeCEP: TDBEdit;
    lblCidade: TLabel;
    lblEstado: TLabel;
    dbcTipo: TDBComboBox;
    lblTipo: TLabel;
    dbcEstado: TDBComboBox;
    DBLookupComboBoxCidade: TDBLookupComboBox;
    dsCidade: TDataSource;
    dbeCelular: TDBEdit;
    lblCelular: TLabel;
    pnTopo: TPanel;
    Label1: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure dsStateChange(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormActivate(Sender: TObject);
    procedure dbcEstadoExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbcTipoExit(Sender: TObject);
    //procedure DBComboBox2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmClienteDados: TfrmClienteDados;

implementation

{$R *.dfm}

uses untDM, untClienteLista;

procedure TfrmClienteDados.btnSalvarClick(Sender: TObject);
begin
  if DM.adoClientecli_ativo.Value = 'N' then
  begin
    DM.adoClientecli_data_inativo.AsDateTime := now;
  end
  else if DM.adoClientecli_ativo.Value = 'S' then
  begin
    DM.adoClientecli_data_inativo.Clear;
  end;

  if dbcTipo.Text = 'F' then
    begin
      if (dbcSexo.Text = '') then
        begin
          Application.MessageBox('Informe o [Sexo] do Cliente.','Aviso',MB_OK+MB_ICONWARNING);

          dbcSexo.SetFocus;
          Abort;
        end;
    end
  else
  dbeNome.SetFocus;

  if (dbcAtivo.Text = '') then
    begin
      Application.MessageBox('O campo [Ativo] é de preenchimento obrigatório.','Aviso',MB_OK+MB_ICONWARNING);
      dbcAtivo.SetFocus;
      Abort;
    end;

  if (dbeNome.Text = '') then
    begin
      Application.MessageBox('Informe o [Nome/Razão Social] do Cliente.','Aviso',MB_OK+MB_ICONWARNING);

      dbeNome.SetFocus;
      Abort;
    end;

  if (dbeCPF.Text = '') or (dbeCPF.Text = '   .   .   -  ') or
  (dbeCPF.Text = '  .   .   /    -  ') then
    begin
      Application.MessageBox('Informe o [CPF/CNPJ] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeCPF.SetFocus;
      Abort;
    end;

  if (dbeRG.Text = '') then
    begin
      Application.MessageBox('Informe o [RG/IE] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeRG.SetFocus;
      Abort;
    end;

  if (dbeEndereco.Text = '') then
    begin
      Application.MessageBox('Informe o [Endereço] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeEndereco.SetFocus;
      Abort;
    end;

  if (dbeNumero.Text = '') then
    begin
      Application.MessageBox('Informe o [Nº do Endereço] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeNumero.SetFocus;
      Abort;
    end;

  if (dbeBairro.Text = '') then
    begin
      Application.MessageBox('Informe o [Bairro] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeBairro.SetFocus;
      Abort;
    end;

  if (dbeCEP.Text = '') or (dbeCEP.Text = '  .   -   ') then
    begin
      Application.MessageBox('Informe o [CEP] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeCEP.SetFocus;
      Abort;
    end;

  if (dbcEstado.Text = '') then
    begin
      Application.MessageBox('Informe o [Estado] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbcEstado.SetFocus;
      Abort;
    end;

  if (DBLookupComboBoxCidade.Text = '') then
    begin
      Application.MessageBox('Informe a [Cidade] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      DBLookupComboBoxCidade.SetFocus;
      Abort;
    end;

  if (dbeEmail.Text = '') then
    begin
      Application.MessageBox('Informe o [E-mail] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeEmail.SetFocus;
      Abort;
    end;

  if (dbeDNasc.Text = '') or (dbeDNasc.Text = '  /  /    ') then
    begin
      Application.MessageBox('Informe a [Data de Nascimento / Fundação] do Cliente.',
      'Aviso',MB_OK+MB_ICONWARNING);

      dbeDNasc.SetFocus;
      Abort;
    end;

  DM.adoCliente.Post;
end;

procedure TfrmClienteDados.dbcEstadoExit(Sender: TObject);
begin
  dsCidade.DataSet.Close;
  DM.qryCidade.Parameters[0].Value := DM.adoClientecli_estado.Value;
  dsCidade.DataSet.Open;
end;


procedure TfrmClienteDados.dbcTipoExit(Sender: TObject);
begin
  if dbcTipo.Text = 'F' then
    begin
      lblSexo.Visible := True;
      dbcSexo.Visible := True;
      lblCPF.Caption:= 'CPF:';
      lblRG.Caption:= 'RG:';
      lblNome.Caption:= 'Nome:';
      DM.adoClientecli_cpf.EditMask:= '999.999.999-99;1;_';
    end
  else if dbcTipo.Text = 'J' then
    begin
      lblSexo.Visible := False;
      dbcSexo.Visible := False;
      DM.adoClientecli_sexo.Text := '';
      lblCPF.Caption:= 'CNPJ:';
      lblRG.Caption:= 'IE:';
      lblNome.Caption:= 'Razão Social:';
      DM.adoClientecli_cpf.EditMask:= '99.999.999/9999-99;1;_';
      lblDataNascimento.Caption := 'Data de Fundação:';
    end
  else
    begin
      Application.MessageBox('Informe o [Tipo] do Cliente.','Aviso',MB_OK+MB_ICONWARNING);
      dbcTipo.SetFocus;
      abort;
    end;
end;

procedure TfrmClienteDados.btnCancelarClick(Sender: TObject);
begin
  if ds.State in [dsinsert] then
    begin
      self.close;
      ds.DataSet.Cancel;
    end
  else
    begin
      ds.DataSet.Cancel;
    end;
end;

procedure TfrmClienteDados.btnFecharClick(Sender: TObject);
begin
  self.close;
end;

procedure TfrmClienteDados.dsStateChange(Sender: TObject);
begin
      if ds.State in [dsInsert, dsEdit] then
      begin
        btnSalvar.Enabled := true;
        btnCancelar.Enabled := true;
        btnFechar.Enabled := false;
      end
      else begin
        btnSalvar.Enabled := false;
        btnCancelar.Enabled := false;
        btnFechar.Enabled := true;
      end;
end;

procedure TfrmClienteDados.FormActivate(Sender: TObject);
begin
      dsCidade.DataSet.Open;
end;

procedure TfrmClienteDados.FormClose(Sender: TObject; var Action: TCloseAction);
begin
      dsCidade.DataSet.Close;
end;

procedure TfrmClienteDados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;

end;

end.
