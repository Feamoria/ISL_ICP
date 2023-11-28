unit OP_Control;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Buttons, JvExControls, JvDBLookup, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids,
  JvExDBGrids, JvDBGrid, Data.DB, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  Vcl.DBCtrls, Vcl.Mask;

type
  TOP_Control_Fm = class(TForm)
    ComboBox_2: TComboBox;
    DTP_1: TDateTimePicker;
    BTN_PM: TBitBtn;
    JvDBLookupList_Name: TJvDBLookupList;
    RadioGroup_1: TRadioGroup;
    ComboBox_1: TComboBox;
    zQ_1: TZQuery;
    zQ_2: TZQuery;
    DS_1: TDataSource;
    DS_2: TDataSource;
    StringGrid1: TStringGrid;
    zQ_test: TZQuery;
    DS_test: TDataSource;
    CheckBox_1: TCheckBox;
    Timer_1: TTimer;
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    spl1: TSplitter;
    zQ_metod: TZQuery;
    DS_metod: TDataSource;
    BD_CB_Metod: TComboBox;
    Label_1: TLabel;
    DB_ED_Name: TDBEdit;
    pnl4: TPanel;
    DB_ED_info_isl: TDBEdit;
    DBMemo_Name: TDBMemo;
    DB_ED_origin_isl: TDBEdit;
    RadioGroup_2: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure BTN_PMClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
   // procedure SQL_OSN(Sender: TObject);
    procedure ComboBox_2Change(Sender: TObject);
    procedure DTP_1Change(Sender: TObject);
    procedure RadioGroup_1Click(Sender: TObject);
    procedure JvDBLookupList_NameClick(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Timer_1Timer(Sender: TObject);
    procedure ComboBox_1Change(Sender: TObject);
    procedure BD_CB_MetodChange(Sender: TObject);
    procedure RadioGroup_2Click(Sender: TObject);
    procedure BTN_1Click(Sender: TObject);
    procedure CheckBox_1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  OP_Control_Fm: TOP_Control_Fm;
  first: Boolean;

implementation

uses
  ISL, u_log;
{$R *.dfm}

procedure TOP_Control_Fm.BTN_1Click(Sender: TObject);
begin
  FM_log.Visible := false;
  FM_log.Visible := true;
end;

procedure TOP_Control_Fm.BTN_PMClick(Sender: TObject);
begin
  if BTN_PM.Tag = 0 then
  begin
    OP_Control_Fm.Left := 0; //+ 24;
    BTN_PM.Tag := 1;
    BTN_PM.Caption := '>';
  end
  else
  begin
    OP_Control_Fm.Left := 14 - Width;
    BTN_PM.Tag := 0;
    BTN_PM.Caption := '<';
  end;
end;

procedure SQL_OSN();
begin

  with OP_Control_Fm do
  begin
    if first then
    begin
      zQ_metod.Active := False;
      zQ_metod.SQL.clear;

      zQ_metod.SQL.Add('SELECT distinct `isl`.`Metod` as Name ');
      zQ_metod.SQL.Add('FROM `isl` where                        ');
      zQ_metod.SQL.Add('(`isl`.`Instrument`  = "' + ComboBox_2.Text + '") ');
      zQ_metod.SQL.Add(' and (`isl`.`Date` like  "' + FormatDateTime('yyyy-MM-dd', DTP_1.Date) + '%" ) ');

      zQ_metod.Active := true;

      if CheckBox_1.Checked then
        FM_log.log(zQ_metod.SQL.Text);
      if zQ_metod.RecordCount > 0 then
      begin
        BD_CB_Metod.Clear;
        zQ_metod.First;
        while not (zQ_metod.Eof) do
        begin
          BD_CB_Metod.Items.Add(zQ_metod.FieldByName('Name').AsString);
          zQ_metod.Next;
        end;

       // until zQ_metod.Eof;
        BD_CB_Metod.ItemIndex := 0;
      end;
      first := False;
    end;
    if RadioGroup_1.ItemIndex > 2 then
    begin
      exit;
    end;
   // end;
    zQ_1.Active := False;
    zQ_1.SQL.clear;
    zQ_1.SQL.Add('SELECT `isl`.* , Time(`isl`.`Date`) as time,');
    zQ_1.SQL.Add('trim(substring(`isl`.`Name`,3,LOCATE(" R=",`isl`.`Name`)-3)) as cat,');
    zQ_1.SQL.Add('trim(substring(`isl`.`Name`,LOCATE(" R=",`isl`.`Name`)+3,length(trim(`isl`.`Name`))+1-LOCATE(" R=",`isl`.`Name`))) as RR ');
    zQ_1.SQL.Add('FROM lims.isl  where `Instrument` = "' + ComboBox_2.Text + '"');
    zQ_1.SQL.Add('and (`isl`.`Name` not like "%КП%хол%")');
    zQ_1.SQL.Add('and `Date` like "' + FormatDateTime('yyyy-MM-dd', DTP_1.Date) + '%"');
    zQ_1.SQL.Add('and `Name` like "' + RadioGroup_1.Items[RadioGroup_1.ItemIndex] + ' %"');
    if (BD_CB_Metod.Text <> '') then
      zQ_1.SQL.Add('and `Metod` = "' + BD_CB_Metod.Text + '"');
    zQ_1.SQL.Add('Order by `Date` desc ');
    if CheckBox_1.Checked then
      FM_log.log(zQ_1.SQL.Text);
    zQ_1.Active := true;
  end;
end;

procedure TOP_Control_Fm.BD_CB_MetodChange(Sender: TObject);
begin
  BD_CB_Metod.Tag := 1;
  SQL_OSN();
  BD_CB_Metod.Tag := 0;
end;

procedure TOP_Control_Fm.CheckBox_1Click(Sender: TObject);
begin
  FM_log.Visible := false;
  FM_log.Visible := true;
end;

procedure TOP_Control_Fm.ComboBox_1Change(Sender: TObject);
begin
  JvDBLookupList_NameClick(JvDBLookupList_Name);
end;

procedure TOP_Control_Fm.ComboBox_2Change(Sender: TObject);
begin
  first := True;
  SQL_OSN();
end;

procedure TOP_Control_Fm.DTP_1Change(Sender: TObject);
begin
  first := True;
  SQL_OSN();
end;

procedure TOP_Control_Fm.FormActivate(Sender: TObject);
begin
  MainFM.Left := MainFM.ScrinW - 24;
  StringGrid1.Cells[0, 0] := 'Линия';
  StringGrid1.Cells[1, 0] := 'Реал%';
  StringGrid1.Cells[2, 0] := 'Атест%';
  StringGrid1.Cells[3, 0] := 'Рез.';
  StringGrid1.ColWidths[0] := 65;
  StringGrid1.ColWidths[1] := 50;
  StringGrid1.ColWidths[2] := 50;
  StringGrid1.ColWidths[3] := 50;

  SQL_OSN();
end;

procedure TOP_Control_Fm.FormCreate(Sender: TObject);
begin
  OP_Control_Fm.Visible := True;
  Left := 14 - Width;
  Top := round(isl.MainFM.ScrinH / 2) - round(Height / 2); //
  DTP_1.Date := Now();
  first := True;
end;

procedure TOP_Control_Fm.JvDBLookupList_NameClick(Sender: TObject);
var
  PNDF, type_op: string;
  inst, el, AVG, koof, Rez, Proz, ST_RR, Proz_real: string;
  z, cons_att, AVG_F, cons_att_L, cons_att_H, ST_RR_F, z_r: Extended;
  I, Y: Integer;
  RR, Vx, Va: Extended;
begin
  zQ_2.Active := false;
  for I := 1 to StringGrid1.RowCount do
    for Y := 0 to StringGrid1.ColCount do
      StringGrid1.Cells[Y, I] := '';
//  if not ((ComboBox_2.ItemIndex = 0) or (ComboBox_2.ItemIndex = 1)) then
//  begin
//    ShowMessage('длугой');
//    Exit;
//  end;
///////////////
///  По методу определяем ПНДФ
///
  zQ_test.Active := false;
  zQ_test.SQL.Clear;
  zQ_test.SQL.Add('SELECT * FROM `Metodic_ICP` where `Name` = "' + BD_CB_Metod.Text + '"');
  zq_test.Active := true;
  FM_log.log('Кол-во методик найдено:' + inttostr(zq_test.RecordCount));
  if zq_test.RecordCount = 0 then
  begin
    ShowMessage('Метод ICP НЕ ПРИВЯЗАН К МЕТОДИКЕ. ПРИВЯЖИТЕ ЕГО  В ЗАГРУЗЧИКЕ В МЕНЮ МЕТОДИКИ!!');
    exit;
  end
  else if (zq_test.RecordCount > 1) then
  begin
    ShowMessage('Метод ICP ПРИВЯЗАН К 2м и БОЛЕЕ МЕТОДИКАМ. Подробности в логе');
    zQ_test.First;
    while not zQ_test.Eof do
    begin
      FM_log.log(zq_test.FieldByName('Name').AsString + ' > связь с id метода >' + zq_test.FieldByName('id_m').AsString);
      zQ_test.Next;
    end;
    exit;
  end;
  PNDF := zq_test.FieldByName('id_m').AsString;
  FM_log.log('ID Metodic_ICP : ' + PNDF);

  koof := '1';
  if PNDF = '2' then
    koof := StringReplace(floattostr(1 / 30), ',', '.', [rfReplaceAll, rfIgnoreCase]); //'0.03';
  if PNDF = '11' then
    koof := StringReplace(floattostr(1 / 10), ',', '.', [rfReplaceAll, rfIgnoreCase]); //'0.01';

  ////////////////
  zQ_2.SQL.Clear;
  type_op := inttostr(RadioGroup_1.ItemIndex + 1);
  if RadioGroup_1.ItemIndex = 0 then
    zQ_2.SQL.Add('SELECT a.`Name`,a.`cat`,a.`RR`,a.`ElementP`, a.`Element`,a.`Instrument`,a.`ConsO`,(a.Cons_S/a.rr) as Cons_ST , a.`Cons_S`, a.`ST`,a.`Vx`,a.`Va`,a.`RRKT` from ( ');
  zQ_2.SQL.Add('SELECT  `obraz_KP`.`Name`,');
  zQ_2.SQL.Add('trim(substring(`isl`.`Name`,LOCATE("КТ ",`isl`.`Name`)+3,LOCATE(" Vx=",`isl`.`Name`)-LOCATE("КТ ",`isl`.`Name`)-3 )) as ST ,');
  zQ_2.SQL.Add('trim(substring(`isl`.`Name`,LOCATE(" Vx=",`isl`.`Name`)+4,LOCATE(" Va=",`isl`.`Name`)-LOCATE(" Vx=",`isl`.`Name`)-4 )) as Vx ,');
  zQ_2.SQL.Add('trim(substring(`isl`.`Name`,LOCATE(" Va=",`isl`.`Name`)+4,LOCATE(" R=",`isl`.`Name`)-LOCATE(" Va=",`isl`.`Name`)-4)) as Va ,');
  zQ_2.SQL.Add('trim(substring(`isl`.`Name`,LOCATE(" R=",`isl`.`Name`)+3,LOCATE(" Date=",`isl`.`Name`)-LOCATE(" R=",`isl`.`Name`)-3)) as RRKT, ');
  zQ_2.SQL.Add('trim(substring(`isl`.`Name`,3,LOCATE(" R=",`isl`.`Name`)-3)) as cat,  ');
  zQ_2.SQL.Add('trim(substring(`isl`.`Name`,LOCATE(" R=",`isl`.`Name`)+3,length(trim(`isl`.`Name`))+1-LOCATE(" R=",`isl`.`Name`))) as RR, ');
  zQ_2.SQL.Add('`exp_date`.`ElementP`,`exp_date`.`Element`,`isl`.`Instrument`, ');
  zQ_2.SQL.Add('(AVG( `exp_date`.`Cons`/`control`.`ED_int`)) as ConsO,');
  zQ_2.SQL.Add('(`obraz_KP`.`ED_INT`*`obraz_KP_date`.`Cons`/`control`.`ED_int`) as Cons_S    ');
  zQ_2.SQL.Add('FROM `isl`,`EXP`,`exp_date`,`obraz_KP`,`obraz_KP_date`,`control`     ');
  zQ_2.SQL.Add('Where	(`isl`.`id_isl` = `EXP`.`id_isl`) ');
  zQ_2.SQL.Add('and (`EXP`.`id_EXP`= `exp_date`.`id_exp`)');
  zQ_2.SQL.Add('and (`obraz_KP`.`id_kp`= `obraz_KP_date`.`id_kp`)');
  zQ_2.SQL.Add('and (`EXP`.`Status` != "Deleted")');
  //zQ_2.SQL.Add('and (`control`.`instr` = `isl`.`Instrument`)');
  zQ_2.SQL.Add('and (`exp_date`.`Element`= `control`.`Element`)');
  zQ_2.SQL.Add('and (`exp_date`.`Element`= `obraz_KP_date`.`Element`)');
  zQ_2.SQL.Add('and (INSTR(`isl`.`Name`, `obraz_KP`.`Name`)  !=0 )');
  zQ_2.SQL.Add('and (`obraz_KP`.`type`= ' + type_op + ')');
  zQ_2.SQL.Add('and`control`.`PNDF` = ' + PNDF);
  zQ_2.SQL.Add('and `exp_date`.`Element` != "Ar"   ');
  zQ_2.SQL.Add('and `exp_date`.`DELETE` = 0   ');
  zQ_2.SQL.Add('and `isl`.`id_isl` = "' + JvDBLookupList_Name.Value + '"   ');
  zQ_2.SQL.Add('group by `isl`.`id_isl`,`exp_date`.`ElementP`  ');
  zQ_2.SQL.Add('Order by `isl`.`id_isl`,`exp_date`.`ElementP`  ');
  if RadioGroup_1.ItemIndex = 0 then
    zQ_2.SQL.Add(' ) as a');
  FM_log.log('------------------');
  FM_log.log(zQ_2.SQL.Text);
  FM_log.log('------------------');
  zQ_2.Active := True;
  FM_log.log('RecordCount=' + inttostr(zQ_2.RecordCount));
  if zQ_2.RecordCount = 0 then
  begin
    zQ_2.Active := false;
    zQ_2.SQL.Clear;
    zQ_2.SQL.Add('SELECT  `obraz_KP`.`Name`, ');
    zQ_2.SQL.Add('trim(substring(`isl`.`Name`,LOCATE(" Va=",`isl`.`Name`)+4,LOCATE(" R=",`isl`.`Name`)-LOCATE(" Va=",`isl`.`Name`)-4)) as Va ,');
    zQ_2.SQL.Add('trim(substring(`isl`.`Name`,3,LOCATE(" R=",`isl`.`Name`)-3)) as cat');
    zQ_2.SQL.Add('FROM `isl`,`obraz_KP`');
    zQ_2.SQL.Add('Where	(INSTR(`isl`.`Name`, `obraz_KP`.`Name`)  !=0 )');
    zQ_2.SQL.Add('and (`obraz_KP`.`type`= ' + type_op + ')');
    zQ_2.SQL.Add('and `isl`.`id_isl` = "' + JvDBLookupList_Name.Value + '"   ');
    zQ_2.SQL.Add('group by `isl`.`id_isl`');
    zQ_2.SQL.Add('Order by `isl`.`id_isl`');

    // if CheckBox_1.Checked then
    FM_log.log('------------------');
        FM_log.log(zQ_2.SQL.Text);
    FM_log.log('------------------');
    zQ_2.Active := True;
    // если кол-во больше 0 то с образцом всё норм проблема в логике
    // если = 0 то такого образца нет в бд.
    if zQ_2.RecordCount = 0 then
      ShowMessage('Образец не забит в БД')
    else
      ShowMessage('Пока не известная ошибка');


    exit;
  end;

  StringGrid1.RowCount := 2;
  zQ_2.First;
  repeat

    //Данные из таблицы забираем
    el := zQ_2.FieldByName('Element').AsString;

    if RadioGroup_1.ItemIndex = 2 then
    begin
      RR := strtofloat(StringReplace(zQ_2.FieldByName('RRKT').AsString, '.', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]));
      Vx := strtofloat(StringReplace(zQ_2.FieldByName('Vx').AsString, '.', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]));
      Va := strtofloat(StringReplace(zQ_2.FieldByName('Va').AsString, '.', FormatSettings.DecimalSeparator, [rfReplaceAll, rfIgnoreCase]));
      AVG_F := (zQ_2.FieldByName('ConsO').AsExtended * RR * Vx) / Va;
      AVG := StringReplace(floattostr(AVG_F), ',', '.', [rfReplaceAll, rfIgnoreCase]);
    end
    else
    begin
      AVG_F := zQ_2.FieldByName('ConsO').AsExtended;
      AVG := StringReplace(floattostr(AVG_F), ',', '.', [rfReplaceAll, rfIgnoreCase]);
    end;
    if RadioGroup_1.ItemIndex = 0 then
    begin
      // условие на случай если разбавления не будет
      if zQ_2.FieldByName('Cons_ST').AsString = '' then
      begin
        cons_att := zQ_2.FieldByName('Cons_S').AsFloat;
        ST_RR_F := zQ_2.FieldByName('Cons_S').AsFloat;
      end
      else
      begin
        cons_att := zQ_2.FieldByName('Cons_ST').AsFloat;
        ST_RR_F := zQ_2.FieldByName('Cons_ST').AsFloat;
      end;
    end
    else
    begin
      cons_att := zQ_2.FieldByName('Cons_S').AsFloat;
      ST_RR_F := zQ_2.FieldByName('Cons_S').AsFloat;
    end;

    ST_RR := StringReplace(FloatToStr(ST_RR_F), ',', '.', [rfReplaceAll, rfIgnoreCase]);
    zQ_test.Active := False;
    zQ_test.SQL.Clear;
    zQ_test.SQL.Add('SELECT * ');
    zQ_test.SQL.Add('FROM lims.control ');
    zQ_test.SQL.Add('WHERE  ');
   // zQ_test.SQL.Add('(((`instr` = "' + inst + '") and (`Element` like "' + el + '") and (`PNDF` = ' + PNDF + ') ) and ');
    zQ_test.SQL.Add('(( (`Element` like "' + el + '") and (`PNDF` = ' + PNDF + ') ) and ');
    zQ_test.SQL.Add('	(( (DiaN_A = 1) and ((DiaN*' + koof + ' <= ' + ST_RR + ') and (' + ST_RR + ' <= DiaK))) ');
    zQ_test.SQL.Add('	or	((DiaN_A = 0) and ((DiaN*' + koof + ' < ' + ST_RR + ') and (' + ST_RR + ' <= DiaK))) ');
    zQ_test.SQL.Add('	 )) ');
    if CheckBox_1.Checked then
      FM_log.log(zQ_test.SQL.Text);
    zQ_test.Active := True;
    if (zQ_test.RecordCount = 0) then
    begin
      Rez := 'Вне.д.и';
      Proz := FloatToStr(cons_att);
      Proz_real := FloatToStr(AVG_F);
      z := 0;
    end
    else
    begin
      Proz := '';
      Rez := '';
      Proz_real := '';
      z := 0;
      if zQ_test.RecordCount > 0 then
      begin
        if el = 'Cl' then
          case RadioGroup_1.ItemIndex of
            0:
              z := zQ_test.FieldByName('Delta').AsFloat;
            1:
              z := zQ_test.FieldByName('KS').AsFloat;
          end
        else
          case RadioGroup_1.ItemIndex of
            0:
              //if inst = 'Ciros' then

            //  else
              if (PNDF = '1') then
                z := zQ_test.FieldByName('Delta').AsFloat * 0.84 * 0.7
              else
                z := zQ_test.FieldByName('Delta').AsFloat * 0.84 * 0.4;
            1:
              begin
                if (PNDF <> '1') then
                  z := 10
                else
                  z := zQ_test.FieldByName('Delta').AsFloat * 0.84 * 0.5;
              end;
            2:
              z := zQ_test.FieldByName('Delta').AsFloat * 0.84;
          end;
        z_r := (round((((AVG_F - cons_att) / cons_att) * 100) * 100)) / 100;
        if RadioGroup_2.ItemIndex = 0 then
        begin
          Proz := FloatToStr((Round(z * 100)) / 100) + '%';
          Proz_real := FloatToStr(z_r) + '%';
          StringGrid1.Cells[1, 0] := 'Реал%';
          StringGrid1.Cells[2, 0] := 'Аттест%';
        end
        else
        begin
          Proz := FloatToStr(cons_att);
          Proz_real := FloatToStr(AVG_F);
          StringGrid1.Cells[1, 0] := 'Реал';
          StringGrid1.Cells[2, 0] := 'Аттест';
        end;

        if abs(z_r) < z then
        begin
          Rez := 'Уд.';
        end
        else
        begin
          Rez := 'Неуд.';
        end;
      end
      else
        Proz := 'Вне.д.и';
    end;
    case ComboBox_1.ItemIndex of
      1:
        begin
          if Rez = 'Уд.' then
          begin
            StringGrid1.Cells[0, StringGrid1.RowCount - 1] := zQ_2.FieldByName('ElementP').AsString;
            StringGrid1.Cells[1, StringGrid1.RowCount - 1] := Proz_real;
            StringGrid1.Cells[2, StringGrid1.RowCount - 1] := Proz;
            StringGrid1.Cells[3, StringGrid1.RowCount - 1] := Rez;
            StringGrid1.RowCount := StringGrid1.RowCount + 1;
          end;

        end;
      2:
        begin
          if Rez = 'Неуд.' then
          begin
            StringGrid1.Cells[0, StringGrid1.RowCount - 1] := zQ_2.FieldByName('ElementP').AsString;
            StringGrid1.Cells[1, StringGrid1.RowCount - 1] := Proz_real;
            StringGrid1.Cells[2, StringGrid1.RowCount - 1] := Proz;
            StringGrid1.Cells[3, StringGrid1.RowCount - 1] := Rez;
            StringGrid1.RowCount := StringGrid1.RowCount + 1;
          end;
        end
    else
      begin
        StringGrid1.Cells[0, StringGrid1.RowCount - 1] := zQ_2.FieldByName('ElementP').AsString;
        StringGrid1.Cells[1, StringGrid1.RowCount - 1] := Proz_real;
        StringGrid1.Cells[2, StringGrid1.RowCount - 1] := Proz;
        StringGrid1.Cells[3, StringGrid1.RowCount - 1] := Rez;
        StringGrid1.RowCount := StringGrid1.RowCount + 1;
      end;
    end;

    zQ_2.Next;
  until zQ_2.Eof;
  if StringGrid1.RowCount > 2 then
    StringGrid1.RowCount := StringGrid1.RowCount - 1;
end;

procedure TOP_Control_Fm.RadioGroup_1Click(Sender: TObject);
begin
  SQL_OSN();
  first := True;
end;

procedure TOP_Control_Fm.RadioGroup_2Click(Sender: TObject);
begin
  JvDBLookupList_NameClick(JvDBLookupList_Name);
end;

procedure TOP_Control_Fm.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  if StringGrid1.Cells[ACol, ARow] = 'Неуд.' then // проверяем координаты
  begin
    // рисуем фон
    StringGrid1.Canvas.Brush.Color := clRed;
    StringGrid1.Canvas.Brush.Style := bsSolid;
    StringGrid1.Canvas.Font.Color := clWhite;
    StringGrid1.Canvas.FillRect(Rect);
    // выводим текст (приходится делать всё самим, т.к.
    // при закраске фона текст исчезает
    StringGrid1.Canvas.Font.Assign(StringGrid1.Font);
    StringGrid1.Canvas.TextRect(Rect, Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
  if StringGrid1.Cells[ACol, ARow] = 'Уд.' then // проверяем координаты
  begin
    // рисуем фон
    StringGrid1.Canvas.Brush.Color := clGreen;
    StringGrid1.Canvas.Brush.Style := bsSolid;
    StringGrid1.Canvas.Font.Color := clWhite;
    StringGrid1.Canvas.FillRect(Rect);
    // выводим текст (приходится делать всё самим, т.к.
    // при закраске фона текст исчезает
    StringGrid1.Canvas.Font.Assign(StringGrid1.Font);
    StringGrid1.Canvas.TextRect(Rect, Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
  if StringGrid1.Cells[ACol, ARow] = 'Вне.д.и' then // проверяем координаты
  begin
    // рисуем фон
    StringGrid1.Canvas.Brush.Color := clYellow;
    StringGrid1.Canvas.Brush.Style := bsSolid;
    StringGrid1.Canvas.Font.Color := clWhite;
    StringGrid1.Canvas.FillRect(Rect);
    // выводим текст (приходится делать всё самим, т.к.
    // при закраске фона текст исчезает
    StringGrid1.Canvas.Font.Assign(StringGrid1.Font);
    StringGrid1.Canvas.TextRect(Rect, Rect.Left, Rect.Top, StringGrid1.Cells[ACol, ARow]);
  end;
end;

procedure TOP_Control_Fm.Timer_1Timer(Sender: TObject);
begin
//first:=True;
  SetWindowLong(Handle, GWL_HWNDPARENT, GetDesktopWindow);
  SQL_OSN();
end;

end.

