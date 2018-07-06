object fRentDress: TfRentDress
  Left = 479
  Top = 395
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1055#1083#1072#1090#1100#1103
  ClientHeight = 391
  ClientWidth = 551
  Color = clBtnFace
  Font.Charset = RUSSIAN_CHARSET
  Font.Color = clWindowText
  Font.Height = -15
  Font.Name = 'Times New Roman'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 17
  object pFiltr: TPanel
    Left = 0
    Top = 0
    Width = 551
    Height = 73
    Align = alTop
    Color = clGradientActiveCaption
    TabOrder = 0
    object cebNumForm: TCheckBox
      Left = 8
      Top = 16
      Width = 89
      Height = 17
      Caption = #8470' '#1087#1083#1072#1090#1100#1103
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      OnClick = cebNumFormClick
    end
    object cebColor: TCheckBox
      Left = 8
      Top = 40
      Width = 97
      Height = 17
      Caption = #1062#1074#1077#1090
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = cebColorClick
    end
    object cebSize: TCheckBox
      Left = 200
      Top = 16
      Width = 97
      Height = 17
      Caption = #1056#1072#1079#1084#1077#1088
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = cebSizeClick
    end
    object cebLengSkird: TCheckBox
      Left = 200
      Top = 40
      Width = 113
      Height = 17
      Caption = #1044#1083#1080#1085#1072' '#1102#1073#1082#1080' >'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      OnClick = cebLengSkirdClick
    end
    object cebStatus: TCheckBox
      Left = 368
      Top = 16
      Width = 73
      Height = 17
      Caption = #1057#1090#1072#1090#1091#1089
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      OnClick = cebStatusClick
    end
    object cebYesStatus: TCheckBox
      Left = 440
      Top = 16
      Width = 65
      Height = 17
      Caption = #1042#1079#1103#1083#1080
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
      TabOrder = 5
      OnClick = cebYesStatusClick
    end
    object eNumForm: TEdit
      Left = 88
      Top = 8
      Width = 105
      Height = 25
      TabOrder = 6
      OnChange = eNumFormChange
    end
    object cobColor: TComboBox
      Left = 88
      Top = 32
      Width = 105
      Height = 25
      Style = csDropDownList
      ItemHeight = 17
      TabOrder = 7
      OnChange = cobColorChange
      Items.Strings = (
        #1050#1086#1088#1080#1095#1085#1077#1074#1099#1081
        #1063#1077#1088#1085#1099#1081
        #1057#1080#1085#1080#1081
        #1050#1088#1072#1089#1085#1099#1081
        #1057#1077#1088#1099#1081)
    end
    object eSize: TEdit
      Left = 312
      Top = 8
      Width = 49
      Height = 25
      TabOrder = 8
      OnChange = eSizeChange
    end
    object eLengSkird: TEdit
      Left = 312
      Top = 32
      Width = 49
      Height = 25
      TabOrder = 9
      OnChange = eLengSkirdChange
    end
  end
  object pData: TPanel
    Left = 0
    Top = 73
    Width = 551
    Height = 277
    Align = alClient
    Color = clGradientInactiveCaption
    TabOrder = 1
    object dbgDress: TDBGridEh
      Left = 1
      Top = 1
      Width = 549
      Height = 275
      Align = alClient
      DataSource = dmRent.dsDress
      FixedColor = clGradientActiveCaption
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = RUSSIAN_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -15
      FooterFont.Name = 'Times New Roman'
      FooterFont.Style = []
      Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = RUSSIAN_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -15
      TitleFont.Name = 'Times New Roman'
      TitleFont.Style = []
      UseMultiTitle = True
      OnKeyDown = dbgDressKeyDown
      Columns = <
        item
          Alignment = taLeftJustify
          EditButtons = <>
          FieldName = 'num_form'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Footers = <>
          Title.Caption = #8470' '#1087#1083#1072#1090#1100#1103
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -13
          Title.Font.Name = 'Times New Roman'
          Title.Font.Style = [fsBold]
          Width = 100
        end
        item
          EditButtons = <>
          FieldName = 'color'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Footers = <>
          Title.Caption = #1062#1074#1077#1090
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -13
          Title.Font.Name = 'Times New Roman'
          Title.Font.Style = [fsBold]
          Width = 133
        end
        item
          Alignment = taLeftJustify
          EditButtons = <>
          FieldName = 'size'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Footers = <>
          Title.Caption = #1056#1072#1079#1084#1077#1088
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -13
          Title.Font.Name = 'Times New Roman'
          Title.Font.Style = [fsBold]
          Width = 100
        end
        item
          Alignment = taLeftJustify
          EditButtons = <>
          FieldName = 'leng_skird'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Footers = <>
          Title.Caption = #1044#1083#1080#1085#1072' '#1102#1073#1082#1080
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -13
          Title.Font.Name = 'Times New Roman'
          Title.Font.Style = [fsBold]
          Width = 103
        end
        item
          EditButtons = <>
          FieldName = 'status'
          Font.Charset = RUSSIAN_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Times New Roman'
          Font.Style = []
          Footers = <>
          Title.Caption = #1057#1090#1072#1090#1091#1089
          Title.Font.Charset = RUSSIAN_CHARSET
          Title.Font.Color = clBlue
          Title.Font.Height = -13
          Title.Font.Name = 'Times New Roman'
          Title.Font.Style = [fsBold]
          Width = 100
        end>
    end
  end
  object pMessage: TPanel
    Left = 0
    Top = 350
    Width = 551
    Height = 41
    Align = alBottom
    Color = clGradientActiveCaption
    TabOrder = 2
    object lMessage: TLabel
      Left = 8
      Top = 8
      Width = 230
      Height = 19
      Caption = #1050#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1085#1072#1081#1076#1077#1085#1085#1099#1093' '#1079#1085#1072#1095#1077#1085#1080#1081':'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -16
      Font.Name = 'Times New Roman'
      Font.Style = []
      ParentFont = False
    end
    object lKol: TLabel
      Left = 248
      Top = 8
      Width = 10
      Height = 22
      Caption = '0'
      Font.Charset = RUSSIAN_CHARSET
      Font.Color = clBlue
      Font.Height = -19
      Font.Name = 'Times New Roman'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
