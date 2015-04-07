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
    Height = 15
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    Color = clMoneyGreen
    ParentColor = False
    ExplicitLeft = -8
    ExplicitTop = 211
    ExplicitWidth = 792
  end
  object Splitter5: TSplitter
    Left = 0
    Top = 320
    Height = 203
    ExplicitLeft = 632
    ExplicitTop = 272
    ExplicitHeight = 100
  end
  object pcMain: TPageControl
    Left = 3
    Top = 320
    Width = 946
    Height = 203
    ActivePage = tsDetails
    Align = alClient
    TabOrder = 0
    OnChange = pcMainChange
    ExplicitWidth = 938
    object tsDetails: TTabSheet
      Caption = 'Details'
      ExplicitWidth = 930
      object memDetails: TMemo
        Left = 0
        Top = 0
        Width = 938
        Height = 175
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
        ExplicitWidth = 930
      end
    end
    object tsMarketOrders: TTabSheet
      Caption = 'Market Orders'
      ImageIndex = 1
      ExplicitWidth = 930
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
        Height = 77
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
        ExplicitWidth = 930
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
        ExplicitWidth = 930
      end
    end
    object tsMarketHistory: TTabSheet
      Caption = 'Market History'
      ImageIndex = 3
      ExplicitWidth = 930
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 938
        Height = 175
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
      ExplicitWidth = 930
      object chtMarketHistory: TDBChart
        Left = 0
        Top = 0
        Width = 938
        Height = 175
        Title.Text.Strings = (
          'TDBChart')
        View3D = False
        Align = alClient
        Color = clSilver
        TabOrder = 0
        AutoSize = True
        ExplicitWidth = 930
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
    ExplicitWidth = 941
    object TabSheet1: TTabSheet
      Caption = 'PI Watcher'
      ExplicitWidth = 933
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 933
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
        ExplicitWidth = 933
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
          ExplicitWidth = 474
        end
      end
    end
    object tsAnyItem: TTabSheet
      Caption = 'Any Item'
      ImageIndex = 1
      ExplicitWidth = 933
      DesignSize = (
        941
        277)
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 933
        object btnPopulateWatchList: TButton
          Left = 16
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Populate'
          TabOrder = 0
          OnClick = btnPopulateWatchListClick
        end
        object btnDeleteFromWatchList: TButton
          Left = 128
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Delete Item'
          TabOrder = 1
          OnClick = btnDeleteFromWatchListClick
        end
      end
      object dbgWatchList: TDBGrid
        Left = 440
        Top = 41
        Width = 501
        Height = 236
        Align = alRight
        DataSource = dmData.dsWatchList
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object txtSearch: TEdit
        Left = 219
        Top = 56
        Width = 127
        Height = 21
        TabOrder = 2
        OnKeyPress = txtSearchKeyPress
      end
      object btnSearch: TButton
        Left = 352
        Top = 54
        Width = 50
        Height = 25
        Caption = 'Search'
        TabOrder = 3
        OnClick = btnSearchClick
      end
      object DBGrid1: TDBGrid
        Left = 219
        Top = 109
        Width = 183
        Height = 132
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataSource = dsAllTypes
        TabOrder = 4
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
      object Button3: TButton
        Left = 245
        Top = 247
        Width = 125
        Height = 25
        Anchors = [akRight, akBottom]
        Caption = 'Add To WatchList'
        TabOrder = 5
        OnClick = Button3Click
      end
      object tvMarketGroups: TTreeView
        Left = 3
        Top = 63
        Width = 200
        Height = 202
        Anchors = [akLeft, akTop, akBottom]
        Indent = 19
        TabOrder = 6
        OnClick = tvMarketGroupsClick
        OnExpanded = tvMarketGroupsExpanded
      end
    end
    object tsManufacture: TTabSheet
      Caption = 'Manufacture'
      ImageIndex = 2
      ExplicitWidth = 933
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 41
        Align = alTop
        TabOrder = 0
        ExplicitWidth = 933
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 384
    Top = 264
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
