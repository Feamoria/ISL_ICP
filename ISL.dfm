object MainFM: TMainFM
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'ISL'
  ClientHeight = 441
  ClientWidth = 316
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesigned
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 24
    Height = 422
    Align = alLeft
    TabOrder = 0
    object BTN_EXIT: TBitBtn
      Left = 1
      Top = 1
      Width = 22
      Height = 25
      Align = alTop
      Caption = 'X'
      TabOrder = 0
      OnClick = BTN_EXITClick
    end
    object BTN_PM: TBitBtn
      Left = 1
      Top = 26
      Width = 22
      Height = 395
      Align = alClient
      Caption = '<'
      TabOrder = 1
      OnClick = BTN_PMClick
    end
  end
  object pnl3: TPanel
    Left = 24
    Top = 0
    Width = 292
    Height = 422
    Align = alClient
    TabOrder = 1
    object pnl1: TPanel
      Left = 1
      Top = 1
      Width = 290
      Height = 227
      Align = alClient
      TabOrder = 0
      object Label_1: TLabel
        Left = 5
        Top = 149
        Width = 44
        Height = 13
        Caption = #1044#1086#1073#1072#1074#1082#1072
        Visible = False
      end
      object Label_11: TLabel
        Left = 196
        Top = 151
        Width = 12
        Height = 13
        Caption = 'Vx'
        Visible = False
      end
      object Label_12: TLabel
        Left = 137
        Top = 149
        Width = 12
        Height = 13
        Caption = 'Va'
        Visible = False
      end
      object Label_2: TLabel
        Left = 5
        Top = 117
        Width = 43
        Height = 13
        Caption = #1054#1073#1088#1072#1079#1077#1094
      end
      object Label_3: TLabel
        Left = 141
        Top = 117
        Width = 51
        Height = 13
        Caption = #1056#1072#1079#1073#1072#1074#1083'.1'
      end
      object Label_4: TLabel
        Left = 196
        Top = 117
        Width = 51
        Height = 13
        Caption = #1056#1072#1079#1073#1072#1074#1083'.2'
        Visible = False
      end
      object E_DOb: TEdit
        Left = 4
        Top = 163
        Width = 131
        Height = 21
        TabOrder = 4
        Visible = False
        OnChange = E_OBRChange
      end
      object E_OBR: TEdit
        Left = 5
        Top = 130
        Width = 131
        Height = 21
        TabOrder = 5
        TextHint = #1054#1073#1088#1072#1079#1077#1094
        OnChange = E_OBRChange
      end
      object BTN_clicb1: TBitBtn
        Left = 238
        Top = 185
        Width = 52
        Height = 21
        Caption = #1042' '#1073#1091#1092#1077#1088
        TabOrder = 0
        OnClick = BTN_clicb1Click
      end
      object BTN_clicb2: TBitBtn
        Left = 238
        Top = 205
        Width = 52
        Height = 21
        Caption = #1042' '#1073#1091#1092#1077#1088
        TabOrder = 1
        OnClick = BTN_clicb2Click
      end
      object ComboBox_1: TComboBox
        Left = 4
        Top = 130
        Width = 131
        Height = 21
        TabOrder = 2
        OnChange = E_OBRChange
      end
      object DTP_2: TDateTimePicker
        Left = 5
        Top = 163
        Width = 131
        Height = 21
        Date = 42972.558096087960000000
        Format = 'yyyy-MM-dd'
        Time = 42972.558096087960000000
        TabOrder = 3
        OnChange = E_OBRChange
      end
      object E_Res1: TEdit
        Left = 4
        Top = 185
        Width = 233
        Height = 21
        TabOrder = 6
      end
      object E_Res2: TEdit
        Left = 4
        Top = 205
        Width = 233
        Height = 21
        TabOrder = 7
      end
      object E_RR: TEdit
        Left = 137
        Top = 130
        Width = 57
        Height = 21
        Hint = #1056#1072#1079#1073#1072#1074#1083#1077#1085#1080#1077' 1'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 8
        TextHint = 'RR1'
        OnChange = E_OBRChange
      end
      object E_RR2: TEdit
        Left = 196
        Top = 130
        Width = 57
        Height = 21
        Hint = #1056#1072#1079#1073#1072#1074#1083#1077#1085#1080#1077' 2'
        ParentShowHint = False
        ShowHint = True
        TabOrder = 9
        TextHint = 'RR2'
        Visible = False
        OnChange = E_OBRChange
      end
      object E_Va: TEdit
        Left = 137
        Top = 163
        Width = 57
        Height = 21
        TabOrder = 10
        Visible = False
        OnChange = E_OBRChange
      end
      object E_Vx: TEdit
        Left = 196
        Top = 163
        Width = 57
        Height = 21
        TabOrder = 11
        Visible = False
        OnChange = E_OBRChange
      end
      object RadioGroup_1: TRadioGroup
        Left = -4
        Top = -14
        Width = 295
        Height = 129
        ItemIndex = 0
        Items.Strings = (
          #1050#1054#1053#1058#1056#1054#1051#1068' '#1055#1056#1040#1042#1048#1051#1068#1053#1054#1057#1058#1048
          #1050#1054#1053#1058#1056#1054#1051#1068' '#1057#1058#1040#1041#1048#1051#1068#1053#1054#1057#1058#1048
          #1050#1054#1053#1058#1056#1054#1051#1068' '#1061#1054#1051#1054#1057#1058#1054#1043#1054
          #1050#1057#1043#1060
          #1050#1057#1061#1055
          #1050#1054#1053#1058#1056#1054#1051#1068' '#1042#1054#1057#1055#1056#1054#1048#1047#1042#1054#1044#1048#1052#1054#1057#1058#1048' '
          #1050#1058' '#1057' '#1048#1057#1055#1054#1051#1068#1047#1054#1042#1040#1053#1048#1045#1052' '#1056#1040#1047#1041#1040#1042#1051#1045#1053#1048#1071
          #1050#1058' '#1057' '#1048#1057#1055#1054#1051#1068#1047#1054#1042#1040#1053#1048#1045#1052' '#1044#1054#1041#1040#1042#1054#1050
          #1050#1058)
        TabOrder = 12
        OnClick = E_OBRChange
      end
    end
    object Panel1: TPanel
      Left = 1
      Top = 228
      Width = 290
      Height = 193
      Align = alBottom
      BorderStyle = bsSingle
      TabOrder = 1
      object DBChart_1: TDBChart
        Left = 1
        Top = 21
        Width = 284
        Height = 167
        Foot.Visible = False
        SubFoot.Visible = False
        SubTitle.Visible = False
        Title.Text.Strings = (
          'TDBChart')
        Title.Visible = False
        BottomAxis.LabelsFormat.TextAlignment = taCenter
        BottomAxis.Visible = False
        DepthAxis.LabelsFormat.TextAlignment = taCenter
        DepthAxis.Ticks.SmallSpace = 1
        DepthTopAxis.LabelsFormat.TextAlignment = taCenter
        LeftAxis.LabelsFormat.TextAlignment = taCenter
        LeftAxis.Visible = False
        Legend.Visible = False
        RightAxis.Automatic = False
        RightAxis.AutomaticMaximum = False
        RightAxis.AutomaticMinimum = False
        RightAxis.LabelsFormat.TextAlignment = taCenter
        RightAxis.LogarithmicBase = 2.718281828459050000
        RightAxis.MinimumRound = True
        RightAxis.Visible = False
        TopAxis.LabelsFormat.TextAlignment = taCenter
        View3D = False
        Zoom.Pen.Mode = pmNotXor
        Align = alBottom
        TabOrder = 0
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          23
          15
          23)
        ColorPaletteIndex = 5
        object fstlnsrsSeries1: TFastLineSeries
          Marks.Emboss.Clip = True
          Marks.Shadow.Clip = True
          Marks.Visible = False
          Marks.Angle = 40
          Marks.Clip = True
          Marks.DrawEvery = 9
          DataSource = zQ_2
          ShowInLegend = False
          XLabelsSource = 'Time'
          FastPen = True
          LinePen.Color = clBlue
          LinePen.SmallSpace = 1
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'Time'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'RawInt'
        end
        object Series1: TFastLineSeries
          Marks.Visible = False
          SeriesColor = 2038527
          DrawAllPointsStyle = daMinMax
          IgnoreNulls = False
          LinePen.Color = 2038527
          LinePen.Width = 0
          LinePen.EndStyle = esSquare
          LinePen.Fill.Gradient.EndColor = 753908
          LinePen.Fill.Gradient.MidColor = 16059031
          LinePen.Fill.Gradient.StartColor = 14540754
          LinePen.JoinStyle = jsBevel
          LinePen.SmallSpace = 1
          TreatNulls = tnDontPaint
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          Data = {0000000000}
        end
        object Series2: TFastLineSeries
          Marks.Visible = False
          SeriesColor = 393471
          DrawAllPointsStyle = daMinMax
          IgnoreNulls = False
          LinePen.Color = 393471
          LinePen.Width = 0
          LinePen.EndStyle = esSquare
          LinePen.Fill.Gradient.EndColor = 753908
          LinePen.Fill.Gradient.MidColor = 16059031
          LinePen.Fill.Gradient.StartColor = 14540754
          LinePen.JoinStyle = jsBevel
          LinePen.SmallSpace = 1
          TreatNulls = tnDontPaint
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          YValues.Name = 'Y'
          YValues.Order = loNone
          Data = {0000000000}
        end
      end
      object ComboBox_2: TComboBox
        Left = 0
        Top = 2
        Width = 97
        Height = 21
        Style = csDropDownList
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ItemIndex = 0
        ParentFont = False
        TabOrder = 1
        Text = 'ARCOS_EOP'
        TextHint = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
        OnChange = ComboBox_2Change
        Items.Strings = (
          'ARCOS_EOP'
          'Ciros')
      end
      object DTP_1: TDateTimePicker
        Left = 170
        Top = 0
        Width = 115
        Height = 21
        Date = 42971.000000000000000000
        Format = 'yyyy-MM-dd'
        Time = 42971.000000000000000000
        TabOrder = 2
        OnChange = ComboBox_2Change
      end
      object CheckBox_1: TCheckBox
        Left = 151
        Top = 3
        Width = 17
        Height = 17
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = ComboBox_2Change
      end
      object ComboBox_EL: TComboBox
        Left = 97
        Top = 2
        Width = 52
        Height = 21
        Style = csDropDownList
        ItemIndex = 0
        TabOrder = 4
        Text = 'Ar'
        OnChange = ComboBox_2Change
        Items.Strings = (
          'Ar'
          'C')
      end
    end
  end
  object stat1: TStatusBar
    Left = 0
    Top = 422
    Width = 316
    Height = 19
    Panels = <
      item
        Text = 'Ver:'
        Width = 30
      end
      item
        Width = 60
      end
      item
        Text = 'Ver SERV:'
        Width = 60
      end
      item
        Width = 60
      end
      item
        Width = 50
      end>
  end
  object ZConnection1: TZConnection
    ControlsCodePage = cCP_UTF16
    ClientCodepage = 'cp1251'
    Catalog = ''
    Properties.Strings = (
      'codepage=cp1251'
      'AutoEncodeStrings=ON'
      'controls_cp=CP_UTF16')
    HostName = '172.19.3.23'
    Port = 3306
    Database = 'lims'
    User = 'root'
    Password = 'aq1sw2de3'
    Protocol = 'mysql-5'
    Left = 43
    Top = 280
  end
  object DS_1: TDataSource
    DataSet = zQ_1
    Left = 164
    Top = 282
  end
  object zQ_1: TZQuery
    Connection = ZConnection1
    Params = <>
    Left = 109
    Top = 282
  end
  object zQ_2: TZQuery
    Connection = ZConnection1
    SQL.Strings = (
      
        'SELECT `DateTime` as `Time`, `RawInt`,`isl`.`Name` FROM lims.exp' +
        '_date,lims.EXP,lims.isl '
      'where element like '#39'Ar'#39' '
      
        'and (exp_date.id_exp = EXP.id_EXP) and (isl.id_isl = EXP.id_isl)' +
        ' and '
      '(`EXP`.`DateTime` like '#39'2017-08-23%'#39') '
      
        'and (`Instrument` = '#39'ARCOS_EOP'#39') and (`origin_isl` = '#39'Measured'#39')' +
        ' and (`info_isl` != '#39'Recalc'#39') '
      'order by `EXP`.`DateTime` ')
    Params = <>
    Left = 107
    Top = 337
  end
  object DS_2: TDataSource
    DataSet = zQ_1
    Left = 164
    Top = 335
  end
  object Timer_1: TTimer
    Interval = 10000
    OnTimer = Timer_1Timer
    Left = 267
    Top = 309
  end
end
