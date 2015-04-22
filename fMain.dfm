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
  object pcLower: TPageControl
    Left = 3
    Top = 317
    Width = 946
    Height = 206
    ActivePage = tsMarketHistory
    Align = alClient
    TabOrder = 0
    OnChange = pcLowerChange
    object tsDetails: TTabSheet
      Caption = 'Details'
      object memDetails: TMemo
        Left = 0
        Top = 0
        Width = 938
        Height = 178
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
    object tsMarketOrders: TTabSheet
      Caption = 'Market Orders'
      ImageIndex = 1
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
        OnTitleClick = DBGrid3TitleClick
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
      object chtMarketHistory: TDBChart
        Left = 0
        Top = 0
        Width = 938
        Height = 178
        Title.Text.Strings = (
          '')
        Legend.Visible = False
        Panning.MouseWheel = pmwNone
        View3D = False
        Zoom.MouseWheel = pmwNormal
        Align = alClient
        Color = clSilver
        TabOrder = 0
        AutoSize = True
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
    object tsInputs: TTabSheet
      Caption = 'Inputs'
      ImageIndex = 4
      object memInputReport: TMemo
        Left = 0
        Top = 0
        Width = 938
        Height = 178
        Align = alClient
        ScrollBars = ssVertical
        TabOrder = 0
      end
    end
  end
  object pcMain: TPageControl
    Left = 0
    Top = 0
    Width = 949
    Height = 305
    ActivePage = tsAnyItem
    Align = alTop
    TabOrder = 1
    object tsPI: TTabSheet
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
        object lvPI: TListView
          Left = 1
          Top = 1
          Width = 939
          Height = 248
          Align = alClient
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
      end
    end
    object tsAnyItem: TTabSheet
      Caption = 'Any Item'
      ImageIndex = 1
      object splB: TSplitter
        Left = 455
        Top = 59
        Width = 6
        Height = 218
        Color = clMoneyGreen
        ParentColor = False
        ExplicitLeft = 523
        ExplicitTop = 38
        ExplicitHeight = 236
      end
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 941
        Height = 59
        Align = alTop
        TabOrder = 0
        DesignSize = (
          941
          59)
        object btnPopulateWatchList: TButton
          Left = 345
          Top = 10
          Width = 75
          Height = 25
          Caption = 'Populate'
          TabOrder = 0
          OnClick = btnPopulateWatchListClick
        end
        object btnDeleteFromWatchList: TButton
          Left = 855
          Top = 28
          Width = 75
          Height = 25
          Anchors = [akRight, akBottom]
          Caption = 'Delete Item'
          TabOrder = 1
          OnClick = btnDeleteFromWatchListClick
        end
        object Button3: TButton
          Left = 16
          Top = 11
          Width = 105
          Height = 25
          Caption = 'Show/Hide Search'
          TabOrder = 2
          OnClick = Button3Click
        end
        object btnFindGroupFromWatchlist: TButton
          Left = 426
          Top = 11
          Width = 75
          Height = 25
          Caption = 'Find Group'
          TabOrder = 3
          OnClick = btnFindGroupFromWatchlistClick
        end
        object Button4: TButton
          Left = 127
          Top = 11
          Width = 92
          Height = 25
          Caption = 'Read Prices From File'
          TabOrder = 4
          OnClick = Button4Click
        end
        object rbInGroup: TRadioButton
          Left = 238
          Top = 3
          Width = 89
          Height = 17
          Caption = 'Within Group'
          TabOrder = 5
        end
        object rbAllTypes: TRadioButton
          Left = 238
          Top = 19
          Width = 71
          Height = 17
          Caption = 'All Types'
          TabOrder = 6
        end
        object btnSave: TButton
          Left = 507
          Top = 10
          Width = 56
          Height = 25
          Caption = '&Save'
          TabOrder = 7
          OnClick = btnSaveClick
        end
        object btnLoad: TButton
          Left = 569
          Top = 10
          Width = 42
          Height = 25
          Caption = '&Load'
          TabOrder = 8
          OnClick = btnLoadClick
        end
        object btnClearWatchList: TButton
          Left = 617
          Top = 10
          Width = 41
          Height = 25
          Caption = 'Clear'
          TabOrder = 9
          OnClick = btnClearWatchListClick
        end
        object cmbFiles: TComboBox
          Left = 672
          Top = 12
          Width = 177
          Height = 21
          Style = csDropDownList
          TabOrder = 10
          OnSelect = cmbFilesSelect
        end
        object chkTech1: TCheckBox
          Left = 345
          Top = 38
          Width = 97
          Height = 17
          Caption = 'Tech 1 Only'
          Checked = True
          State = cbChecked
          TabOrder = 11
        end
        object rbChildGroups: TRadioButton
          Left = 238
          Top = 36
          Width = 89
          Height = 17
          Caption = 'Child Groups'
          Checked = True
          TabOrder = 12
          TabStop = True
        end
      end
      object dbgWatchList: TDBGrid
        Left = 461
        Top = 59
        Width = 480
        Height = 218
        Align = alClient
        DataSource = dmData.dsWatchList
        TabOrder = 1
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgWatchListCellClick
        OnTitleClick = dbgWatchListTitleClick
      end
      object pnlGroupandSearch: TPanel
        Left = 0
        Top = 59
        Width = 455
        Height = 218
        Align = alLeft
        Caption = 'pnlGroupandSearch'
        TabOrder = 2
        object splA: TSplitter
          Left = 201
          Top = 1
          Width = 6
          Height = 216
          Color = clMoneyGreen
          ParentColor = False
          ExplicitLeft = 207
          ExplicitTop = 0
          ExplicitHeight = 234
        end
        object tvMarketGroups: TTreeView
          Left = 1
          Top = 1
          Width = 200
          Height = 216
          Align = alLeft
          HideSelection = False
          Indent = 19
          ReadOnly = True
          TabOrder = 0
          OnClick = tvMarketGroupsClick
          OnExpanding = tvMarketGroupsExpanding
        end
        object pnlSearch: TPanel
          Left = 207
          Top = 1
          Width = 247
          Height = 216
          Align = alClient
          TabOrder = 1
          DesignSize = (
            247
            216)
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
          object btnAddToWatchList: TButton
            Left = 41
            Top = 186
            Width = 125
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = 'Add To WatchList'
            TabOrder = 2
            OnClick = btnAddToWatchListClick
          end
          object btnFindGroup: TButton
            Left = 6
            Top = 186
            Width = 19
            Height = 25
            Anchors = [akLeft, akBottom]
            Caption = '<-'
            TabOrder = 3
            OnClick = btnFindGroupClick
          end
          object lvSearchResults: TListView
            Left = 10
            Top = 37
            Width = 217
            Height = 143
            Anchors = [akLeft, akTop, akRight, akBottom]
            Columns = <
              item
                AutoSize = True
                Caption = 'Name'
              end>
            MultiSelect = True
            ReadOnly = True
            RowSelect = True
            TabOrder = 4
            ViewStyle = vsReport
          end
          object btnAddGroup: TButton
            Left = 172
            Top = 186
            Width = 70
            Height = 25
            Anchors = [akRight, akBottom]
            Caption = 'Add Group'
            TabOrder = 5
            OnClick = btnAddGroupClick
          end
        end
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
end
