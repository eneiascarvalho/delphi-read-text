object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Delphi read text'
  ClientHeight = 586
  ClientWidth = 568
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblTextProcess: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 63
    Width = 562
    Height = 13
    Align = alTop
    Caption = 'Text to process'
    ExplicitWidth = 75
  end
  object lblResult: TLabel
    AlignWithMargins = True
    Left = 3
    Top = 333
    Width = 562
    Height = 13
    Align = alBottom
    Caption = 'Result'
    ExplicitLeft = 8
    ExplicitTop = 182
  end
  object rgOption: TRadioGroup
    AlignWithMargins = True
    Left = 3
    Top = 3
    Width = 562
    Height = 54
    Align = alTop
    Caption = 'Option'
    Columns = 2
    ItemIndex = 1
    Items.Strings = (
      'Read file'
      'Random')
    TabOrder = 0
    OnClick = rgOptionClick
  end
  object memoTextToProcess: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 82
    Width = 562
    Height = 214
    Align = alClient
    ScrollBars = ssBoth
    TabOrder = 1
    ExplicitLeft = -2
    ExplicitTop = 32
    ExplicitHeight = 44
  end
  object btnSearch: TButton
    AlignWithMargins = True
    Left = 3
    Top = 302
    Width = 562
    Height = 25
    Align = alBottom
    Caption = 'Search sequencies'
    TabOrder = 2
    OnClick = btnSearchClick
    ExplicitLeft = 8
    ExplicitTop = 218
  end
  object memoResult: TMemo
    AlignWithMargins = True
    Left = 3
    Top = 352
    Width = 562
    Height = 231
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 3
  end
  object odTextFile: TOpenDialog
    Filter = 'Text files|*.txt'
    Left = 424
    Top = 16
  end
end
