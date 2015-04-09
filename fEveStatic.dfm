object frmEveStatic: TfrmEveStatic
  Left = 0
  Top = 0
  Caption = 'Eve Static Data'
  ClientHeight = 519
  ClientWidth = 680
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
    Left = 247
    Top = 224
    Width = 127
    Height = 97
    AutoSize = False
    Caption = 'Use FDBatchMove to load.'
    WordWrap = True
  end
  object grdAllTypes: TDBGrid
    Left = 8
    Top = 8
    Width = 217
    Height = 153
    DataSource = dsAllTypes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btnLoadAllTypes: TButton
    Left = 231
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 1
    OnClick = btnLoadAllTypesClick
  end
  object btnSaveAllTypes: TButton
    Left = 231
    Top = 47
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 2
    OnClick = btnSaveAllTypesClick
  end
  object DBGrid1: TDBGrid
    Left = 312
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
    Left = 535
    Top = 24
    Width = 75
    Height = 25
    Caption = 'Load'
    TabOrder = 4
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 535
    Top = 55
    Width = 75
    Height = 25
    Caption = 'Save'
    TabOrder = 5
    OnClick = Button2Click
  end
  object dbMaterials: TDBGrid
    Left = 8
    Top = 208
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
    Left = 160
    Top = 80
  end
  object dsAllGroups: TDataSource
    DataSet = dmEveStatic.fdmemGroups
    Left = 464
    Top = 88
  end
  object dsInputs: TDataSource
    DataSet = dmEveStatic.fdmInputs
    Left = 160
    Top = 280
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveTextReader1
    Writer = FDBatchMoveDataSetWriter1
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
      end>
    LogFileName = 'Data.log'
    AnalyzeSample = 500
    Left = 248
    Top = 400
  end
  object FDBatchMoveTextReader1: TFDBatchMoveTextReader
    FileName = 'C:\Source Code\PI Watcher\Data\invTypes2.csv'
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
        FieldSize = 100
      end
      item
        FieldName = 'marketGroupID'
        DataType = atString
        FieldSize = 4
      end>
    DataDef.Delimiter = '"'
    DataDef.Separator = ','
    DataDef.RecordFormat = rfCustom
    DataDef.WithFieldNames = True
    Left = 112
    Top = 400
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = dmEveStatic.fdmAllTypes
    Left = 376
    Top = 408
  end
end
