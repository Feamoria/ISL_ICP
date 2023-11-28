object FM_log: TFM_log
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  ClientHeight = 418
  ClientWidth = 576
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm1
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Memo_1: TMemo
    Left = 0
    Top = 0
    Width = 576
    Height = 418
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 0
    WordWrap = False
  end
  object mm1: TMainMenu
    Left = 210
    Top = 72
    object clear1: TMenuItem
      Caption = 'clear'
      OnClick = clear1Click
    end
  end
end
