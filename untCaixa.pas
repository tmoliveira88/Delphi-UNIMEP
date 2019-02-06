unit untCaixa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, System.ImageList, Vcl.ImgList, Vcl.Mask, system.UITypes,
  Vcl.CategoryButtons, Vcl.ComCtrls, frxClass, frxExportBaseDialog, frxExportPDF;

type
  TfrmCaixa = class(TForm)
    btncaixaopenclose: TBitBtn;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Sinicial: TLabel;
    LEntrada: TLabel;
    VDinheiro: TLabel;
    VDebito: TLabel;
    VCredito: TLabel;
    TotalEntradas: TLabel;
    Label19: TLabel;
    TotalSangria: TLabel;
    TotalDinheiro: TLabel;
    TotalTudo: TLabel;
    BitBtn4: TBitBtn;
    Image1: TImage;
    dsVenda: TDataSource;
    dsstring: TDataSource;
    dsCaixa: TDataSource;
    frxReport1: TfrxReport;
    frxPDFExport1: TfrxPDFExport;
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn4Click(Sender: TObject);
    procedure btncaixaopencloseClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
  private
    { Private declarations }
  public
    var verifica,total:real;
    procedure atualizar(Sender: TObject);
    procedure verificar(Sender: TObject);
  end;

var
  frmCaixa: TfrmCaixa;

implementation

{$R *.dfm}

uses untPrincipal, untLancamentos, untItensVenda, untDM, untClienteLista;

procedure TfrmCaixa.atualizar(Sender: TObject);
begin
DM.qryAcrescimos.close;
DM.qryAcrescimos.Open;
DM.qryCDinheiro.close;
DM.qryCDinheiro.open;
DM.qryCDebito.close;
DM.qryCDebito.open;
DM.qryCCredito.close;
DM.qryCCredito.open;
DM.qrySangria.close;
DM.qrySangria.open;
DM.qryTotalCaixas.Close;
DM.qryTotalCaixas.open;
dsstring.DataSet.Close;
dsstring.DataSet.Open;


   DM.AdoCaixa.last;

   Sinicial.Caption := FormatFloat('#,0.00',DM.adoCaixacai_saldo_inicial.AsFloat);

   LEntrada.Caption := FormatFloat('#,0.00',DM.qryAcrescimos.FieldByName('ATOTAL').AsFloat);
   VDinheiro.Caption := FormatFloat('#,0.00',DM.qryCDinheiro.FieldByName('DTOTAL').AsFloat);
   VDebito.Caption :=  FormatFloat('#,0.00',DM.qryCDebito.FieldByName('DDTOTAL').AsFloat);
   VCredito.Caption  :=  FormatFloat('#,0.00',DM.qryCCredito.FieldByName('CTOTAL').AsFloat);
   TotalEntradas.Caption := FormatFloat('#,0.00',(DM.qryAcrescimos.FieldByName('ATOTAL').AsFloat + DM.qryCDinheiro.FieldByName('DTOTAL').AsFloat + DM.qryCDebito.FieldByName('DDTOTAL').AsFloat + DM.qryCCredito.FieldByName('CTOTAL').AsFloat));
   TotalSangria.Caption := FormatFloat('#,0.00',DM.qrySangria.FieldByName('STOTAL').AsFloat);
   total := (DM.qryAcrescimos.FieldByName('ATOTAL').AsFloat + DM.adoCaixacai_saldo_inicial.AsFloat + DM.qryCDinheiro.FieldByName('DTOTAL').AsFloat - DM.qrySangria.FieldByName('STOTAL').AsFloat);
   TotalDinheiro.Caption := FormatFloat('#,0.00',total);
   if total < 0 then
   begin
      TotalTudo.Caption := FormatFloat('#,0.00',(DM.qryCDebito.FieldByName('DDTOTAL').AsFloat + DM.qryCCredito.FieldByName('CTOTAL').AsFloat));
   end
   else if total > 0 then
   begin
     TotalTudo.Caption := FormatFloat('#,0.00',((DM.qryCDebito.FieldByName('DDTOTAL').AsFloat + DM.qryCCredito.FieldByName('CTOTAL').AsFloat) + total));
   end
   else
   begin
        totaltudo.Caption := FormatFloat('#,0.00',(DM.qryTotalCaixas.FieldByName('SOMA').AsFloat - DM.qrySangria.FieldByName('STOTAL').AsFloat));
   end;

   verifica := (DM.qryAcrescimos.FieldByName('ATOTAL').asfloat + DM.qryCDinheiro.FieldByName('DTOTAL').asfloat + DM.adoCaixacai_saldo_inicial.AsFloat - DM.qrySangria.FieldByName('STOTAL').AsFloat);
end;

procedure TfrmCaixa.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TfrmCaixa.BitBtn2Click(Sender: TObject);
var
  myDate : TDateTime;
  myHour, myMin, mySec, myMilli : Word;
begin
      myDate := now;

      DM.AdoCaixa.last;

      DM.qryVerificaCmd.Parameters[0].Value :=  DM.adoCaixacai_id.Value;
   DM.qryVerificaCmd.Open;
   if DM.qryVerificaCmd.IsEmpty then
   begin

   DecodeTime(myDate, myHour, myMin, mySec, myMilli);
   DM.AdoCaixa.last;
   if DM.AdoCaixacai_data_fechamento.value = '' then
   begin
   if MessageDlg('Tem certeza que deseja fechar o caixa ?',mtConfirmation, [mbYes, mbNo], 0, mbYes) = mrYes then
   begin
   DM.adoCaixa.edit;
   DM.adoCaixacai_saldo_total.AsFloat := DM.qryTotalCaixas.FieldByName('SOMA').AsFloat - DM.qrySangria.FieldByName('STOTAL').AsFloat;
   DM.adoCaixacai_data_fechamento.AsDateTime := now;
   DM.adoCaixacai_hora_fechamento.AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
   DM.adoCaixa.Post;
   showmessage('Caixa fechado com sucesso!');
   verificar(sender);
   end;
   end;
   end
   else
   begin
     showmessage('Você precisa encerrar as comandas antes de fechar o caixa!');
   end;
      DM.qryVerificaCmd.Close;
   dsstring.DataSet.Refresh;
end;

procedure TfrmCaixa.BitBtn3Click(Sender: TObject);
begin
      Application.CreateForm(TfrmLancamentos, frmLancamentos);
      frmLancamentos.ShowModal;
      frmLancamentos.Free;
end;

procedure TfrmCaixa.BitBtn4Click(Sender: TObject);
var
  Result: TBitmap;
begin
  Result := TBitmap.Create;
  try
    Result.Width := Self.Panel4.ClientWidth;
    Result.Height := Self.Panel4.ClientHeight;
    Result.Canvas.Brush := Self.Panel4.Brush;
    Result.Canvas.FillRect(Self.Panel4.ClientRect);
    Result.Canvas.Lock;
    Self.Panel4.PaintTo(Result.Canvas.Handle, 0, 0);
    Result.Canvas.Unlock;
    Result.SaveToFile('image1.bmp');
  finally
    Result.Free;
  end;

  with frxReport1 do

    begin
    TfrxPictureView(frxReport1.FindObject('Image1')).Picture.LoadFromFile('image1.bmp');
    ShowReport;
    end;

end;

procedure TfrmCaixa.btncaixaopencloseClick(Sender: TObject);
var
  myDate : TDateTime;
  myHour, myMin, mySec, myMilli : Word;
begin

      myDate := now;

      DecodeTime(myDate, myHour, myMin, mySec, myMilli);
   DM.AdoCaixa.last;
  if DM.AdoCaixa.IsEmpty then
  begin
   DM.adoCaixa.Insert;
   DM.adoCaixacai_saldo_inicial.AsString := edit1.Text;
   DM.adoCaixacai_data_abertura.AsDateTime := now;
   DM.adoCaixacai_hora_abertura.AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
   DM.adoCaixa.Post;
   Sinicial.Caption := FormatFloat('#,0.00',DM.adoCaixacai_saldo_inicial.AsFloat);

      with dsvenda.DataSet do begin
        Open;
        append;
        fieldbyname('ven_cliente').Value := 1;
        fieldbyname('ven_caixa').Value := frmprincipal.iddocaixa;
        fieldbyname('ven_status').Value := 'INICIAL';
        fieldbyname('ven_descricao').Value := 'SALDO INICIAL';
        fieldbyname('ven_data').AsDateTime := now;
        fieldbyname('ven_hora').AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
        fieldbyname('ven_pago').value := strtofloat(edit1.Text);
        dm.adoCaixa.Last;
        fieldbyname('ven_caixaid').Value := dm.adoCaixa.FieldByName('cai_id').Value;
        verificar(sender);
        post;
      end;
      dsstring.DataSet.Close;
      dsstring.DataSet.Open;
  end
   else if DM.AdoCaixacai_data_fechamento.value <> '' then
   begin
   DM.adoCaixa.Insert;
   DM.adoCaixacai_saldo_inicial.AsString := edit1.Text;
   DM.adoCaixacai_data_abertura.AsDateTime := now;
   DM.adoCaixacai_hora_abertura.AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
   DM.adoCaixa.Post;
   Sinicial.Caption := FormatFloat('#,0.00',DM.adoCaixacai_saldo_inicial.AsFloat);

      with dsvenda.DataSet do begin
        Open;
        append;
        fieldbyname('ven_cliente').Value := 1;
        fieldbyname('ven_caixa').Value := frmprincipal.iddocaixa;
        fieldbyname('ven_status').Value := 'INICIAL';
        fieldbyname('ven_descricao').Value := 'SALDO INICIAL';
        fieldbyname('ven_data').AsDateTime := now;
        fieldbyname('ven_hora').AsString := (inttostr(myHour)+':'+inttostr(myMin)+':'+inttostr(mySec));
        fieldbyname('ven_pago').value := strtofloat(edit1.Text);
        dm.adoCaixa.Last;
        fieldbyname('ven_caixaid').Value := dm.adoCaixa.FieldByName('cai_id').Value;
        verificar(sender);
        post;
      end;
      dsstring.DataSet.Close;
      dsstring.DataSet.Open;
   end;

end;

procedure TfrmCaixa.DBGrid1CellClick(Column: TColumn);
begin
      DM.qryRelItemVenda.Parameters[0].Value := DM.qryCaixaFinalven_id.value;
end;

procedure TfrmCaixa.DBGrid1DblClick(Sender: TObject);
begin
    if (DM.qryCaixaFinalven_status.Value = 'ENTRADA')   then
    begin
      showmessage('Este item não pode ser visualizado pois é um Acréscimo!');
    end
    else if (DM.qryCaixaFinalven_status.Value = 'SANGRIA') then
    begin
      showmessage('Este item não pode ser visualizado pois é uma Sangria!');
    end
    else if (DM.qryCaixaFinalven_status.Value = 'INICIAL') then
    begin
      showmessage('Este item não pode ser visualizado pois é um Saldo Inicial!');
    end
    else if dsstring.DataSet.IsEmpty then
    begin
       showmessage('Registro vazio');
    end
    else
    begin
      Application.CreateForm(TfrmItensVenda, frmItensVenda);
      frmItensVenda.ShowModal;
      frmItensVenda.Free;
    end;
end;

procedure Tfrmcaixa.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
     if not (CharInSet(key,['0'..'9',',', char(vk_back)])) then
     begin
          key := #0;
     end;
end;

procedure TfrmCaixa.FormClose(Sender: TObject; var Action: TCloseAction);
begin
dscaixa.DataSet.Close;
DM.qryCaixaFinal.close;
dsstring.DataSet.close;
dsvenda.DataSet.close;

DM.qryAcrescimos.close;
DM.qryCDinheiro.close;
DM.qryCDebito.close;
DM.qryCCREDITO.close;
DM.qrySangria.close;
DM.qryTotalCaixas.close;
end;

procedure TfrmCaixa.FormShow(Sender: TObject);
begin
dscaixa.DataSet.Open;
DM.qryCaixaFinal.Open;
dsstring.DataSet.Open;
dsstring.DataSet.Refresh;
dsvenda.DataSet.Open;

DM.qryAcrescimos.Open;
DM.qryCDinheiro.Open;
DM.qryCDebito.open;
DM.qryCCREDITO.open;
DM.qrySangria.Open;
DM.qryTotalCaixas.Open;

verificar(sender);
end;

procedure TfrmCaixa.verificar(Sender: TObject);
begin
   DM.AdoCaixa.last;
   if DM.adoCaixa.IsEmpty then
   begin
        panel1.Enabled := true;

        frmprincipal.ToolButton1.Enabled := false;
        frmprincipal.ToolButton8.enabled := false;
        bitbtn2.Enabled := false;
        BitBtn3.Enabled := false;
        dbgrid1.Visible := false;

        panel2.Caption := 'CAIXA FECHADO';
        panel2.Font.Color := clRed;

   edit1.Text := ',00';
   Sinicial.Caption := '';
   LEntrada.Caption := '';
   VDinheiro.Caption := '';
   VDebito.Caption := '';
   VCredito.Caption  := '';
   TotalEntradas.Caption := '';
   TotalSangria.Caption := '';
   TotalDinheiro.Caption := '';
   totaltudo.Caption := '';
   end
   else if DM.AdoCaixacai_data_fechamento.value = '' then
   begin
        frmprincipal.ToolButton1.Enabled := true;
        frmprincipal.ToolButton8.enabled := true;
        bitbtn2.Enabled := true;
        BitBtn3.Enabled := true;
        dbgrid1.Visible := true;

        panel1.Enabled := false;

        panel2.Caption := 'CAIXA ABERTO';
        panel2.Font.Color := clLime;

        atualizar(sender);
   end
   else
   begin
        panel1.Enabled := true;

        frmprincipal.ToolButton1.Enabled := false;
        frmprincipal.ToolButton8.enabled := false;
        bitbtn2.Enabled := false;
        BitBtn3.Enabled := false;
        dbgrid1.Visible := false;

        panel2.Caption := 'CAIXA FECHADO';
        panel2.Font.Color := clRed;

   edit1.Text := ',00';
   Sinicial.Caption := '';
   LEntrada.Caption := '';
   VDinheiro.Caption := '';
   VDebito.Caption := '';
   VCredito.Caption  := '';
   TotalEntradas.Caption := '';
   TotalSangria.Caption := '';
   TotalDinheiro.Caption := '';
   totaltudo.Caption := '';
   end;
end;

end.
