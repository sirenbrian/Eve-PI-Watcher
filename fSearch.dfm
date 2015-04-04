object frmSearch: TfrmSearch
  Left = 0
  Top = 0
  Caption = 'Search TEst'
  ClientHeight = 333
  ClientWidth = 362
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object txtSearch: TEdit
    Left = 16
    Top = 8
    Width = 161
    Height = 21
    TabOrder = 0
  end
  object btnSearch: TButton
    Left = 183
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Search'
    TabOrder = 1
    OnClick = btnSearchClick
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 64
    Width = 320
    Height = 241
    DataSource = dsAllTypes
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsAllTypes: TDataSource
    AutoEdit = False
    DataSet = dmEveStatic.fdmAllTypes
    Left = 168
    Top = 168
  end
end
