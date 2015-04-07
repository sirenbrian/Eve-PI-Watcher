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
    DataSource = dsPITypes
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid3: TDBGrid
    Left = 464
    Top = 24
    Width = 320
    Height = 185
    DataSource = dsAlltypes
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid4: TDBGrid
    Left = 464
    Top = 280
    Width = 320
    Height = 185
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsInputs: TDataSource
    DataSet = dmEveStatic.fdmInputs
    Left = 272
    Top = 48
  end
  object dsPITypes: TDataSource
    DataSet = dmData.fdmPITypeIDs
    Left = 184
    Top = 256
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
  end
  object dsAlltypes: TDataSource
    DataSet = dmEveStatic.fdmAllTypes
    Left = 512
    Top = 88
  end
  object DataSource1: TDataSource
    DataSet = dmEveStatic.fdmemGroups
    Left = 472
    Top = 240
  end
end
