unit untFuncDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.DBCtrls, Vcl.Mask;

type
  TfrmFuncDados = class(TForm)
    ds: TDataSource;
    gbdados: TGroupBox;
    pnControle: TPanel;
    btnSalvar: TBitBtn;
    btnCancelar: TBitBtn;
    btnFechar: TBitBtn;
    dbeID: TDBEdit;
    lblID: TLabel;
    lblNome: TLabel;
    dbeNome: TDBEdit;
    dbeUsuario: TDBEdit;
    lblUsuario: TLabel;
    dbeSenha: TDBEdit;
    lblSenha: TLabel;
    lblNivelPermissao: TLabel;
    dbcNivelPermissao: TDBComboBox;
    lblAtivo: TLabel;
    dbcAtivo: TDBComboBox;
    lblInativoDesde: TLabel;
    dbeInativo: TDBEdit;
    dbeCadastro: TDBEdit;
    lblDataCadastro: TLabel;
    pnTopo: TPanel;
    Label1: TLabel;
    procedure btnFecharClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure dsStateChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFuncDados: TfrmFuncDados;

implementation

{$R *.dfm}

uses untDM, untFuncLista;

procedure TfrmFuncDados.btnCancelarClick(Sender: TObject);
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

procedure TfrmFuncDados.btnFecharClick(Sender: TObject);
begin
      self.close;
end;

procedure TfrmFuncDados.btnSalvarClick(Sender: TObject);
begin
  if DM.adoFuncionariofun_ativo.Value = 'N' then
  begin
    DM.adoFuncionariofun_data_inativo.AsDateTime := now;
  end
  else if DM.adoFuncionariofun_ativo.Value = 'S' then
  begin
    DM.adoFuncionariofun_data_inativo.Clear;
  end;

  if (dbcNivelPermissao.Text = '') then
  begin
    Application.MessageBox('Informe o [Nível de Permissão] do Funcionário.','Aviso',MB_OK+MB_ICONWARNING);
    dbcNivelPermissao.SetFocus;
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
    Application.MessageBox('Informe o [Nome] do Funcionário.','Aviso',MB_OK+MB_ICONWARNING);
    dbeNome.SetFocus;
    Abort;
  end;

  if (dbeUsuario.Text = '') then
  begin
    Application.MessageBox('Informe o [Usuário] do Funcionário.','Aviso',MB_OK+MB_ICONWARNING);
    dbeUsuario.SetFocus;
    Abort;
  end;

  if (dbeSenha.Text = '') then
  begin
    Application.MessageBox('Informe a [Senha] do Funcionário.','Aviso',MB_OK+MB_ICONWARNING);
    dbeSenha.SetFocus;
    Abort;
  end;

  DM.adoFuncionario.Post;
end;

procedure TfrmFuncDados.dsStateChange(Sender: TObject);
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

procedure TfrmFuncDados.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
      if key = vk_escape then
      begin
        Self.Close;
      end;

end;

end.
