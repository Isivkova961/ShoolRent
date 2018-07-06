object fRentFitting: TfRentFitting
  Left = 278
  Top = 440
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1044#1072#1085#1085#1099#1077' '#1087#1086' '#1083#1102#1076#1103#1084', '#1087#1088#1080#1096#1077#1076#1097#1080#1084' '#1085#1072' '#1087#1088#1080#1084#1077#1088#1082#1091
  ClientHeight = 510
  ClientWidth = 1254
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
    Width = 1254
    Height = 41
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
  end
  object pData: TPanel
    Left = 0
    Top = 41
    Width = 1254
    Height = 428
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgFitting: TDBGridEh
      Left = 1
      Top = 1
      Width = 1252
      Height = 426
      Align = alClient
      DataSource = dmRent.dsFitting
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
          FieldName = 'FIO'
          Footers = <>
          Title.Caption = #1060#1048#1054
          Width = 209
        end
        item
          EditButtons = <>
          FieldName = 'adress'
          Footers = <>
          Title.Caption = #1040#1076#1088#1077#1089
          Width = 131
        end
        item
          EditButtons = <>
          FieldName = 'telefon'
          Footers = <>
          Title.Caption = #1058#1077#1083#1077#1092#1086#1085
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'shool'
          Footers = <>
          Title.Caption = #1064#1082#1086#1083#1072
          Width = 43
        end
        item
          EditButtons = <>
          FieldName = 'class'
          Footers = <>
          Title.Caption = #1050#1083#1072#1089#1089
          Width = 42
        end
        item
          EditButtons = <>
          FieldName = 'num_form'
          Footers = <>
          Title.Caption = #8470' '#1092#1086#1088#1084#1099
          Width = 51
        end
        item
          EditButtons = <>
          FieldName = 'color'
          Footers = <>
          Title.Caption = #1062#1074#1077#1090
          Width = 79
        end
        item
          EditButtons = <>
          FieldName = 'size'
          Footers = <>
          Title.Caption = #1056#1072#1079#1084#1077#1088
          Width = 75
        end
        item
          EditButtons = <>
          FieldName = 'date_fit'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1087#1088#1080#1084#1077#1088#1082#1080
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'date_ext'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1074#1099#1076#1072#1095#1080
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'date_ret'
          Footers = <>
          Title.Caption = #1044#1072#1090#1072' '#1074#1086#1079#1074#1088#1072#1090#1072
          Width = 70
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Footers = <>
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Width = 48
        end
        item
          EditButtons = <>
          FieldName = 'kit'
          Footers = <>
          Title.Caption = #1050#1086#1084#1087#1083#1077#1082#1090
          Width = 127
        end>
    end
  end
  object pMessage: TPanel
    Left = 0
    Top = 469
    Width = 1254
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
  end
end
