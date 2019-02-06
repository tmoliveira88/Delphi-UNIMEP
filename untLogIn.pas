unit untLogIn;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.ExtCtrls, Vcl.Imaging.pngimage;

type
  TfrmLogIn = class(TForm)
    btnEntrar: TButton;
    Image1: TImage;
    edtUsuario: TButtonedEdit;
    EdtSenha: TButtonedEdit;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    procedure btnEntrarClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure EdtSenhaKeyPress(Sender: TObject; var Key: Char);
    procedure edtUsuarioKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    booControle: Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLogIn: TfrmLogIn;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmLogIn.btnEntrarClick(Sender: TObject);
begin
      try
      if DM.qryLogin.Active then
        DM.qryLogin.Close;

        DM.qryLogin.Open;

        if DM.QryLogin.Recordcount > 0 then
        begin
        frmLogin.close;
        booControle := True;
        end
        else
        begin
        ShowMessage('Usuário ou Senha inválidos');
        booControle := false;
        end;
       except
        ShowMessage('Ocorreu um erro ao acessar as informações de login.');
      end;
end;


procedure TfrmLogIn.Button1Click(Sender: TObject);
begin
    Application.Terminate;
end;

procedure TfrmLogIn.EdtSenhaKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
    begin
        btnEntrarClick(Sender);
    end;
end;

procedure TfrmLogIn.edtUsuarioKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
    begin
        btnEntrarClick(Sender);
    end;
end;

procedure TfrmLogIn.FormClose(Sender: TObject; var Action: TCloseAction);
begin
    if booControle then
    begin
    self.Close;
    end
    else
    Application.Terminate;
end;

procedure TfrmLogIn.FormCreate(Sender: TObject);
begin
    BooControle := false;
end;

procedure TfrmLogIn.FormKeyPress(Sender: TObject; var Key: Char);
begin
if key = #13 then
    begin
        btnEntrarClick(Sender);
    end;
end;

end.
