object dmData: TdmData
  OldCreateOrder = False
  Height = 416
  Width = 433
  object fdmInputs: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'ParentTypeID'
        DataType = ftInteger
      end
      item
        Name = 'ChildTypeID'
        DataType = ftInteger
      end
      item
        Name = 'Quantity'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode, evItems]
    FetchOptions.Mode = fmManual
    FetchOptions.Items = [fiMeta]
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockWait, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    AutoCommitUpdates = False
    StoreDefs = True
    Left = 24
    Top = 16
    Content = {
      414442530E001350AF130000FF00010001FF02FF03040016000000460044004D
      0065006D005400610062006C006500310005000A0000005400610062006C0065
      000600000000000700000800320000000900000A0000FF0BFF0C040018000000
      50006100720065006E0074005400790070006500490044000500180000005000
      6100720065006E0074005400790070006500490044000D00010000000F000E00
      1000011100011200011300011400011500011600180000005000610072006500
      6E007400540079007000650049004400FEFF0C0400160000004300680069006C
      0064005400790070006500490044000500160000004300680069006C00640054
      00790070006500490044000D00020000000F000E001000011100011200011300
      011400011500011600160000004300680069006C006400540079007000650049
      004400FEFF0C0400100000005100750061006E00740069007400790005001000
      00005100750061006E0074006900740079000D00030000000F000E0010000111
      00011200011300011400011500011600100000005100750061006E0074006900
      74007900FEFEFF17FEFF18FEFF19FF1A1B00000000001D001C00FF1E0000330B
      0000010032090000020006000000FEFEFF1A1B00010000001D001C00FF1E0000
      330B00000100F0430000020006000000FEFEFF1A1B00020000001D001C00FF1E
      0000330B00000100EA450000020006000000FEFEFF1A1B00030000001D001C00
      FF1E0000340B000001002C090000020006000000FEFEFF1A1B00040000001D00
      1C00FF1E0000340B000001003E090000020006000000FEFEFF1A1B0005000000
      1D001C00FF1E0000340B0000010076260000020006000000FEFEFF1A1B000600
      00001D001C00FF1E0000350B0000010038090000020006000000FEFEFF1A1B00
      070000001D001C00FF1E0000350B00000100F0420000020006000000FEFEFF1A
      1B00080000001D001C00FF1E0000350B000001005E090000020028000000FEFE
      FF1A1B00090000001D001C00FF1E0000360B0000010028090000020006000000
      FEFEFF1A1B000A0000001D001C00FF1E0000360B000001007826000002000600
      0000FEFEFF1A1B000B0000001D001C00FF1E0000360B00000100590900000200
      28000000FEFEFF1A1B000C0000001D001C00FF1E0000370B000001002A090000
      020006000000FEFEFF1A1B000D0000001D001C00FF1E0000370B000001006A26
      0000020006000000FEFEFF1A1B000E0000001D001C00FF1E0000370B00000100
      24320000020006000000FEFEFF1A1B000F0000001D001C00FF1E0000380B0000
      010029090000020006000000FEFEFF1A1B00100000001D001C00FF1E0000380B
      0000010030090000020006000000FEFEFF1A1B00110000001D001C00FF1E0000
      380B0000010039090000020006000000FEFEFF1A1B00120000001D001C00FF1E
      00003B0B000001002E710000020006000000FEFEFF1A1B00130000001D001C00
      FF1E00003B0B000001002F090000020006000000FEFEFF1A1B00140000001D00
      1C00FF1E00003B0B000001003D0E0000020028000000FEFEFF1A1B0015000000
      1D001C00FF1E00003C0B000001002D090000020006000000FEFEFF1A1B001600
      00001D001C00FF1E00003C0B0000010036090000020006000000FEFEFF1A1B00
      170000001D001C00FF1E00003C0B000001003F090000020006000000FEFEFF1A
      1B00180000001D001C00FF1E00003D0E00000100DC0800000200B80B0000FEFE
      FF1A1B00190000001D001C00FF1E0000630E00000100060900000200B80B0000
      FEFEFF1A1B001A0000001D001C00FF1E0000590900000100190800000200B80B
      0000FEFEFF1A1B001B0000001D001C00FF1E00005C0900000100F00800000200
      B80B0000FEFEFF1A1B001C0000001D001C00FF1E0000C30E00000100EE080000
      0200B80B0000FEFEFF1A1B001D0000001D001C00FF1E00006109000001000209
      00000200B80B0000FEFEFF1A1B001E0000001D001C00FF1E0000560900000100
      050900000200B80B0000FEFEFF1A1B001F0000001D001C00FF1E00005D090000
      0100010900000200B80B0000FEFEFF1A1B00200000001D001C00FF1E00005809
      00000100070900000200B80B0000FEFEFF1A1B00210000001D001C00FF1E0000
      550900000100040900000200B80B0000FEFEFF1A1B00220000001D001C00FF1E
      00005F0900000100DE0800000200B80B0000FEFEFF1A1B00230000001D001C00
      FF1E00005B0900000100EF0800000200B80B0000FEFEFF1A1B00240000001D00
      1C00FF1E00005E0900000100DB0800000200B80B0000FEFEFF1A1B0025000000
      1D001C00FF1E0000642600000100030900000200B80B0000FEFEFF1A1B002600
      00001D001C00FF1E0000600900000100E00800000200B80B0000FEFEFF1A1B00
      270000001D001C00FF1E00001909000001005C090000020028000000FEFEFF1A
      1B00280000001D001C00FF1E00001909000001005F090000020028000000FEFE
      FF1A1B00290000001D001C00FF1E0000F40E000001005E090000020028000000
      FEFEFF1A1B002A0000001D001C00FF1E0000F40E000001006009000002002800
      0000FEFEFF1A1B002B0000001D001C00FF1E00006C2600000100600900000200
      28000000FEFEFF1A1B002C0000001D001C00FF1E00006C260000010061090000
      020028000000FEFEFF1A1B002D0000001D001C00FF1E00006826000001005609
      0000020028000000FEFEFF1A1B002E0000001D001C00FF1E0000682600000100
      3D0E0000020028000000FEFEFF1A1B002F0000001D001C00FF1E00002C000000
      01005F090000020028000000FEFEFF1A1B00300000001D001C00FF1E00002C00
      0000010060090000020028000000FEFEFF1A1B00310000001D001C00FF1E0000
      6D0E0000010059090000020028000000FEFEFF1A1B00320000001D001C00FF1E
      00006D0E000001005B090000020028000000FEFEFF1A1B00330000001D001C00
      FF1E0000D53B000001005B090000020028000000FEFEFF1A1B00340000001D00
      1C00FF1E0000D53B00000100C30E0000020028000000FEFEFF1A1B0035000000
      1D001C00FF1E00008D0E000001005B090000020028000000FEFEFF1A1B003600
      00001D001C00FF1E00008D0E000001005C090000020028000000FEFEFF1A1B00
      370000001D001C00FF1E0000690E000001005E090000020028000000FEFEFF1A
      1B00380000001D001C00FF1E0000690E000001005F090000020028000000FEFE
      FF1A1B00390000001D001C00FF1E00001709000001005D090000020028000000
      FEFEFF1A1B003A0000001D001C00FF1E00001709000001006426000002002800
      0000FEFEFF1A1B003B0000001D001C00FF1E0000722600000100610900000200
      28000000FEFEFF1A1B003C0000001D001C00FF1E000072260000010064260000
      020028000000FEFEFF1A1B003D0000001D001C00FF1E00009F09000001005909
      0000020028000000FEFEFF1A1B003E0000001D001C00FF1E00009F0900000100
      5E090000020028000000FEFEFF1A1B003F0000001D001C00FF1E00000D090000
      010058090000020028000000FEFEFF1A1B00400000001D001C00FF1E00000D09
      00000100630E0000020028000000FEFEFF1A1B00410000001D001C00FF1E0000
      11090000010058090000020028000000FEFEFF1A1B00420000001D001C00FF1E
      00001109000001005D090000020028000000FEFEFF1A1B00430000001D001C00
      FF1E00006F0E000001005C090000020028000000FEFEFF1A1B00440000001D00
      1C00FF1E00006F0E000001005D090000020028000000FEFEFF1A1B0045000000
      1D001C00FF1E000066260000010055090000020028000000FEFEFF1A1B004600
      00001D001C00FF1E000066260000010056090000020028000000FEFEFF1A1B00
      470000001D001C00FF1E0000710E0000010058090000020028000000FEFEFF1A
      1B00480000001D001C00FF1E0000710E0000010064260000020028000000FEFE
      FF1A1B00490000001D001C00FF1E00006E260000010055090000020028000000
      FEFEFF1A1B004A0000001D001C00FF1E00006E26000001003D0E000002002800
      0000FEFEFF1A1B004B0000001D001C00FF1E0000080900000100630E00000200
      28000000FEFEFF1A1B004C0000001D001C00FF1E0000080900000100C30E0000
      020028000000FEFEFF1A1B004D0000001D001C00FF1E00006B0E000001005609
      0000020028000000FEFEFF1A1B004E0000001D001C00FF1E00006B0E00000100
      630E0000020028000000FEFEFF1A1B004F0000001D001C00FF1E00000F090000
      010059090000020028000000FEFEFF1A1B00500000001D001C00FF1E00000F09
      000001003D0E0000020028000000FEFEFF1A1B00510000001D001C00FF1E0000
      70260000010055090000020028000000FEFEFF1A1B00520000001D001C00FF1E
      000070260000010061090000020028000000FEFEFF1A1B00530000001D001C00
      FF1E0000BF0E0000010059090000020028000000FEFEFF1A1B00540000001D00
      1C00FF1E0000BF0E00000100C30E0000020028000000FEFEFF1A1B0055000000
      1D001C00FF1E00001809000001005E090000020028000000FEFEFF1A1B005600
      00001D001C00FF1E00001809000001003D0E0000020028000000FEFEFF1A1B00
      570000001D001C00FF1E00002909000001006626000002000A000000FEFEFF1A
      1B00580000001D001C00FF1E0000290900000100710E000002000A000000FEFE
      FF1A1B00590000001D001C00FF1E00002809000001000D09000002000A000000
      FEFEFF1A1B005A0000001D001C00FF1E00002809000001006826000002000A00
      0000FEFEFF1A1B005B0000001D001C00FF1E0000F04300000100080900000200
      0A000000FEFEFF1A1B005C0000001D001C00FF1E0000F0430000010017090000
      02000A000000FEFEFF1A1B005D0000001D001C00FF1E00006A26000001001809
      000002000A000000FEFEFF1A1B005E0000001D001C00FF1E00006A2600000100
      7026000002000A000000FEFEFF1A1B005F0000001D001C00FF1E000039090000
      01001109000002000A000000FEFEFF1A1B00600000001D001C00FF1E00003909
      00000100D53B000002000A000000FEFEFF1A1B00610000001D001C00FF1E0000
      EA45000001001109000002000A000000FEFEFF1A1B00620000001D001C00FF1E
      0000EA45000001007026000002000A000000FEFEFF1A1B00630000001D001C00
      FF1E00003809000001006D0E000002000A000000FEFEFF1A1B00640000001D00
      1C00FF1E00003809000001006F0E000002000A000000FEFEFF1A1B0065000000
      1D001C00FF1E00003209000001001909000002000A000000FEFEFF1A1B006600
      00001D001C00FF1E0000320900000100710E000002000A000000FEFEFF1A1B00
      670000001D001C00FF1E00003009000001001709000002000A000000FEFEFF1A
      1B00680000001D001C00FF1E00003009000001002C00000002000A000000FEFE
      FF1A1B00690000001D001C00FF1E0000782600000100690E000002000A000000
      FEFEFF1A1B006A0000001D001C00FF1E00007826000001006C26000002000A00
      0000FEFEFF1A1B006B0000001D001C00FF1E00002F0900000100F40E00000200
      0A000000FEFEFF1A1B006C0000001D001C00FF1E00002F090000010072260000
      02000A000000FEFEFF1A1B006D0000001D001C00FF1E00002A09000001000809
      000002000A000000FEFEFF1A1B006E0000001D001C00FF1E00002A0900000100
      0F09000002000A000000FEFEFF1A1B006F0000001D001C00FF1E000024320000
      01001909000002000A000000FEFEFF1A1B00700000001D001C00FF1E00002432
      000001009F09000002000A000000FEFEFF1A1B00710000001D001C00FF1E0000
      F042000001006B0E000002000A000000FEFEFF1A1B00720000001D001C00FF1E
      0000F042000001006E26000002000A000000FEFEFF1A1B00730000001D001C00
      FF1E00002E71000001008D0E000002000A000000FEFEFF1A1B00740000001D00
      1C00FF1E00002E7100000100BF0E000002000A000000FEFEFF1A1B0075000000
      1D001C00FF1E00003609000001009F09000002000A000000FEFEFF1A1B007600
      00001D001C00FF1E00003609000001008D0E000002000A000000FEFEFF1A1B00
      770000001D001C00FF1E0000360900000100F40E000002000A000000FEFEFF1A
      1B00780000001D001C00FF1E00003F09000001000F09000002000A000000FEFE
      FF1A1B00790000001D001C00FF1E00003F09000001006B0E000002000A000000
      FEFEFF1A1B007A0000001D001C00FF1E00003F09000001006D0E000002000A00
      0000FEFEFF1A1B007B0000001D001C00FF1E00002D0900000100180900000200
      0A000000FEFEFF1A1B007C0000001D001C00FF1E00002D090000010068260000
      02000A000000FEFEFF1A1B007D0000001D001C00FF1E00002D09000001006C26
      000002000A000000FEFEFF1A1B007E0000001D001C00FF1E0000762600000100
      0809000002000A000000FEFEFF1A1B007F0000001D001C00FF1E000076260000
      0100690E000002000A000000FEFEFF1A1B00800000001D001C00FF1E00007626
      000001007226000002000A000000FEFEFF1A1B00810000001D001C00FF1E0000
      3E09000001006F0E000002000A000000FEFEFF1A1B00820000001D001C00FF1E
      00003E0900000100BF0E000002000A000000FEFEFF1A1B00830000001D001C00
      FF1E00003E09000001007026000002000A000000FEFEFF1A1B00840000001D00
      1C00FF1E00002C09000001000D09000002000A000000FEFEFF1A1B0085000000
      1D001C00FF1E00002C09000001001909000002000A000000FEFEFF1A1B008600
      00001D001C00FF1E00002C09000001006E26000002000A000000FEFEFEFEFEFF
      1FFEFF2021009F000000FF22FEFEFE0E004D0061006E0061006700650072001E
      0055007000640061007400650073005200650067006900730074007200790012
      005400610062006C0065004C006900730074000A005400610062006C00650008
      004E0061006D006500140053006F0075007200630065004E0061006D0065000A
      0054006100620049004400240045006E0066006F0072006300650043006F006E
      00730074007200610069006E00740073001E004D0069006E0069006D0075006D
      0043006100700061006300690074007900180043006800650063006B004E006F
      0074004E0075006C006C001A0043006800650063006B0052006500610064004F
      006E006C007900140043006F006C0075006D006E004C006900730074000C0043
      006F006C0075006D006E00100053006F007500720063006500490044000E0064
      00740049006E0074003300320010004400610074006100540079007000650014
      00530065006100720063006800610062006C006500120041006C006C006F0077
      004E0075006C006C000800420061007300650014004F0041006C006C006F0077
      004E0075006C006C0012004F0049006E0055007000640061007400650010004F
      0049006E00570068006500720065001A004F0072006900670069006E0043006F
      006C004E0061006D0065001C0043006F006E00730074007200610069006E0074
      004C00690073007400100056006900650077004C006900730074000E0052006F
      0077004C00690073007400060052006F0077000A0052006F0077004900440016
      007200730055006E006300680061006E00670065006400100052006F00770053
      00740061007400650010004F0072006900670069006E0061006C001800520065
      006C006100740069006F006E004C006900730074001C00550070006400610074
      00650073004A006F00750072006E0061006C001200530061007600650050006F
      0069006E0074000E004300680061006E00670065007300}
    object fdmInputsParentTypeID: TIntegerField
      FieldName = 'ParentTypeID'
    end
    object fdmInputsChildTypeID: TIntegerField
      FieldName = 'ChildTypeID'
    end
    object fdmInputsQuantity: TIntegerField
      FieldName = 'Quantity'
    end
  end
  object fdmTypeIDs: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'TypeName'
        DataType = ftString
        Size = 20
      end
      item
        Name = 'PILevel'
        DataType = ftSmallint
      end
      item
        Name = 'TypeID'
        DataType = ftInteger
      end
      item
        Name = 'OutputQty'
        DataType = ftInteger
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode, evItems]
    FetchOptions.Mode = fmManual
    FetchOptions.Items = [fiMeta]
    ResourceOptions.AssignedValues = [rvPersistent, rvSilentMode]
    ResourceOptions.Persistent = True
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockWait, uvRefreshMode, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.UpdateChangedFields = False
    UpdateOptions.LockWait = True
    UpdateOptions.RefreshMode = rmManual
    UpdateOptions.CheckRequired = False
    UpdateOptions.CheckReadOnly = False
    UpdateOptions.CheckUpdatable = False
    AutoCommitUpdates = False
    StoreDefs = True
    Left = 24
    Top = 80
    Content = {
      414442530E001350D1120000FF00010001FF02FF03040014000000660064006D
      00540079007000650049004400730005000A0000005400610062006C00650006
      00000000000700000800320000000900000A0000FF0BFF0C0400100000005400
      7900700065004E0061006D00650005001000000054007900700065004E006100
      6D0065000D00010000000F000E00100014000000110001120001130001140001
      15000116000117001000000054007900700065004E0061006D00650018001400
      0000FEFF0C04000E000000500049004C006500760065006C0005000E00000050
      0049004C006500760065006C000D00020000000F001900110001120001130001
      14000115000116000117000E000000500049004C006500760065006C00FEFF0C
      04000C00000054007900700065004900440005000C0000005400790070006500
      490044000D00030000000F001A00110001120001130001140001150001160001
      17000C000000540079007000650049004400FEFF0C0400120000004F00750074
      007000750074005100740079000500120000004F007500740070007500740051
      00740079000D00040000000F001A001100011200011300011400011500011600
      011700120000004F0075007400700075007400510074007900FEFEFF1BFEFF1C
      FEFF1DFF1E1F000000000021002000FF2200000F000000417175656F7573204C
      697175696473010001000200DC080000030001000000FEFEFF1E1F0001000000
      21002000FF2200000A0000004175746F74726F70687301000100020001090000
      030001000000FEFEFF1E1F000200000021002000FF2200000B00000042617365
      204D6574616C73010001000200DB080000030001000000FEFEFF1E1F00030000
      0021002000FF22000010000000436172626F6E20436F6D706F756E6473010001
      000200F0080000030001000000FEFEFF1E1F000400000021002000FF22000011
      000000436F6D706C6578204F7267616E69736D73010001000200EF0800000300
      01000000FEFEFF1E1F000500000021002000FF2200000C00000046656C736963
      204D61676D6101000100020003090000030001000000FEFEFF1E1F0006000000
      21002000FF2200000C0000004865617679204D6574616C73010001000200E008
      0000030001000000FEFEFF1E1F000700000021002000FF2200000F000000496F
      6E696320536F6C7574696F6E7301000100020005090000030001000000FEFEFF
      1E1F000800000021002000FF2200000E0000004D6963726F6F7267616E69736D
      7301000100020019080000030001000000FEFEFF1E1F000900000021002000FF
      220000090000004E6F626C652047617301000100020006090000030001000000
      FEFEFF1E1F000A00000021002000FF2200000C0000004E6F626C65204D657461
      6C73010001000200DE080000030001000000FEFEFF1E1F000B00000021002000
      FF2200000F0000004E6F6E2D4353204372797374616C73010001000200020900
      00030001000000FEFEFF1E1F000C00000021002000FF22000011000000506C61
      6E6B74696320436F6C6F6E696573010001000200EE080000030001000000FEFE
      FF1E1F000D00000021002000FF2200000C000000526561637469766520476173
      01000100020007090000030001000000FEFEFF1E1F000E00000021002000FF22
      00001000000053757370656E64656420506C61736D6101000100020004090000
      030001000000FEFEFF1E1F000F00000021002000FF2200000500000057617465
      720100020002003D0E0000030014000000FEFEFF1E1F001000000021002000FF
      22000011000000496E647573747269616C204669626572730100020002005D09
      0000030014000000FEFEFF1E1F001100000021002000FF2200000F0000005265
      616374697665204D6574616C730100020002005E090000030014000000FEFEFF
      1E1F001200000021002000FF2200000800000042696F6675656C730100020002
      005C090000030014000000FEFEFF1E1F001300000021002000FF220000080000
      0050726F7465696E730100020002005B090000030014000000FEFEFF1E1F0014
      00000021002000FF2200000700000053696C69636F6E01000200020064260000
      030014000000FEFEFF1E1F001500000021002000FF2200000C000000546F7869
      63204D6574616C7301000200020060090000030014000000FEFEFF1E1F001600
      000021002000FF2200000C000000456C656374726F6C79746573010002000200
      56090000030014000000FEFEFF1E1F001700000021002000FF22000008000000
      426163746572696101000200020059090000030014000000FEFEFF1E1F001800
      000021002000FF220000060000004F787967656E010002000200630E00000300
      14000000FEFEFF1E1F001900000021002000FF2200000F00000050726563696F
      7573204D6574616C730100020002005F090000030014000000FEFEFF1E1F001A
      00000021002000FF2200001100000043686972616C2053747275637475726573
      01000200020061090000030014000000FEFEFF1E1F001B00000021002000FF22
      00000700000042696F6D617373010002000200C30E0000030014000000FEFEFF
      1E1F001C00000021002000FF220000120000004F786964697A696E6720436F6D
      706F756E6401000200020058090000030014000000FEFEFF1E1F001D00000021
      002000FF22000009000000506C61736D6F696473010002000200550900000300
      14000000FEFEFF1E1F001E00000021002000FF2200000800000042696F63656C
      6C7301000300020019090000030005000000FEFEFF1E1F001F00000021002000
      FF22000013000000436F6E737472756374696F6E20426C6F636B730100030002
      00F40E0000030005000000FEFEFF1E1F002000000021002000FF220000140000
      00436F6E73756D657220456C656374726F6E6963730100030002006C26000003
      0005000000FEFEFF1E1F002100000021002000FF22000007000000436F6F6C61
      6E7401000300020068260000030005000000FEFEFF1E1F002200000021002000
      FF22000010000000456E726963686564205572616E69756D0100030002002C00
      0000030005000000FEFEFF1E1F002300000021002000FF2200000A0000004665
      7274696C697A65720100030002006D0E0000030005000000FEFEFF1E1F002400
      000021002000FF2200001400000047656E65746963616C6C7920456E68616E63
      6564010003000200D53B0000030005000000FEFEFF1E1F002500000021002000
      FF220000090000004C69766573746F636B0100030002008D0E00000300050000
      00FEFEFF1E1F002600000021002000FF220000100000004D656368616E696361
      6C205061727473010003000200690E0000030005000000FEFEFF1E1F00270000
      0021002000FF220000140000004D6963726F666962657220536869656C64696E
      6701000300020017090000030005000000FEFEFF1E1F002800000021002000FF
      220000140000004D696E69617475726520456C656374726F6E69630100030002
      0072260000030005000000FEFEFF1E1F002900000021002000FF220000070000
      004E616E697465730100030002009F090000030005000000FEFEFF1E1F002A00
      000021002000FF220000060000004F78696465730100030002000D0900000300
      05000000FEFEFF1E1F002B00000021002000FF2200000B000000506F6C796172
      616D69647301000300020011090000030005000000FEFEFF1E1F002C00000021
      002000FF2200000C000000506F6C7974657874696C65730100030002006F0E00
      00030005000000FEFEFF1E1F002D00000021002000FF2200000B000000526F63
      6B6574204675656C01000300020066260000030005000000FEFEFF1E1F002E00
      000021002000FF2200000E00000053696C696361746520476C61737301000300
      0200710E0000030005000000FEFEFF1E1F002F00000021002000FF2200000F00
      00005375706572636F6E647563746F72730100030002006E2600000300050000
      00FEFEFF1E1F003000000021002000FF22000014000000537570657274656E73
      696C6520506C617374696301000300020008090000030005000000FEFEFF1E1F
      003100000021002000FF2200000D00000053796E746865746963204F696C0100
      030002006B0E0000030005000000FEFEFF1E1F003200000021002000FF220000
      0D000000546573742043756C74757265730100030002000F0900000300050000
      00FEFEFF1E1F003300000021002000FF2200000B0000005472616E736D697474
      657201000300020070260000030005000000FEFEFF1E1F003400000021002000
      FF2200000B000000566972616C204167656E74010003000200BF0E0000030005
      000000FEFEFF1E1F003500000021002000FF2200001000000057617465722D43
      6F6F6C65642043505501000300020018090000030005000000FEFEFF1E1F0036
      00000021002000FF2200001400000042696F7465636820526573656172636820
      52657001000400020036090000030003000000FEFEFF1E1F0037000000210020
      00FF2200000D00000043616D6572612044726F6E657301000400020029090000
      030003000000FEFEFF1E1F003800000021002000FF2200000B000000436F6E64
      656E736174657301000400020028090000030003000000FEFEFF1E1F00390000
      0021002000FF220000140000004372796F70726F74656374616E7420536F6C75
      740100040002003F090000030003000000FEFEFF1E1F003A00000021002000FF
      2200000A00000044617461204368697073010004000200F04300000300030000
      00FEFEFF1E1F003B00000021002000FF2200001300000047656C2D4D61747269
      782042696F70617374650100040002002C090000030003000000FEFEFF1E1F00
      3C00000021002000FF2200001000000047756964616E63652053797374656D73
      0100040002006A260000030003000000FEFEFF1E1F003D00000021002000FF22
      00001400000048617A6D617420446574656374696F6E20537973010004000200
      3E090000030003000000FEFEFF1E1F003E00000021002000FF22000012000000
      4865726D65746963204D656D6272616E65730100040002003909000003000300
      0000FEFEFF1E1F003F00000021002000FF22000014000000486967682D546563
      68205472616E736D69747465010004000200EA450000030003000000FEFEFF1E
      1F004000000021002000FF22000014000000496E647573747269616C20457870
      6C6F7369766501000400020038090000030003000000FEFEFF1E1F0041000000
      21002000FF220000070000004E656F636F6D7301000400020032090000030003
      000000FEFEFF1E1F004200000021002000FF220000100000004E75636C656172
      2052656163746F727301000400020030090000030003000000FEFEFF1E1F0043
      00000021002000FF22000012000000506C616E65746172792056656869636C65
      7301000400020076260000030003000000FEFEFF1E1F004400000021002000FF
      22000008000000526F626F7469637301000400020078260000030003000000FE
      FEFF1E1F004500000021002000FF2200000E000000536D61727466616220556E
      6974730100040002002F090000030003000000FEFEFF1E1F0046000000210020
      00FF2200000E0000005375706572636F6D7075746572730100040002002D0900
      00030003000000FEFEFF1E1F004700000021002000FF2200001200000053796E
      7468657469632053796E61707365730100040002002A090000030003000000FE
      FEFF1E1F004800000021002000FF220000140000005472616E736372616E6961
      6C204D6963726F636F01000400020024320000030003000000FEFEFF1E1F0049
      00000021002000FF22000014000000556B6F6D69205375706572636F6E647563
      746F72010004000200F0420000030003000000FEFEFF1E1F004A000000210020
      00FF2200000800000056616363696E65730100040002002E7100000300030000
      00FEFEFF1E1F004B00000021002000FF2200000E00000042726F616463617374
      204E6F6465010005000200330B0000030001000000FEFEFF1E1F004C00000021
      002000FF22000014000000496E7465677269747920526573706F6E7365204401
      0005000200340B0000030001000000FEFEFF1E1F004D00000021002000FF2200
      000C0000004E616E6F2D466163746F7279010005000200350B00000300010000
      00FEFEFF1E1F004E00000021002000FF220000140000004F7267616E6963204D
      6F72746172204170706C69010005000200360B0000030001000000FEFEFF1E1F
      004F00000021002000FF2200001400000052656375727369766520436F6D7075
      74696E6720010005000200370B0000030001000000FEFEFF1E1F005000000021
      002000FF2200001400000053656C662D4861726D6F6E697A696E6720506F7701
      0005000200380B0000030001000000FEFEFF1E1F005100000021002000FF2200
      001000000053746572696C6520436F6E64756974730100050002003B0B000003
      0001000000FEFEFF1E1F005200000021002000FF220000110000005765747761
      7265204D61696E6672616D650100050002003C0B0000030001000000FEFEFEFE
      FEFF23FEFF242500F9000000FF26FEFEFE0E004D0061006E0061006700650072
      001E005500700064006100740065007300520065006700690073007400720079
      0012005400610062006C0065004C006900730074000A005400610062006C0065
      0008004E0061006D006500140053006F0075007200630065004E0061006D0065
      000A0054006100620049004400240045006E0066006F0072006300650043006F
      006E00730074007200610069006E00740073001E004D0069006E0069006D0075
      006D0043006100700061006300690074007900180043006800650063006B004E
      006F0074004E0075006C006C001A0043006800650063006B0052006500610064
      004F006E006C007900140043006F006C0075006D006E004C006900730074000C
      0043006F006C0075006D006E00100053006F0075007200630065004900440018
      006400740041006E007300690053007400720069006E00670010004400610074
      00610054007900700065000800530069007A0065001400530065006100720063
      006800610062006C006500120041006C006C006F0077004E0075006C006C0008
      00420061007300650014004F0041006C006C006F0077004E0075006C006C0012
      004F0049006E0055007000640061007400650010004F0049006E005700680065
      00720065001A004F0072006900670069006E0043006F006C004E0061006D0065
      00140053006F007500720063006500530069007A0065000E006400740049006E
      007400310036000E006400740049006E007400330032001C0043006F006E0073
      0074007200610069006E0074004C00690073007400100056006900650077004C
      006900730074000E0052006F0077004C00690073007400060052006F0077000A
      0052006F0077004900440016007200730055006E006300680061006E00670065
      006400100052006F0077005300740061007400650010004F0072006900670069
      006E0061006C001800520065006C006100740069006F006E004C006900730074
      001C0055007000640061007400650073004A006F00750072006E0061006C0012
      00530061007600650050006F0069006E0074000E004300680061006E00670065
      007300}
    object fdmTypeIDsTypeName: TStringField
      FieldName = 'TypeName'
    end
    object fdmTypeIDsPILevel: TSmallintField
      FieldName = 'PILevel'
    end
    object fdmTypeIDsTypeID: TIntegerField
      FieldName = 'TypeID'
    end
    object fdmTypeIDsOutputQty: TIntegerField
      FieldName = 'OutputQty'
    end
  end
  object resClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'http://api.eve-central.com'
    Params = <>
    HandleRedirects = True
    Left = 96
    Top = 16
  end
  object reqPrices: TRESTRequest
    Client = resClient
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'typeid'
        Options = [poAutoCreated]
        Value = '34,35,36'
      end>
    Resource = 
      'api/marketstat/json?typeid={typeid}&regionlimit=10000002&usesyst' +
      'em=30000142'
    Response = respPrices
    SynchronizedEvents = False
    Left = 96
    Top = 72
  end
  object respPrices: TRESTResponse
    Left = 96
    Top = 128
  end
  object reqMarketOrders: TRESTRequest
    Client = resClient
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'typeid'
        Options = [poAutoCreated]
      end>
    Resource = 'api/quicklook?usesystem=30000142&typeid={typeid}'
    Response = respMarketOrders
    SynchronizedEvents = False
    Left = 176
    Top = 72
  end
  object respMarketOrders: TRESTResponse
    ContentType = 'text/xml'
    Left = 176
    Top = 128
  end
  object xmlMarketOrders: TXMLDocument
    Left = 144
    Top = 208
    DOMVendorDesc = 'MSXML'
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 36
    Top = 133
  end
  object reqMarketHistory: TRESTRequest
    Client = resClientEVE
    Params = <
      item
        Kind = pkURLSEGMENT
        name = 'regionid'
        Options = [poAutoCreated]
        Value = '10000002'
      end
      item
        Kind = pkURLSEGMENT
        name = 'typeid'
        Options = [poAutoCreated]
        Value = '27227'
      end>
    Resource = 'market/{regionid}/types/{typeid}/history/'
    Response = respMarketHistory
    SynchronizedEvents = False
    Left = 337
    Top = 64
  end
  object respMarketHistory: TRESTResponse
    ContentType = 'application/vnd.ccp.eve.MarketTypeHistoryCollection-v1+json'
    RootElement = 'items'
    Left = 337
    Top = 136
  end
  object mtMarketHistory: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    AutoCommitUpdates = False
    Left = 337
    Top = 240
    object mtMarketHistoryorderCount: TIntegerField
      FieldName = 'orderCount'
    end
    object mtMarketHistorylowPrice: TCurrencyField
      FieldName = 'lowPrice'
    end
    object mtMarketHistoryhighPrice: TCurrencyField
      FieldName = 'highPrice'
    end
    object mtMarketHistoryavgPrice: TCurrencyField
      FieldName = 'avgPrice'
    end
    object mtMarketHistoryvolume: TIntegerField
      FieldName = 'volume'
    end
    object mtMarketHistorydate: TDateTimeField
      FieldName = 'date'
    end
  end
  object dsMarketHistory: TDataSource
    DataSet = mtMarketHistory
    Left = 337
    Top = 312
  end
  object resClientEVE: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'UTF-8, *;q=0.8'
    AcceptEncoding = 'identity'
    BaseURL = 'https://public-crest.eveonline.com'
    Params = <>
    HandleRedirects = True
    Left = 344
    Top = 16
  end
end
