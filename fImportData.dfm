object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 236
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveTextReader1
    Writer = FDBatchMoveDataSetWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 240
    Top = 136
  end
  object FDBatchMoveTextReader1: TFDBatchMoveTextReader
    FileName = 'C:\Source Code\PI Watcher\Data\PItypes.txt'
    DataDef.Fields = <
      item
        DataType = atString
        FieldSize = 30
      end
      item
        FieldName = 'PILevel'
        DataType = atLongInt
        FieldSize = 1
      end
      item
        FieldName = 'TypeID'
        DataType = atLongInt
        FieldSize = 7
      end
      item
        FieldName = 'outputQty'
        DataType = atNumber
      end>
    DataDef.Delimiter = '"'
    DataDef.Separator = #9
    DataDef.RecordFormat = rfCustom
    Left = 144
    Top = 104
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = dmData.fdmTypeIDs
    Left = 352
    Top = 96
  end
end
