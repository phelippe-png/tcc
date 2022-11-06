object formRelatContasPagar: TformRelatContasPagar
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 511
  ClientWidth = 799
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object RLReport1: TRLReport
    Left = -3
    Top = 1
    Width = 794
    Height = 1123
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -13
    Font.Name = 'Arial'
    Font.Style = []
    object RLBand1: TRLBand
      Left = 38
      Top = 38
      Width = 718
      Height = 107
      BandType = btHeader
      object rllTitle: TRLLabel
        Left = 191
        Top = 67
        Width = 336
        Height = 32
        Caption = 'Relat'#243'rio Contas a Pagar'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -27
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RLDraw1: TRLDraw
        Left = 3
        Top = 105
        Width = 712
        Height = 1
        DrawKind = dkLine
      end
      object RLSystemInfo1: TRLSystemInfo
        Left = 3
        Top = 83
        Width = 39
        Height = 16
        Text = ''
      end
      object RLImage1: TRLImage
        Left = 3
        Top = 4
        Width = 60
        Height = 53
        Scaled = True
      end
    end
    object RLSystemInfo2: TRLSystemInfo
      Left = 714
      Top = 121
      Width = 39
      Height = 16
      Alignment = taRightJustify
      Info = itHour
      Text = ''
    end
    object RLBand2: TRLBand
      Left = 38
      Top = 145
      Width = 718
      Height = 32
      BandType = btHeader
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = True
      object RLDraw2: TRLDraw
        Left = 3
        Top = 105
        Width = 712
        Height = 1
        DrawKind = dkLine
      end
      object RLLabel1: TRLLabel
        Left = 16
        Top = 8
        Width = 62
        Height = 16
        Caption = 'Descri'#231#227'o'
      end
      object RLLabel2: TRLLabel
        Left = 248
        Top = 8
        Width = 122
        Height = 16
        Caption = 'Data de Vencimento'
      end
      object RLLabel3: TRLLabel
        Left = 438
        Top = 8
        Width = 66
        Height = 16
        Caption = 'Valor Total'
      end
      object RLLabel4: TRLLabel
        Left = 528
        Top = 8
        Width = 68
        Height = 16
        Caption = 'Valor Pago'
      end
      object RLLabel5: TRLLabel
        Left = 624
        Top = 8
        Width = 81
        Height = 16
        Caption = 'Total a Pagar'
      end
    end
    object RLBand3: TRLBand
      Left = 38
      Top = 177
      Width = 718
      Height = 40
      Borders.Sides = sdCustom
      Borders.DrawLeft = False
      Borders.DrawTop = False
      Borders.DrawRight = False
      Borders.DrawBottom = False
      object RLDBText1: TRLDBText
        Left = 16
        Top = 12
        Width = 70
        Height = 16
        Text = ''
      end
      object RLDBText2: TRLDBText
        Left = 248
        Top = 12
        Width = 70
        Height = 16
        Text = ''
      end
      object RLDBText3: TRLDBText
        Left = 438
        Top = 12
        Width = 70
        Height = 16
        Text = ''
      end
      object RLDBText4: TRLDBText
        Left = 528
        Top = 12
        Width = 70
        Height = 16
        Text = ''
      end
      object RLDBText5: TRLDBText
        Left = 624
        Top = 12
        Width = 70
        Height = 16
        Text = ''
      end
    end
  end
end
