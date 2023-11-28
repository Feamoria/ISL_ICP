object OP_Control_Fm: TOP_Control_Fm
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'OP_Control_Fm'
  ClientHeight = 489
  ClientWidth = 392
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
  object Label_1: TLabel
    Left = 135
    Top = 42
    Width = 33
    Height = 13
    Caption = #1052#1077#1090#1086#1076
  end
  object RadioGroup_1: TRadioGroup
    Left = 0
    Top = 8
    Width = 129
    Height = 52
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #1050#1055
      #1050#1057
      #1050#1058
      #1050#1042#1055
      #1050#1058#1056
      #1050#1058#1044)
    TabOrder = 3
    OnClick = RadioGroup_1Click
  end
  object ComboBox_2: TComboBox
    Left = 1
    Top = 0
    Width = 91
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 0
    Text = 'ARCOS_EOP'
    TextHint = #1048#1085#1089#1090#1088#1091#1084#1077#1085#1090
    OnChange = ComboBox_2Change
    Items.Strings = (
      'ARCOS_EOP'
      'Ciros')
  end
  object DTP_1: TDateTimePicker
    Left = 95
    Top = 1
    Width = 96
    Height = 20
    Date = 42971.000000000000000000
    Format = 'yyyy-MM-dd'
    Time = 42971.000000000000000000
    TabOrder = 1
    OnChange = DTP_1Change
  end
  object BTN_PM: TBitBtn
    Left = 379
    Top = 1
    Width = 14
    Height = 487
    Caption = '<'
    TabOrder = 2
    OnClick = BTN_PMClick
  end
  object ComboBox_1: TComboBox
    Left = 191
    Top = 1
    Width = 89
    Height = 21
    Style = csDropDownList
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemIndex = 0
    ParentFont = False
    TabOrder = 4
    Text = #1042#1089#1105
    OnChange = ComboBox_1Change
    Items.Strings = (
      #1042#1089#1105
      #1059#1076#1086#1074#1083#1077#1090#1074'.'
      #1053#1077#1091#1076#1074#1083'.')
  end
  object CheckBox_1: TCheckBox
    Left = 135
    Top = 19
    Width = 35
    Height = 17
    Caption = 'T'
    TabOrder = 5
    OnClick = CheckBox_1Click
  end
  object pnl1: TPanel
    Left = 0
    Top = 62
    Width = 380
    Height = 427
    TabOrder = 6
    object spl1: TSplitter
      Left = 132
      Top = 1
      Width = 2
      Height = 425
      ExplicitLeft = 90
      ExplicitHeight = 163
    end
    object pnl2: TPanel
      Left = 1
      Top = 1
      Width = 131
      Height = 425
      Align = alLeft
      BorderStyle = bsSingle
      TabOrder = 0
      object JvDBLookupList_Name: TJvDBLookupList
        Left = 1
        Top = 1
        Width = 125
        Height = 416
        BorderStyle = bsNone
        Align = alClient
        LookupField = 'id_isl'
        LookupDisplay = 'Name'
        LookupSource = DS_1
        TabOrder = 0
        OnClick = JvDBLookupList_NameClick
      end
    end
    object pnl3: TPanel
      Left = 134
      Top = 1
      Width = 245
      Height = 425
      Align = alClient
      BorderStyle = bsSingle
      TabOrder = 1
      object StringGrid1: TStringGrid
        Left = 1
        Top = 58
        Width = 239
        Height = 362
        Align = alClient
        BorderStyle = bsNone
        ColCount = 4
        DefaultColWidth = 52
        DefaultRowHeight = 20
        FixedCols = 0
        RowCount = 2
        TabOrder = 0
        OnDrawCell = StringGrid1DrawCell
      end
      object pnl4: TPanel
        Left = 1
        Top = 39
        Width = 239
        Height = 19
        Align = alTop
        TabOrder = 1
        object DB_ED_Name: TDBEdit
          Left = 53
          Top = 1
          Width = 72
          Height = 17
          Align = alLeft
          DataField = 'origin_isl'
          DataSource = DS_1
          ReadOnly = True
          TabOrder = 0
          ExplicitHeight = 21
        end
        object DB_ED_info_isl: TDBEdit
          Left = 1
          Top = 1
          Width = 52
          Height = 17
          Align = alLeft
          DataField = 'time'
          DataSource = DS_1
          ReadOnly = True
          TabOrder = 1
          ExplicitHeight = 21
        end
        object DB_ED_origin_isl: TDBEdit
          Left = 125
          Top = 1
          Width = 113
          Height = 17
          Align = alClient
          DataField = 'info_isl'
          DataSource = DS_1
          ReadOnly = True
          TabOrder = 2
          ExplicitHeight = 21
        end
      end
      object DBMemo_Name: TDBMemo
        Left = 1
        Top = 1
        Width = 239
        Height = 38
        Align = alTop
        DataField = 'Name'
        DataSource = DS_1
        ReadOnly = True
        TabOrder = 2
      end
    end
  end
  object BD_CB_Metod: TComboBox
    Left = 174
    Top = 39
    Width = 199
    Height = 21
    TabOrder = 7
    OnChange = BD_CB_MetodChange
  end
  object RadioGroup_2: TRadioGroup
    Left = 282
    Top = -17
    Width = 91
    Height = 44
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      '%'
      'CON')
    TabOrder = 8
    OnClick = RadioGroup_2Click
  end
  object zQ_1: TZQuery
    Connection = MainFM.ZConnection1
    SQL.Strings = (
      'SELECT `isl`.*,'
      
        'trim(substring(`isl`.`Name`,3,LOCATE('#39' R='#39',`isl`.`Name`)-3)) as ' +
        'cat,'
      
        'trim(substring(`isl`.`Name`,LOCATE('#39' R='#39',`isl`.`Name`)+3,length(' +
        'trim(`isl`.`Name`))+1-LOCATE('#39' R='#39',`isl`.`Name`))) as RR,'
      'Time(`isl`.`Date`) as time'
      'FROM lims.isl'
      'where'
      '`Instrument` = '#39'Ciros'#39' '
      'and `Date` like '#39'2017-11-02%'#39' '
      'and `Name` like '#39#1050#1055' %'#39
      'Order by `Date` desc')
    Params = <>
    Left = 14
    Top = 378
  end
  object zQ_2: TZQuery
    Connection = MainFM.ZConnection1
    Params = <>
    Left = 165
    Top = 345
  end
  object DS_1: TDataSource
    DataSet = zQ_1
    Left = 52
    Top = 379
  end
  object DS_2: TDataSource
    DataSet = zQ_2
    Left = 225
    Top = 343
  end
  object zQ_test: TZQuery
    Connection = MainFM.ZConnection1
    Params = <>
    Left = 165
    Top = 393
  end
  object DS_test: TDataSource
    DataSet = zQ_test
    Left = 225
    Top = 391
  end
  object Timer_1: TTimer
    Interval = 10000
    OnTimer = Timer_1Timer
    Left = 286
    Top = 351
  end
  object zQ_metod: TZQuery
    Connection = MainFM.ZConnection1
    SQL.Strings = (
      'SELECT distinct `isl`.`Metod` as Name '
      'FROM `isl`'
      'where'
      '(`isl`.`Instrument`  = '#39'Ciros'#39' ) '
      'and (`isl`.`Date` like  '#39'2017-11-02%'#39' )')
    Params = <>
    Left = 191
    Top = 282
  end
  object DS_metod: TDataSource
    DataSet = zQ_metod
    Left = 229
    Top = 283
  end
end
