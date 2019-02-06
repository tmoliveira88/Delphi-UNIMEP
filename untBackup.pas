unit untBackup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Shellapi, Buttons, ExtCtrls, Vcl.ComCtrls, Data.Win.ADODB;

type
  TfrmBackup = class(TForm)
    lblMensagem: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ProgressBar1: TProgressBar;
    ADOCommand: TADOCommand;
    restore: TOpenDialog;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure RealizaBackup(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBackup: TfrmBackup;

implementation

{$R *.dfm}

uses untDM;

procedure TfrmBackup.Button1Click(Sender: TObject);
begin
      if not directoryexists('C:\BACKUP\') then
      begin
      CreateDir('C:\BACKUP\');
      RealizaBackup(Sender);
      end
      else
      begin
      RealizaBackup(Sender);
      end;
end;

procedure TfrmBackup.RealizaBackup(Sender: TObject);
var aa,mm,dd, hh, mmm, ss, sss: word;
aux : string;
begin
      ProgressBar1.Position := 0;

      lblMensagem.Caption := 'Aguarde. Efetuando Backup';
      ProgressBar1.Position := 50;
      lblMensagem.Refresh;

      decodedate(date, aa, mm, dd);
      decodetime(time, hh, mmm, ss, sss);
         aux := inttostr(aa) + '-';
         if mm < 10 then
            aux := aux + '0' + inttostr(mm) + '-'
         else
            aux := aux + inttostr(mm);
         if dd < 10 then
            aux := aux + '0' + inttostr(dd) + '-'
         else
            aux := aux + inttostr(dd) + '-';
         if hh < 10 then
            aux := aux + '0'+ inttostr(hh) + '.'
         else
            aux := aux + inttostr(hh) + '.';
         if mmm < 10 then
            aux := aux + '0' + inttostr(mmm)
         else
            aux := aux + inttostr(mmm);
         aux := aux + '.bak';

         with ADOCommand do begin
         ADOCommand.CommandText := 'BACKUP DATABASE SIS_VENDAS TO DISK =''c:\BACKUP\'+aux+''' WITH FORMAT';
         ADOCommand.Execute;
         end;
         lblMensagem.Caption := 'Backup Realizado!';
         ProgressBar1.Position := 100;
end;

procedure TfrmBackup.Button2Click(Sender: TObject);
begin
//
//    restore.InitialDir := 'C:\BACKUP\';
//    if restore.Execute then
//    begin
//              lblmensagem.Caption := 'Restaurando...';
//              lblmensagem.Refresh;
//      DM.adoConexao.Connected := false;
//       with ADOCommand do begin
//        ADOCommand.CommandText := 'Alter Database SIS_VENDAS ' +
//                             'SET SINGLE_USER With ROLLBACK IMMEDIATE ' +
//                              'RESTORE DATABASE SIS_VENDAS FROM DISK = ''c:\BACKUP\'+restore.FileName+''' ' +
//                              'WITH REPLACE';
//         ADOCommand.Execute;
//      end;
//              lblmensagem.Caption := 'Restaurado com sucesso!';
//              lblmensagem.Refresh;
//              ProgressBar1.Position := 100;
//      DM.adoConexao.Connected := true;
//    end;
end;

procedure TfrmBackup.Button3Click(Sender: TObject);
begin
close;
end;

procedure TfrmBackup.FormClose(Sender: TObject; var Action: TCloseAction);
begin
ProgressBar1.Position := 0;
lblMensagem.Caption := 'Selecione uma opção';
end;

procedure TfrmBackup.FormShow(Sender: TObject);
begin
ProgressBar1.Position := 0;
lblMensagem.Caption := 'Selecione uma opção';
end;

end.