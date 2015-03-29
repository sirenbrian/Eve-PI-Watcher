object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Eve Planetary Interaction Watcher'
  ClientHeight = 523
  ClientWidth = 792
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 291
    Width = 792
    Height = 15
    Cursor = crVSplit
    Align = alTop
    Beveled = True
    Color = clMoneyGreen
    ParentColor = False
    ExplicitTop = 200
  end
  object Splitter5: TSplitter
    Left = 0
    Top = 306
    Height = 217
    ExplicitLeft = 632
    ExplicitTop = 272
    ExplicitHeight = 100
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 792
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitTop = -5
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
    Width = 792
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
      Width = 333
      Height = 248
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 1
    end
  end
  object pcMain: TPageControl
    Left = 3
    Top = 306
    Width = 789
    Height = 217
    ActivePage = tsMarketHistory
    Align = alClient
    TabOrder = 2
    OnChange = pcMainChange
    object tsDetails: TTabSheet
      Caption = 'Details'
      object memDetails: TMemo
        Left = 0
        Top = 0
        Width = 781
        Height = 189
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
        Width = 781
        Height = 9
        Cursor = crVSplit
        Align = alTop
        Beveled = True
        Color = clMoneyGreen
        ParentColor = False
        ExplicitLeft = -3
        ExplicitTop = 74
      end
      object lvMarketBuy: TListView
        Left = 0
        Top = 98
        Width = 781
        Height = 91
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
        Width = 781
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
        Width = 781
        Height = 189
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
      object chtMarketHistory: TDBChart
        Left = 0
        Top = 0
        Width = 781
        Height = 189
        Title.Text.Strings = (
          'TDBChart')
        View3D = False
        Align = alClient
        Color = clSilver
        TabOrder = 0
        AutoSize = True
        ExplicitLeft = 2
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
end
