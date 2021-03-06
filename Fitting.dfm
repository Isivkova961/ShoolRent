object fFitting: TfFitting
  Left = 532
  Top = 247
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1088#1080#1084#1077#1088#1082#1072
  ClientHeight = 468
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 17
  object pButton: TPanel
    Left = 0
    Top = 0
    Width = 640
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
  end
  object pData: TPanel
    Left = 0
    Top = 41
    Width = 640
    Height = 386
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object lFIO: TLabel
      Left = 8
      Top = 16
      Width = 33
      Height = 17
      Caption = #1060#1048#1054
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lAdress: TLabel
      Left = 8
      Top = 40
      Width = 40
      Height = 17
      Caption = #1040#1076#1088#1077#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lTelefon: TLabel
      Left = 8
      Top = 64
      Width = 52
      Height = 17
      Caption = #1058#1077#1083#1077#1092#1086#1085
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lSchool: TLabel
      Left = 8
      Top = 88
      Width = 42
      Height = 17
      Caption = #1064#1082#1086#1083#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lClass: TLabel
      Left = 440
      Top = 88
      Width = 38
      Height = 17
      Caption = #1050#1083#1072#1089#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lForma: TLabel
      Left = 8
      Top = 112
      Width = 42
      Height = 17
      Caption = #1060#1086#1088#1084#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lNumForm: TLabel
      Left = 8
      Top = 136
      Width = 61
      Height = 17
      Caption = #8470' '#1092#1086#1088#1084#1099
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lNumApron: TLabel
      Left = 312
      Top = 136
      Width = 69
      Height = 17
      Caption = #8470' '#1092#1072#1088#1090#1091#1082#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lDateFit: TLabel
      Left = 8
      Top = 304
      Width = 94
      Height = 17
      Caption = #1044#1072#1090#1072' '#1087#1088#1080#1084#1077#1088#1082#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lDateExt: TLabel
      Left = 8
      Top = 328
      Width = 81
      Height = 17
      Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lDateRet: TLabel
      Left = 216
      Top = 328
      Width = 90
      Height = 17
      Caption = #1044#1072#1090#1072' '#1074#1086#1079#1074#1088#1072#1090#1072
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lKit: TLabel
      Left = 216
      Top = 304
      Width = 61
      Height = 17
      Caption = #1050#1086#1084#1087#1083#1077#1082#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lStatus: TLabel
      Left = 8
      Top = 352
      Width = 45
      Height = 17
      Caption = #1057#1090#1072#1090#1091#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object dbgDress: TDBGridEh
      Left = 8
      Top = 160
      Width = 297
      Height = 120
      DataSource = dmRent.dsDress
      FixedColor = clGradientActiveCaption
      Flat = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = RUSSIAN_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      Columns = <
        item
          EditButtons = <>
          FieldName = 'num_form'
          Footers = <>
          Title.Caption = #8470' '#1092#1086#1088#1084#1099
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'color'
          Footers = <>
          Title.Caption = #1062#1074#1077#1090
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'size'
          Footers = <>
          Title.Caption = #1056#1072#1079#1084#1077#1088
          Width = 48
        end
        item
          EditButtons = <>
          FieldName = 'leng_skird'
          Footers = <>
          Title.Caption = #1044#1083#1080#1085#1072' '#1102#1073#1082#1080
          Width = 45
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Footers = <>
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 47
        end>
    end
    object dbgApron: TDBGridEh
      Left = 312
      Top = 160
      Width = 321
      Height = 120
      DataSource = dmRent.dsApron
      FixedColor = clGradientActiveCaption
      Flat = False
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Times New Roman'
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = RUSSIAN_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      ParentFont = False
      TabOrder = 1
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clBlue
      TitleFont.Height = -13
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = [fsBold]
      UseMultiTitle = True
      Columns = <
        item
          EditButtons = <>
          FieldName = 'num_apr'
          Footers = <>
          Title.Caption = #8470' '#1092#1072#1088#1090#1091#1082#1072
          Width = 50
        end
        item
          EditButtons = <>
          FieldName = 'guip'
          Footers = <>
          Title.Caption = #1043#1080#1087#1102#1088
          Width = 57
        end
        item
          EditButtons = <>
          FieldName = 'size'
          Footers = <>
          Title.Caption = #1056#1072#1079#1084#1077#1088
          Width = 43
        end
        item
          EditButtons = <>
          FieldName = 'frill'
          Footers = <>
          Title.Caption = #1056#1102#1096#1080
          Width = 46
        end
        item
          EditButtons = <>
          FieldName = 'leng_strap'
          Footers = <>
          Title.Caption = #1044#1083#1080#1085#1072' '#1083#1103#1084#1082#1080
          Width = 47
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Footers = <>
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 48
        end>
    end
    object eNumForm: TEdit
      Left = 80
      Top = 128
      Width = 57
      Height = 25
      TabOrder = 2
    end
    object eNumApron: TEdit
      Left = 384
      Top = 128
      Width = 65
      Height = 25
      TabOrder = 3
    end
    object eFIO: TEdit
      Left = 80
      Top = 8
      Width = 465
      Height = 25
      TabOrder = 4
    end
    object eAdress: TEdit
      Left = 80
      Top = 32
      Width = 465
      Height = 25
      TabOrder = 5
    end
    object eTelefon: TEdit
      Left = 80
      Top = 56
      Width = 129
      Height = 25
      TabOrder = 6
    end
    object eSchool: TEdit
      Left = 80
      Top = 80
      Width = 353
      Height = 25
      TabOrder = 7
    end
    object cobClass: TComboBox
      Left = 488
      Top = 80
      Width = 57
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 8
      Items.Strings = (
        '9'
        '11')
    end
    object deDateFit: TDateEdit
      Left = 112
      Top = 296
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 9
    end
    object deDateExt: TDateEdit
      Left = 112
      Top = 320
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 10
    end
    object deDateRet: TDateEdit
      Left = 336
      Top = 320
      Width = 95
      Height = 25
      NumGlyphs = 2
      TabOrder = 11
    end
    object cobKit: TComboBox
      Left = 288
      Top = 296
      Width = 145
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 12
      Items.Strings = (
        #1055#1083#1072#1090#1100#1077
        #1060#1072#1088#1090#1091#1082
        #1055#1083#1072#1090#1100#1077' + '#1060#1072#1088#1090#1091#1082)
    end
    object cobStatus: TComboBox
      Left = 72
      Top = 344
      Width = 137
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 13
      Items.Strings = (
        #1042#1079#1103#1083#1080
        #1054#1090#1082#1072#1079)
    end
  end
  object pMessage: TPanel
    Left = 0
    Top = 427
    Width = 640
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
end
