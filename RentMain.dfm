object fMainRent: TfMainRent
  Left = 344
  Top = 219
  Width = 977
  Height = 594
  Caption = #1055#1088#1086#1082#1072#1090' '#1096#1082#1086#1083#1100#1085#1086#1081' '#1092#1086#1088#1084#1099' ('#1074#1077#1088#1089#1080#1103' 1.0)'
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  Menu = mmRent
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object sRent: TSplitter
    Left = 481
    Top = 41
    Height = 447
    Color = clGradientInactiveCaption
    ParentColor = False
  end
  object pMonth: TPanel
    Left = 0
    Top = 0
    Width = 961
    Height = 41
    Align = alTop
    Color = clGradientInactiveCaption
    TabOrder = 0
    object lMonth: TLabel
      Left = 8
      Top = 16
      Width = 41
      Height = 17
      Caption = #1052#1077#1089#1103#1094
    end
    object lGod: TLabel
      Left = 176
      Top = 16
      Width = 23
      Height = 17
      Caption = #1043#1086#1076
    end
    object cobMonth: TComboBox
      Left = 56
      Top = 8
      Width = 113
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 0
      OnChange = cobMonthChange
      Items.Strings = (
        #1071#1085#1074#1072#1088#1100
        #1060#1077#1074#1088#1072#1083#1100
        #1052#1072#1088#1090
        #1040#1087#1088#1077#1083#1100
        #1052#1072#1081
        #1048#1102#1085#1100
        #1048#1102#1083#1100
        #1040#1074#1075#1091#1089#1090
        #1057#1077#1085#1090#1103#1073#1088#1100
        #1054#1082#1090#1103#1073#1088#1100
        #1053#1086#1103#1073#1088#1100
        #1044#1077#1082#1072#1073#1088#1100)
    end
    object spGod: TSpinEdit
      Left = 208
      Top = 8
      Width = 73
      Height = 27
      MaxLength = 4
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
    end
  end
  object pDate: TPanel
    Left = 0
    Top = 41
    Width = 481
    Height = 447
    Align = alLeft
    Color = clGradientActiveCaption
    TabOrder = 1
    object sgMonth: TStringGrid
      Left = 1
      Top = 1
      Width = 479
      Height = 445
      Align = alClient
      ColCount = 7
      DefaultRowHeight = 25
      DefaultDrawing = False
      FixedColor = clGradientActiveCaption
      FixedCols = 0
      RowCount = 2
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected]
      TabOrder = 0
      OnDrawCell = sgMonthDrawCell
      OnSelectCell = sgMonthSelectCell
    end
  end
  object pTime: TPanel
    Left = 484
    Top = 41
    Width = 477
    Height = 447
    Align = alClient
    Color = clGradientActiveCaption
    TabOrder = 2
    object lDate: TLabel
      Left = 1
      Top = 1
      Width = 475
      Height = 21
      Align = alTop
      Alignment = taCenter
      Caption = #1063#1080#1089#1083#1086' '#1084#1077#1089#1103#1094
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object sgDayTime: TStringGrid
      Left = 1
      Top = 22
      Width = 475
      Height = 424
      Align = alClient
      DefaultColWidth = 90
      DefaultDrawing = False
      FixedColor = clGradientActiveCaption
      FixedCols = 0
      RowCount = 4
      Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
      TabOrder = 0
      OnDblClick = sgDayTimeDblClick
      OnDrawCell = sgDayTimeDrawCell
    end
  end
  object pMessage: TPanel
    Left = 0
    Top = 488
    Width = 961
    Height = 48
    Align = alBottom
    Color = clGradientInactiveCaption
    TabOrder = 3
    object lMessage: TLabel
      Left = 8
      Top = 8
      Width = 154
      Height = 19
      Caption = #1047#1076#1077#1089#1100' '#1073#1091#1076#1077#1090' '#1089#1086#1086#1073#1097#1077#1085#1080#1077
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
  end
  object mmRent: TMainMenu
    Left = 496
    object N1: TMenuItem
      Caption = #1060#1072#1081#1083
      object nSetting: TMenuItem
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        OnClick = nSettingClick
      end
    end
    object nSprav: TMenuItem
      Caption = #1057#1087#1088#1072#1074#1086#1095#1085#1080#1082#1080
      object nDress: TMenuItem
        Caption = #1055#1083#1072#1090#1100#1103
        OnClick = nDressClick
      end
      object N2: TMenuItem
        Caption = #1060#1072#1088#1090#1091#1082#1080
      end
    end
  end
  object ilRent: TImageList
    Left = 528
  end
end
