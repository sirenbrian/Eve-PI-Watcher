object frmEveStatic: TfrmEveStatic
  Left = 0
  Top = 0
  Caption = 'Eve Static Data'
  ClientHeight = 519
  ClientWidth = 929
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 735
    Top = 216
    Width = 127
    Height = 97
    AutoSize = False
    Caption = 'Use FDBatchMove to load.'
    WordWrap = True
  end
  object grdAllTypes: TDBGrid
    Left = 8
    Top = 8
    Width = 417
    Height = 369
    DataSource = dsAllTypes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnLoadAllTypes: TButton
    Left = 463
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 1
    OnClick = btnLoadAllTypesClick
  end
  object btnSaveAllTypes: TButton
    Left = 463
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = btnSaveAllTypesClick
  end
  object DBGrid1: TDBGrid
    Left = 592
    Top = 8
    Width = 217
    Height = 153
    DataSource = dsAllGroups
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object Button1: TButton
    Left = 815
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 815
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = Button2Click
  end
  object dbMaterials: TDBGrid
    Left = 496
    Top = 200
    Width = 233
    Height = 153
    DataSource = dsInputs
    TabOrder = 6
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dsAllTypes: TDataSource
    DataSet = dmEveStatic.fdmAllTypes
    Left = 248
    Top = 88
  end
  object dsAllGroups: TDataSource
    DataSet = dmEveStatic.fdmemGroups
    Left = 744
    Top = 88
  end
  object dsInputs: TDataSource
    DataSet = dmEveStatic.fdmInputs
    Left = 648
    Top = 272
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveTextReader1
    Writer = FDBatchMoveDataSetWriter1
    Options = [poClearDest, poIdentityInsert, poCreateDest]
    Mappings = <
      item
        SourceFieldName = 'typeID'
        DestinationFieldName = 'typeID'
      end
      item
        SourceFieldName = 'groupID'
        DestinationFieldName = 'groupID'
      end
      item
        SourceFieldName = 'typeName'
        DestinationFieldName = 'typeName'
      end
      item
        SourceFieldName = 'marketGroupID'
        DestinationFieldName = 'marketGroupID'
      end
      item
        SourceFieldName = 'metaGroupID'
        DestinationFieldName = 'metaGroupID'
      end>
    LogFileName = 'C:\Source Code\PI Watcher\Data\mylog.txt'
    Analyze = [taHeader]
    AnalyzeSample = 500
    Left = 192
    Top = 400
  end
  object FDBatchMoveTextReader1: TFDBatchMoveTextReader
    FileName = 'C:\Source Code\PI Watcher\Data\invTypes.txt'
    DataDef.Fields = <
      item
        FieldName = 'typeID'
        DataType = atLongInt
        FieldSize = 4
      end
      item
        FieldName = 'groupID'
        DataType = atLongInt
        FieldSize = 4
      end
      item
        FieldName = 'typeName'
        DataType = atString
        FieldSize = 80
      end
      item
        FieldName = 'marketGroupID'
        DataType = atLongInt
        FieldSize = 4
      end
      item
        FieldName = 'metaGroupID'
        DataType = atLongInt
        FieldSize = 1
      end>
    DataDef.Delimiter = '"'
    DataDef.Separator = ','
    DataDef.RecordFormat = rfCustom
    DataDef.WithFieldNames = True
    DataDef.FormatSettings.DateSeparator = '-'
    DataDef.FormatSettings.ShortDateFormat = 'yyyy/MM/dd'
    DataDef.FormatSettings.ShortTimeFormat = 'HH:mm:ss'
    DataDef.FormatSettings.NullVals.Strings = (
      'NULL')
    Left = 64
    Top = 400
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = dmEveStatic.fdmAllTypes
    Left = 312
    Top = 400
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 20
    Top = 5
  end
end
