object formContasPagar: TformContasPagar
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsNone
  Caption = 'Contas a Pagar'
  ClientHeight = 492
  ClientWidth = 810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 810
    Height = 492
    Align = alClient
    BevelOuter = bvNone
    Color = clMenu
    Padding.Left = 10
    Padding.Right = 10
    Padding.Bottom = 10
    ParentBackground = False
    TabOrder = 0
    DesignSize = (
      810
      492)
    object pnlTitle: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 3
      Width = 784
      Height = 38
      Align = alTop
      BevelOuter = bvNone
      Color = clMenu
      ParentBackground = False
      TabOrder = 0
      object Label2: TLabel
        Left = 1
        Top = 9
        Width = 113
        Height = 21
        Caption = 'Contas a Pagar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnlContainer: TPanel
      AlignWithMargins = True
      Left = 13
      Top = 47
      Width = 784
      Height = 378
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      Color = clBtnHighlight
      ParentBackground = False
      TabOrder = 1
      DesignSize = (
        784
        378)
      object Label3: TLabel
        Left = 192
        Top = 10
        Width = 49
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Descri'#231#227'o'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 422
        Top = 10
        Width = 104
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Data de Vencimento'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 564
        Top = 10
        Width = 89
        Height = 13
        Anchors = [akTop, akRight]
        AutoSize = False
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label6: TLabel
        Left = 728
        Top = 6
        Width = 31
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Label6'
      end
      object Label13: TLabel
        Left = 14
        Top = 10
        Width = 75
        Height = 13
        Anchors = [akLeft, akTop, akRight]
        Caption = 'Filtrar por m'#234's'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object pnlSearch: TPanel
        AlignWithMargins = True
        Left = -3
        Top = 0
        Width = 790
        Height = 2
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = 4210688
        ParentBackground = False
        TabOrder = 0
      end
      object Panel5: TPanel
        AlignWithMargins = True
        Left = 14
        Top = 65
        Width = 760
        Height = 1
        Anchors = [akLeft, akTop, akRight]
        BevelOuter = bvNone
        Color = clGray
        ParentBackground = False
        TabOrder = 1
      end
      object btnDelete: TPanel
        Left = 689
        Top = 116
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'EXCLUIR'
        Color = clMaroon
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 2
      end
      object btnEdit: TPanel
        Left = 689
        Top = 76
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'EDITAR'
        Color = 7893767
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 3
      end
      object btnSave: TPanel
        Left = 689
        Top = 25
        Width = 80
        Height = 30
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'SALVAR'
        Color = 620302
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 4
        OnClick = btnSaveClick
      end
      object edDescricao: TEdit
        Left = 192
        Top = 29
        Width = 209
        Height = 25
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
      end
      object edValorTotal: TEdit
        Left = 564
        Top = 29
        Width = 110
        Height = 25
        Anchors = [akTop, akRight]
        AutoSize = False
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        Text = '0,00'
      end
      object edDataVenc: TDateTimePicker
        Left = 422
        Top = 29
        Width = 123
        Height = 25
        Anchors = [akTop, akRight]
        Date = 44832.000000000000000000
        Time = 0.770528842593194000
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
      end
      object Panel2: TPanel
        AlignWithMargins = True
        Left = 176
        Top = 8
        Width = 1
        Height = 51
        BevelOuter = bvNone
        Color = clSilver
        ParentBackground = False
        TabOrder = 8
      end
      object cbFiltroMeses: TComboBox
        Left = 14
        Top = 29
        Width = 145
        Height = 25
        Style = csDropDownList
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnChange = cbFiltroMesesChange
        Items.Strings = (
          'Janeiro'
          'Fevereiro'
          'Mar'#231'o'
          'Abril'
          'Maio'
          'Junho'
          'Julho'
          'Agosto'
          'Setembro'
          'Outubro'
          'Novembro'
          'Dezembro')
      end
      object btnGerarRelatorio: TPanel
        Left = 689
        Top = 156
        Width = 80
        Height = 29
        Cursor = crHandPoint
        Anchors = [akTop, akRight]
        BevelOuter = bvNone
        Caption = 'GERAR'
        Color = clMaroon
        DragCursor = crDefault
        Font.Charset = ANSI_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBackground = False
        ParentFont = False
        TabOrder = 10
        OnClick = btnGerarRelatorioClick
      end
      object DBGrid: TDBGrid
        Left = 14
        Top = 66
        Width = 660
        Height = 309
        BorderStyle = bsNone
        DrawingStyle = gdsGradient
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Product Sans'
        Font.Style = []
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection]
        ParentFont = False
        TabOrder = 11
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = 'Product Sans'
        TitleFont.Style = []
      end
    end
    object pnlValues: TPanel
      Left = 10
      Top = 427
      Width = 790
      Height = 55
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 2
      DesignSize = (
        790
        55)
      object Label7: TLabel
        Left = 90
        Top = 6
        Width = 96
        Height = 30
        Caption = 'Valor Total'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 592
        Top = 6
        Width = 119
        Height = 30
        Anchors = [akTop, akRight]
        Caption = 'Total a Pagar'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
      end
      object lblValorTotal: TLabel
        Left = 132
        Top = 30
        Width = 54
        Height = 21
        Alignment = taRightJustify
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lblTotalPagar: TLabel
        Left = 657
        Top = 30
        Width = 54
        Height = 21
        Alignment = taRightJustify
        Anchors = [akTop, akRight]
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label8: TLabel
        Left = 347
        Top = 6
        Width = 96
        Height = 30
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'Total Pago'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -21
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentBiDiMode = False
        ParentFont = False
      end
      object lblTotalPago: TLabel
        Left = 389
        Top = 30
        Width = 54
        Height = 21
        Alignment = taCenter
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BiDiMode = bdLeftToRight
        Caption = 'R$ 0,00'
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Segoe UI'
        Font.Style = [fsBold]
        ParentBiDiMode = False
        ParentFont = False
      end
    end
  end
end
