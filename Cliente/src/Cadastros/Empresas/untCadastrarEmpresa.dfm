object formCadastrarEmpresa: TformCadastrarEmpresa
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Cadastrar Empresa'
  ClientHeight = 447
  ClientWidth = 529
  Color = clBtnFace
  DefaultMonitor = dmDesktop
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  PrintScale = poNone
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 529
    Height = 389
    Align = alClient
    BevelOuter = bvNone
    Color = cl3DLight
    Padding.Left = 25
    Padding.Top = 15
    Padding.Right = 25
    ParentBackground = False
    TabOrder = 0
    object GroupBox1: TGroupBox
      Left = 25
      Top = 15
      Width = 479
      Height = 206
      Align = alTop
      Caption = 'Dados da Empresa'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object Panel5: TPanel
        Left = 2
        Top = 17
        Width = 475
        Height = 187
        Align = alClient
        BevelOuter = bvNone
        Padding.Left = 15
        Padding.Right = 15
        TabOrder = 0
        object Label2: TLabel
          Left = 24
          Top = 8
          Width = 64
          Height = 13
          Caption = 'Raz'#227'o Social'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Left = 24
          Top = 122
          Width = 52
          Height = 13
          Caption = 'CPF/CNPJ'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Left = 24
          Top = 64
          Width = 78
          Height = 13
          Caption = 'Nome Fantasia'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label4: TLabel
          Left = 169
          Top = 122
          Width = 92
          Height = 13
          Caption = 'Inscri'#231#227'o Estadual'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Left = 321
          Top = 122
          Width = 44
          Height = 13
          Caption = 'Telefone'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edRazao: TEdit
          Left = 24
          Top = 25
          Width = 425
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edFantasia: TEdit
          Left = 24
          Top = 83
          Width = 425
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edCPF_CNPJ: TEdit
          Left = 24
          Top = 141
          Width = 128
          Height = 23
          Color = clWhite
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 18
          NumbersOnly = True
          ParentFont = False
          TabOrder = 2
          OnChange = edCPF_CNPJChange
          OnKeyDown = edCPF_CNPJKeyDown
        end
        object edIE: TEdit
          Left = 169
          Top = 141
          Width = 136
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 3
        end
        object edTelefone: TEdit
          Left = 321
          Top = 141
          Width = 128
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
      end
    end
    object GroupBox2: TGroupBox
      Left = 25
      Top = 221
      Width = 479
      Height = 140
      Align = alTop
      Caption = 'Endere'#231'o'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      object Panel1: TPanel
        Left = 2
        Top = 17
        Width = 475
        Height = 121
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 0
        object Label10: TLabel
          Left = 382
          Top = 61
          Width = 14
          Height = 13
          Caption = 'UF'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Left = 24
          Top = 61
          Width = 31
          Height = 13
          Caption = 'Bairro'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Left = 24
          Top = 7
          Width = 20
          Height = 13
          Caption = 'CEP'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Left = 169
          Top = 7
          Width = 62
          Height = 13
          Caption = 'Logradouro'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Left = 382
          Top = 7
          Width = 43
          Height = 13
          Caption = 'N'#250'mero'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Left = 238
          Top = 61
          Width = 36
          Height = 13
          Caption = 'Cidade'
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Segoe UI'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edLogradouro: TEdit
          Left = 169
          Top = 26
          Width = 186
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object edNumero: TEdit
          Left = 382
          Top = 26
          Width = 67
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          NumbersOnly = True
          ParentFont = False
          TabOrder = 2
        end
        object edCidade: TEdit
          Left = 238
          Top = 80
          Width = 117
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object edBairro: TEdit
          Left = 24
          Top = 80
          Width = 186
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object edCEP: TEdit
          Left = 24
          Top = 26
          Width = 117
          Height = 23
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          MaxLength = 10
          ParentFont = False
          TabOrder = 0
          OnChange = edCEPChange
          OnKeyDown = edCEPKeyDown
        end
        object cbUF: TComboBox
          Left = 382
          Top = 80
          Width = 67
          Height = 23
          Style = csDropDownList
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = 'Segoe UI'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 389
    Width = 529
    Height = 58
    Align = alBottom
    BevelOuter = bvNone
    Color = cl3DLight
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    Padding.Left = 20
    Padding.Right = 20
    Padding.Bottom = 20
    ParentBackground = False
    ParentFont = False
    TabOrder = 1
    object btnSave: TPanel
      Left = 416
      Top = 0
      Width = 93
      Height = 38
      Cursor = crHandPoint
      Align = alRight
      BevelOuter = bvNone
      Caption = 'Salvar'
      Color = 489483
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 0
      OnClick = btnSaveClick
      OnMouseEnter = btnSaveMouseEnter
      OnMouseLeave = btnSaveMouseLeave
    end
    object btnCancel: TPanel
      Left = 20
      Top = 0
      Width = 93
      Height = 38
      Cursor = crHandPoint
      Align = alLeft
      BevelOuter = bvNone
      Caption = 'Cancelar'
      Color = clRed
      DragCursor = crDefault
      Font.Charset = ANSI_CHARSET
      Font.Color = clWhite
      Font.Height = -13
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentBackground = False
      ParentFont = False
      TabOrder = 1
      OnClick = btnCancelClick
      OnMouseEnter = btnCancelMouseEnter
      OnMouseLeave = btnCancelMouseLeave
    end
  end
end
