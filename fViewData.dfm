object frmViewData: TfrmViewData
  Left = 0
  Top = 0
  Caption = 'frmViewData'
  ClientHeight = 496
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 8
    Top = 8
    Width = 433
    Height = 120
    DataSource = dsInputs
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 16
    Top = 176
    Width = 377
    Height = 289
    DataSource = dsTypes
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Memo1: TMemo
    Left = 536
    Top = 176
    Width = 265
    Height = 289
    TabOrder = 2
  end
  object dsInputs: TDataSource
    DataSet = dmData.fdmInputs
    Left = 272
    Top = 48
  end
  object dsTypes: TDataSource
    DataSet = dmData.fdmTypeIDs
    Left = 272
    Top = 240
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
    object LinkControlToField1: TLinkControlToField
      Category = 'Quick Bindings'
      DataSource = dmData.respPrices
      FieldName = 'Content'
      Control = Memo1
      Track = False
    end
  end
end
