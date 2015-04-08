object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Eve Planetary Interaction Watcher'
  ClientHeight = 523
  ClientWidth = 949
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 305
    Width = 949
    Height = 12
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    Color = clMoneyGreen
    ParentColor = False
  end
  object Splitter5: TSplitter
    Left = 0
    Top = 317
    Height = 206
    ExplicitLeft = 632
    ExplicitTop = 272
    ExplicitHeight = 100
  end
  object pcMain: TPageControl
    Left = 3
    Top = 317
    Width = 946
    Height = 206
    ActivePage = tsDetails
    Align = alClient
    TabOrder = 0
    OnChange = pcMainChange
    ExplicitTop = 320
    ExplicitHeight = 203
    object tsDetails: TTabSheet
      Caption = 'Details'
      ExplicitHeight = 175
      object memDetails: TMemo
        Left = 0
        Top = 0
        Width = 938
        Height = 178
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitHeight = 175
      end
    end
    object tsMarketOrders: TTabSheet
      Caption = 'Market Orders'
      ImageIndex = 1
      ExplicitHeight = 175
      object Splitter3: TSplitter
        Left = 0
        Top = 89
        Width = 938
        Height = 9
        Cursor = crVSplit
        Align = alTop
        Beveled = True
        Color = clMoneyGreen
        ParentColor = False
        ExplicitLeft = -3
        ExplicitTop = 74
        ExplicitWidth = 781
      end
      object lvMarketBuy: TListView
        Left = 0
        Top = 98
        Width = 938
        Height = 80
        Align = alClient
        Columns = <
          item
            Caption = 'Price'
            Width = 25
          end
          item
            Caption = 'Volume'
          end
          item
            Caption = 'Expiry'
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = lvMarketBuyColumnClick
        OnCompare = lvMarketBuyCompare
        ExplicitHeight = 77
      end
      object lvMarketSell: TListView
        Left = 0
        Top = 0
        Width = 938
        Height = 89
        Align = alTop
        Columns = <
          item
            Caption = 'Price'
            Width = 25
          end
          item
            Caption = 'Volume'
          end
          item
            Caption = 'Expiry'
          end>
        HideSelection = False
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        TabOrder = 1
        ViewStyle = vsReport
        OnColumnClick = lvMarketSellColumnClick
        OnCompare = lvMarketSellCompare
      end
    end
    object tsMarketHistory: TTabSheet
      Caption = 'Market History'
      ImageIndex = 3
      ExplicitHeight = 175
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 938
        Height = 178
        Align = alClient
        DataSource = dmData.dsMarketHistory
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'date'
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'lowPrice'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'highPrice'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'avgPrice'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'orderCount'
            Width = 50
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'volume'
            Width = 80
            Visible = True
          end>
      end
    end
    object tsMarketHistoryChart: TTabSheet
      Caption = 'Market History Chart'
      ImageIndex = 2
      ExplicitHeight = 175
      object chtMarketHistory: TDBChart
        Left = 0
        Top = 0
        Width = 938
        Height = 178
        Title.Text.Strings = (
          'TDBChart')
        View3D = False
        Align = alClient
        Color = clSilver
        TabOrder = 0
        AutoSize = True
        ExplicitHeight = 175
        DefaultCanvas = 'TGDIPlusCanvas'
        PrintMargins = (
          15
          26
          15
          26)
        ColorPaletteIndex = 6
        object Series1: TLineSeries
          DataSource = dmData.mtMarketHistory
          SeriesColor = clBlack
          Title = 'Average'
          XLabelsSource = 'date'
          Brush.BackColor = clDefault
          DrawStyle = dsAll
          Pointer.InflateMargins = True
          Pointer.Style = psRectangle
          XValues.DateTime = True
          XValues.Name = 'X'
          XValues.Order = loAscending
          XValues.ValueSource = 'date'
          YValues.Name = 'Y'
          YValues.Order = loNone
          YValues.ValueSource = 'avgPrice'
          Transparency = 34
        end
      end
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 949
    Height = 305
    ActivePage = tsAnyItem
    Align = alTop
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'PI Watcher'
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 41
        Align = alTop
        TabOrder = 0
        object btnGetPrices: TButton
          Left = 152
          Top = 10
          Width = 97
          Height = 25
          Caption = 'Fresh Prices!'
          TabOrder = 0
          OnClick = btnGetPricesClick
        end
        object btnuseLast: TButton
          Left = 8
          Top = 10
          Width = 129
          Height = 25
          Caption = 'Read Prices From File'
          TabOrder = 1
          OnClick = btnuseLastClick
        end
        object btnViewData: TButton
          Left = 448
          Top = 9
          Width = 75
          Height = 25
          Caption = 'View Tables'
          TabOrder = 2
          OnClick = btnViewDataClick
        end
        object Button1: TButton
          Left = 536
          Top = 10
          Width = 113
          Height = 25
          Caption = 'View Raw JSON'
          TabOrder = 3
          OnClick = Button1Click
        end
        object btnNameSearch: TButton
          Left = 664
          Top = 10
          Width = 97
          Height = 25
          Caption = 'Test Name Search'
          TabOrder = 4
          OnClick = btnNameSearchClick
        end
        object btnShowChildren: TButton
          Left = 264
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Show Children'
          TabOrder = 5
          OnClick = btnShowChildrenClick
        end
        object Button2: TButton
          Left = 352
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Show All'
          TabOrder = 6
          OnClick = btnuseLastClick
        end
      end
      object pnlTop: TPanel
        Left = 0
        Top = 41
        Width = 941
        Height = 250
        Align = alTop
        TabOrder = 1
        object Splitter2: TSplitter
          Left = 451
          Top = 1
          Width = 7
          Height = 248
          Color = clMoneyGreen
          ParentColor = False
          ExplicitLeft = 433
          ExplicitTop = 6
          ExplicitHeight = 206
        end
        object lvPI: TListView
          Left = 1
          Top = 1
          Width = 450
          Height = 248
          Align = alLeft
          Columns = <
            item
              Caption = 'Lvl'
              Width = 25
            end
            item
              Caption = 'Name'
              Width = 85
            end
            item
              Caption = 'Sell'
              Width = 85
            end
            item
              Caption = 'Buy'
              Width = 85
            end
            item
              Caption = 'Make (B)'
              Width = 85
            end
            item
              Caption = 'Make (S)'
              Width = 85
            end
            item
              Caption = 'Profit (B)'
              Width = 75
            end
            item
              Caption = 'Profit (S)'
              Width = 75
            end>
          HideSelection = False
          MultiSelect = True
          ReadOnly = True
          RowSelect = True
          TabOrder = 0
          ViewStyle = vsReport
          OnColumnClick = lvPIColumnClick
          OnCompare = lvPICompare
          OnSelectItem = lvPISelectItem
        end
        object memInputReport: TMemo
          Left = 458
          Top = 1
          Width = 482
          Height = 248
          Align = alClient
          ScrollBars = ssVertical
          TabOrder = 1
        end
      end
    end
    object tsAnyItem: TTabSheet
      Caption = 'Any Item'
      ImageIndex = 1
      object Splitter4: TSplitter
        Left = 200
        Top = 41
        Width = 6
        Height = 236
        Color = clMoneyGreen
        ParentColor = False
      end
      object Splitter6: TSplitter
        Left = 436
        Top = 41
        Width = 6
        Height = 236
        Color = clMoneyGreen
        ParentColor = False
        ExplicitLeft = 428
        ExplicitTop = 39
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 41
        Align = alTop
        TabOrder = 0
        object btnPopulateWatchList: TButton
          Left = 442
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Populate'
          TabOrder = 0
          OnClick = btnPopulateWatchListClick
        end
        object btnDeleteFromWatchList: TButton
          Left = 617
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Delete Item'
          TabOrder = 1
          OnClick = btnDeleteFromWatchListClick
        end
      end
      object dbgWatchList: TDBGrid
        Left = 442
        Top = 41
        Width = 499
        Height = 236
        Align = alClient
        DataSource = dmData.dsWatchList
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object tvMarketGroups: TTreeView
        Left = 0
        Top = 41
        Width = 200
        Height = 236
        Align = alLeft
        Indent = 19
        ReadOnly = True
        TabOrder = 2
        OnClick = tvMarketGroupsClick
        OnExpanding = tvMarketGroupsExpanding
        OnExpanded = tvMarketGroupsExpanded
        ExplicitLeft = 3
        ExplicitTop = 63
        ExplicitHeight = 194
      end
      object Panel4: TPanel
        Left = 206
        Top = 41
        Width = 230
        Height = 236
        Align = alLeft
        TabOrder = 3
        DesignSize = (
          230
          236)
        object lblSearchCount: TLabel
          Left = 9
          Top = 213
          Width = 3
          Height = 13
        end
        object txtSearch: TEdit
          Left = 10
          Top = 8
          Width = 157
          Height = 21
          TabOrder = 0
          OnKeyPress = txtSearchKeyPress
        end
        object btnSearch: TButton
          Left = 179
          Top = 6
          Width = 44
          Height = 25
          Caption = 'Search'
          TabOrder = 1
          OnClick = btnSearchClick
        end
        object DBGrid1: TDBGrid
          Left = 7
          Top = 56
          Width = 216
          Height = 147
          Anchors = [akLeft, akTop, akRight, akBottom]
          DataSource = dsAllTypes
          TabOrder = 2
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'Tahoma'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'typeName'
              Width = 200
              Visible = True
            end>
        end
        object btnAddToWatchList: TButton
          Left = 79
          Top = 208
          Width = 125
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Add To WatchList'
          TabOrder = 3
          OnClick = btnAddToWatchListClick
          ExplicitLeft = 34
        end
        object rbInGroup: TRadioButton
          Left = 10
          Top = 34
          Width = 89
          Height = 17
          Caption = 'Within Group'
          Checked = True
          TabOrder = 4
          TabStop = True
        end
        object rbAllTypes: TRadioButton
          Left = 98
          Top = 33
          Width = 89
          Height = 17
          Caption = 'All Types'
          TabOrder = 5
        end
      end
    end
    object tsManufacture: TTabSheet
      Caption = 'Manufacture'
      ImageIndex = 2
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 41
        Align = alTop
        TabOrder = 0
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 872
    object File1: TMenuItem
      Caption = '&File'
      object ManageStatic1: TMenuItem
        Caption = '&Manage Static'
        OnClick = ManageStatic1Click
      end
    end
    object Actions1: TMenuItem
      Caption = 'Actions'
      object InitBuildandWatch1: TMenuItem
        Caption = 'Init Build and Watch'
        OnClick = InitBuildandWatch1Click
      end
    end
  end
  object dsAllTypes: TDataSource
    AutoEdit = False
    DataSet = dmEveStatic.fdmAllTypes
    Left = 328
    Top = 184
  end
end
