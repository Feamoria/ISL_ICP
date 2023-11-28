unit ISL;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Data.DB,
  ZAbstractRODataset, ZDataset, ZAbstractConnection, ZConnection, JvExMask,
  JvToolEdit, JvDBLookup, JvDBLookupComboEdit, JvExStdCtrls, JvCombobox,
  JvDBSearchComboBox, Clipbrd, ZAbstractDataset, VCLTee.TeEngine,
  VCLTee.TeeFunci, VCLTee.Series, VCLTee.TeeProcs, VCLTee.Chart, VCLTee.DBChart,
  Vcl.ComCtrls, VclTee.TeeGDIPlus;

type
  TMainFM = class(TForm)
    BTN_EXIT: TBitBtn;
    BTN_PM: TBitBtn;
    RadioGroup_1: TRadioGroup;
    E_OBR: TEdit;
    E_RR: TEdit;
    E_Res1: TEdit;
    E_Res2: TEdit;
    E_RR2: TEdit;
    Label_1: TLabel;
    E_DOb: TEdit;
    E_Vx: TEdit;
    Label_11: TLabel;
    E_Va: TEdit;
    Label_12: TLabel;
    BTN_clicb1: TBitBtn;
    BTN_clicb2: TBitBtn;
    Label_2: TLabel;
    Label_3: TLabel;
    Label_4: TLabel;
    ZConnection1: TZConnection;
    DS_1: TDataSource;
    zQ_1: TZQuery;
    ComboBox_1: TComboBox;
    DBChart_1: TDBChart;
    fstlnsrsSeries1: TFastLineSeries;
    zQ_2: TZQuery;
    DS_2: TDataSource;
    ComboBox_2: TComboBox;
    DTP_1: TDateTimePicker;
    Timer_1: TTimer;
    Series1: TFastLineSeries;
    Series2: TFastLineSeries;
    DTP_2: TDateTimePicker;
    Panel1: TPanel;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    stat1: TStatusBar;
    CheckBox_1: TCheckBox;
    ComboBox_EL: TComboBox;
    procedure BTN_EXITClick(Sender: TObject);
    procedure BTN_PMClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure E_OBRChange(Sender: TObject);
    procedure BTN_clicb1Click(Sender: TObject);
    procedure BTN_clicb2Click(Sender: TObject);
    procedure ComboBox_2Change(Sender: TObject);
    procedure Timer_1Timer(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ScrinW: Integer;
    ScrinH: Integer;
  end;

var
  MainFM: TMainFM;
  sql_ARG: string;

implementation

uses
  OP_Control, u_log;
{$R *.dfm}

function MyVersion(Files: string): string; stdcall;
var
  Buffer: string;
  fInfoSize: DWORD;

  function InitVersion: boolean;
  var
    FilenamePointer: PChar;
  begin
    Result := True;
    FilenamePointer := PChar(Files);
    fInfoSize := GetFileVersionInfoSize(FilenamePointer, fInfoSize);
    if fInfoSize > 0 then
    begin
      SetLength(Buffer, fInfoSize);
      if not GetFileVersionInfo(FilenamePointer, 0, fInfoSize, PChar(Buffer)) then
      begin
        Result := False;
      end;
    end; //if
  end; //InitVersion

  function GetVersion(whatToGet: string): string;
  var
    tmpVersion: string;
    Len, Len2: DWORD;
    Value: PChar;
    temp: PLongInt;
    tempStr: string;
  begin
    Result := '';
    if fInfoSize > 0 then
    begin
      SetLength(tmpVersion, 200);
      Value := @tmpVersion;
      VerQueryValue(PChar(Buffer), '\VarFileInfo\Translation', Pointer(temp), Len2);
      tempStr := Format('%s%.4x%.4x\%s%s', ['\StringFileInfo\', LoWord(temp^), HiWord(temp^), whatToGet, #0]);
      if VerQueryValue(PChar(Buffer), PChar(tempStr), Pointer(Value), Len) then
        Result := Value;
    end; // if
  end; //getversion



begin
  Buffer := '';
  try
    InitVersion;
    result := GetVersion('FileVersion');
  except
    Result := '';
  end;
end;

procedure CopyStringToClipboard(const Value: string);
const
  RusLocale = (SUBLANG_DEFAULT shl $A) or LANG_RUSSIAN;
var
  hMem: THandle;
  pData: Pointer;
begin
  Clipboard.Open;
  try
    Clipboard.AsText := Value;
    hMem := GlobalAlloc(GMEM_MOVEABLE, SizeOf(DWORD));
    try
      pData := GlobalLock(hMem);
      try
        DWORD(pData^) := RusLocale;
      finally
        GlobalUnlock(hMem);
      end;
      Clipboard.SetAsHandle(CF_LOCALE, hMem);
    finally
      GlobalFree(hMem);
    end;
  finally
    Clipboard.Close;
  end;

end;

procedure TMainFM.BTN_clicb1Click(Sender: TObject);
begin
  Clipboard.Open;
  Clipboard.SetTextBuf(PChar(E_Res1.Text));
  Clipboard.Close;
end;

procedure TMainFM.BTN_clicb2Click(Sender: TObject);
begin
  Clipboard.Open;
  Clipboard.SetTextBuf(PChar(E_Res2.Text));
  Clipboard.Close;
end;

procedure TMainFM.BTN_EXITClick(Sender: TObject);
begin
  MainFM.Close;
end;

procedure TMainFM.BTN_PMClick(Sender: TObject);
begin
  if BTN_PM.Tag = 0 then
  begin
    MainFM.Left := MainFM.Left - MainFM.Width + 24;
    BTN_PM.Tag := 1;
    BTN_PM.Caption := '>';
  end
  else
  begin
    MainFM.Left := ScrinW - 24;
    BTN_PM.Tag := 0;
    BTN_PM.Caption := '<';
  end;
end;

procedure Ar_SQL();
begin
  with MainFM do
  begin
    sql_ARG := 'SELECT `DateTime` as `Time`, ';
    if (CheckBox_1.Checked) then
      sql_ARG := sql_ARG + ' `RawInt`, '
    else
      sql_ARG := sql_ARG + ' AVG(`RawInt`) as RawInt , ';
    sql_ARG := sql_ARG + ' `isl`.`Name`  FROM lims.exp_date,lims.EXP,lims.isl ';
    sql_ARG := sql_ARG + ' where Element = ''' + ComboBox_EL.Text + '''';
    sql_ARG := sql_ARG + ' and (exp_date.id_exp = EXP.id_EXP) and (isl.id_isl = EXP.id_isl)  ';
    if CheckBox_1.Checked then
      sql_ARG := sql_ARG + ' and (`EXP`.`DateTime` like ''' + FormatDateTime('yyyy-MM-dd', DTP_1.Date) + '%'') '
    else
      sql_ARG := sql_ARG + ' and (YEAR(`EXP`.`DateTime`) = YEAR(NOW())) ';
    sql_ARG := sql_ARG + 'and (`Instrument` = ''' + ComboBox_2.Text + ''') and (`origin_isl` = ''Measured'') and (`info_isl` != ''Recalc'') ';
    if not (CheckBox_1.Checked) then
      sql_ARG := sql_ARG + ' GROUP BY DATE(DateTime) ';
    sql_ARG := sql_ARG + ' order by `EXP`.`DateTime` ';
  end;
 // ShowMessage(sql_ARG);
end;

procedure C_sql();
begin
  with MainFM do
  begin
    sql_ARG := ' SELECT `DateTime` as `Time`,exp_date.RawInt,`isl`.`Name` from isl,EXP,exp_date ';
    sql_ARG := sql_ARG + ' where (`isl`.`name` = ''0'' or `isl`.`name` = ''00'' or `isl`.`name` = ''..''or `isl`.`name` like ''% ◊–%'')';
    sql_ARG := sql_ARG + ' AND isl.id_isl = EXP.id_isl';
    sql_ARG := sql_ARG + ' AND EXP.id_EXP = exp_date.id_exp ';
    if CheckBox_1.Checked then
      sql_ARG := sql_ARG + 'and (`EXP`.`DateTime` like ''' + FormatDateTime('yyyy-MM-dd', DTP_1.Date) + '%'') ';
    sql_ARG := sql_ARG + ' and exp_date.ElementP = ''C 193.091'' ';
    sql_ARG := sql_ARG + ' and isl.origin_isl = ''Measured'' ';
    sql_ARG := sql_ARG + ' ORDER by isl.Date ';
  end;
end;

procedure TMainFM.ComboBox_2Change(Sender: TObject);
begin
  //ShowMessage(IntToStr(ComboBox_2.ItemIndex));
  if ComboBox_2.ItemIndex = 2 then
    C_sql()
  else
    Ar_SQL();
  Timer_1Timer(Timer_1);
  //if not(CheckBox_1.Checked) then
        Timer_1.Enabled:=(CheckBox_1.Checked)


end;

procedure loadCB();
begin
  with MainFM do
  begin
    zQ_1.First;
    ComboBox_1.Clear;
    repeat
      ComboBox_1.Items.Add(zQ_1.FieldByName('Name').AsString);
      zQ_1.Next;
    until zQ_1.Eof;
  end;
end;

procedure construct(Sender: TObject);
var
  RR: string;
begin
  with MainFM do
  begin
   // Label_2.Visible := False;
    if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
    begin
      Label_3.Visible := False;
      Label_2.Caption := 'Œ·‡ÁÂˆ';
      Label_4.Visible := False;
      E_RR.Visible := False;
      E_RR2.Visible := False;
      Label_1.Visible := False;
      Label_11.Visible := False;
      Label_12.Visible := False;
      E_DOb.Visible := False;
      E_Vx.Visible := False;
      E_Va.Visible := False;
      ComboBox_1.Visible := False;
      zQ_1.Active := False;
      E_Res2.Visible := False;
      BTN_clicb2.Visible := False;
      ComboBox_1.Left := E_OBR.Left;
      ComboBox_1.Top := E_OBR.Top;
     // Label_5.Visible := False;
      DTP_2.Visible := False;
    end;
    RR := '';
   // ShowMessage(Sender.ClassName + '- ' + Sender.ToString);
    case RadioGroup_1.ItemIndex of
      0:
        begin   // ŒÕ“–ŒÀ‹ œ–¿¬»À‹ÕŒ—“»
          if E_RR.Text <> '' then
            RR := ' R=' + trim(E_RR.Text);
          E_Res1.Text := ' œ ' + trim(ComboBox_1.Text) + RR;
          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=1 order by `Name`';
          zQ_1.Active := True;
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            loadCB();
            ComboBox_1.Visible := True;
            E_RR.Visible := True;
            Label_3.Visible := True;
          end;
        end;
      1:
        begin  // ŒÕ“–ŒÀ‹ —“¿¡»À‹ÕŒ—“»
          E_Res1.Text := ' — ' + trim(ComboBox_1.Text);
          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=2 order by `Name`';
          zQ_1.Active := True;
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            loadCB();
            ComboBox_1.Visible := True;
          end;
        end;
      2:
        begin  // ŒÕ“–ŒÀ‹ ’ÓÎÓÒÚÓ‚Ó
          E_Res1.Text := ' œ ıÓÎ '; //+ trim(ComboBox_1.Text);
//          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=2 order by `Name`';
//          zQ_1.Active := True;
//          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
//          begin
//            loadCB();
//            ComboBox_1.Visible := True;
//          end;
        end;
      3:
        begin   // —√‘
          E_Res1.Text := ' —√‘ ' + trim(ComboBox_1.Text);
          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=2 order by `Name`';
          zQ_1.Active := True;
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            loadCB();
            ComboBox_1.Visible := True;
          end;
        end;
      4:
        begin  // —’œ
          E_Res1.Text := ' —’œ ' + trim(ComboBox_1.Text);
          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=2 order by `Name`';
          zQ_1.Active := True;
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            loadCB();
            ComboBox_1.Visible := True;
          end;
        end;
      5:
        begin  // ŒÕ“–ŒÀ‹ ¬Œ—œ–Œ»«¬Œƒ»ÃŒ—“»
          E_Res1.Text := ' ¬œ ' + trim(E_OBR.Text);
          E_Res2.Text := ' ¬œ ' + trim(E_OBR.Text) + '*';
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            E_Res2.Visible := True;
            BTN_clicb2.Visible := True;
          end;
        end;
      6:
        begin  // “ — »—œŒÀ‹«Œ¬¿Õ»≈Ã –¿«¡¿¬À≈Õ»ﬂ
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            E_RR.Visible := True;
            E_RR2.Visible := True;
            Label_3.Visible := True;
            Label_4.Visible := True;
            E_Res2.Visible := True;
            BTN_clicb2.Visible := True;
          end;
          E_Res1.Text := ' “–-’ ' + trim(E_OBR.Text) + ' R' + trim(E_RR.Text);
          E_Res2.Text := ' “–-” ' + trim(E_OBR.Text) + ' R' + trim(E_RR2.Text);
        end;
      7:
        begin  // “ — »—œŒÀ‹«Œ¬¿Õ»≈Ã ƒŒ¡¿¬Œ 

          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=2 order by `Name`';
          zQ_1.Active := True;
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            loadCB();
            ComboBox_1.Visible := True;
            E_DOb.Visible := false;
            ComboBox_1.Left := E_DOb.Left;
            ComboBox_1.Top := E_DOb.Top;
            Label_1.Visible := True;
            Label_11.Visible := True;
            Label_12.Visible := True;
            //E_DOb.Visible := True;
            E_Vx.Visible := True;
            E_Va.Visible := True;
            E_Res2.Visible := True;
            BTN_clicb2.Visible := True;
          end;
          E_Res1.Text := ' “ƒ-’ ' + trim(E_OBR.Text); // + ' R' + trim(E_RR.Text);
          E_Res2.Text := ' “ƒ-” ' + trim(E_OBR.Text) + '+‰(Vx=' + trim(E_Vx.Text) + ' Va=' + trim(E_Va.Text) + ' AC=' + trim(ComboBox_1.Text) + ')';
        end;
      8:
        begin  // “ À»—“ ¡≈–®«€
          zQ_1.SQL.Text := ' SELECT `Name` FROM `obraz_KP` where type=3 order by `Name`';
          zQ_1.Active := True;
          if (Sender.ToString = 'TRadioGroup') or (Sender.ToString = 'TMainFM') then
          begin
            loadCB();
//            ComboBox_1.Left := E_DOb.Left;
//            ComboBox_1.Top := E_DOb.Top;
            ComboBox_1.Visible := True;
           // Label_2.Caption := 'ƒ‡Ú‡';
            Label_11.Visible := True;
            Label_12.Visible := True;
            DTP_2.Visible := True;
            E_Vx.Visible := True;
            E_Va.Visible := True;
            E_RR.Visible := True;
            Label_3.Visible := True;
          end;
          E_Res1.Text := ' “ ' + trim(ComboBox_1.Text) + ' Vx=' + trim(E_Vx.Text) + ' Va=' + trim(E_Va.Text) + ' R=' + trim(E_RR.Text) + ' Date=' + FormatDateTime('yyyy-MM-dd', DTP_2.Date);
        end;
    end;
  end;
end;

procedure TMainFM.E_OBRChange(Sender: TObject);
begin
  construct(Sender);
end;

procedure TMainFM.FormActivate(Sender: TObject);
begin
//ShowMessage(IntToStr(ScrinW)+'-'+IntToStr(MainFM.ScrinW)+'='+IntToStr(Left));
  MainFM.Left := MainFM.ScrinW - 24;
  MainFM.stat1.Panels.Items[1].Text := MyVersion(Application.ExeName);
  MainFM.stat1.Panels.Items[3].Text := MyVersion('X:\_’ÓıÎÓ‚ –.Õ\UPDATE\PR_ISL.exe');
end;

procedure TMainFM.FormCreate(Sender: TObject);
begin

  MainFM.ScrinW := GetDeviceCaps(GetDC(0), HORZRES);
  MainFM.ScrinH := GetDeviceCaps(GetDC(0), VERTRES);
  MainFM.Left := MainFM.ScrinW - 24;
  //ShowMessage(IntToStr(ScrinW)+'-'+IntToStr(MainFM.ScrinW)+'='+IntToStr(Left));
  Top := round(ScrinH / 2) - round(Height / 2);
  construct(Sender);
  DTP_1.Date := Now();

end;

procedure TMainFM.Timer_1Timer(Sender: TObject);
var
  F_Higth, F_Low: Double;
begin
  SetWindowLong(Handle, GWL_HWNDPARENT, GetDesktopWindow);

  //// with Form1 do
  //  SetWindowPos(Handle, HWND_NOTOPMOST|HWND_TOPMOST,Left,Top,Width,Height,SWP_NOACTIVATE or SWP_NOMOVE or SWP_NOSIZE);
  ///
  if ComboBox_2.ItemIndex = 2 then
    C_sql()
  else
    Ar_SQL();
  //ShowMessage(IntToStr(ScrinW)+'='+IntToStr(Left));

  zQ_2.Active := False;
  zQ_2.SQL.Text := sql_ARG;
  zQ_2.Active := true;
  DBChart_1.Series[1].Clear;
  DBChart_1.Series[2].Clear;
  zQ_2.First;
  F_Higth := zQ_2.FieldByName('RawInt').AsFloat * 1.1;
  F_Low := zQ_2.FieldByName('RawInt').AsFloat * 0.9;
  DBChart_1.Series[1].AddXY(zQ_2.FieldByName('Time').AsDateTime, F_Higth, zQ_2.FieldByName('Time').AsString);
  DBChart_1.Series[2].AddXY(zQ_2.FieldByName('Time').AsDateTime, F_Low, zQ_2.FieldByName('Time').AsString);
  zQ_2.Last;
  DBChart_1.Series[1].AddXY(zQ_2.FieldByName('Time').AsDateTime, F_Higth, zQ_2.FieldByName('Time').AsString);
  DBChart_1.Series[2].AddXY(zQ_2.FieldByName('Time').AsDateTime, F_Low, zQ_2.FieldByName('Time').AsString);

end;

end.

