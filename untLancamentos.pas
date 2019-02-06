unit untLancamentos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Buttons,
  Data.DB;

type
  TfrmLancamentos = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    GroupBox2: TGroupBox;
    RadioButton1: TRadioButton;
    Label2: TLabel;
    RadioButton3: TRadioButton;
    RadioButton4: TRadioButton;
    Panel1: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit2: TEdit;
    Panel3: TPanel;
    btnOK: TBitBtn;
    btnCancelar: TBitBtn;
    procedure btnOKClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmLancamentos: TfrmLancamentos;

implementation

{$R *.dfm}

uses untCaixa, untDM;

procedure TfrmLancamentos.btnCancelarClick(Sender: TObject);
begin
close;
end;

procedure TfrmLancamentos.btnOKClick(Sender: TObject);
var
  myDate : TDateTime;
  myHour, myMin, mySec, myMilli : Word;
begin
      myDate := now;

      DecodeTime(myDate, myHour, myMin, mySec, myMilli);
      if Radiobutton3.Checked = true then
      begin
        if (strtofloat(edit1.Text) > frmcaixa.verifica)  then
        begin
           showmessage('Valor para retirada é maior que o dinheiro disponível em caixa!');
        end
        else
        begin
          DM.adoVenda.Open;
          DM.adoVenda.Insert;
          DM.adoVendaven_cliente.Value := 1;
          DM.adoVendaven_caixa.Value := 1;
          DM.adoVendaven_saida.Value := strtofloat(edit1.Text);
          DM.adoVendaven_total.asstring := '';
          DM.adoVendaven_status.Value := 'SANGRIA';
          DM.adoVendaven_forma_pagamento.Value := 'SANGRIA';
          DM.adoVendaven_data.AsDateTime := now;
          DM.adoVendaven_hora.AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
          DM.adoVendaven_descricao.AsString := edit2.Text;
          dm.adoCaixa.Last;
          DM.adoVendaven_caixaid.Value := dm.adoCaixa.FieldByName('cai_id').Value;
          DM.adoVenda.Post;
          close;
        end;
      end
      else if Radiobutton4.Checked = true then
      begin
          DM.adoVenda.Open;
          DM.adoVenda.Insert;
          DM.adoVendaven_cliente.Value := 1;
          DM.adoVendaven_caixa.Value := 1;
          DM.adoVendaven_total.Value := strtofloat(edit1.Text);
          DM.adoVendaven_saida.asstring := '';
          DM.adoVendaven_status.Value := 'ENTRADA';
          DM.adoVendaven_forma_pagamento.Value := 'ENTRADA';
          DM.adoVendaven_data.AsDateTime := now;
          DM.adoVendaven_hora.AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
          DM.adoVendaven_descricao.AsString := edit2.Text;
          dm.adoCaixa.Last;
          DM.adoVendaven_caixaid.Value := dm.adoCaixa.FieldByName('cai_id').Value;
          DM.adoVenda.Post;
          close;
      end
      else
      begin
      showmessage('Selecione uma opção !!');
      end;
end;

procedure TfrmLancamentos.Edit1Change(Sender: TObject);
begin
     if edit1.Text = '' then
     begin
        btnok.Enabled := false;
     end
     else btnok.Enabled := true;
end;

procedure TfrmLancamentos.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['0'..'9',',', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmLancamentos.FormClose(Sender: TObject; var Action: TCloseAction);
begin
edit2.Clear;
edit1.Clear;
Radiobutton4.Checked := false;
Radiobutton3.Checked := false;
frmcaixa.dsstring.DataSet.Refresh;

frmcaixa.atualizar(sender);
end;

procedure TfrmLancamentos.FormShow(Sender: TObject);
begin
btnok.Enabled := false;

frmcaixa.atualizar(sender);
end;

end.
