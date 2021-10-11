object MainForm: TMainForm
  Left = 219
  Top = 122
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Approx Pi'
  ClientHeight = 502
  ClientWidth = 730
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 120
  TextHeight = 16
  object DrawPanel: TPanel
    Left = 228
    Top = 0
    Width = 502
    Height = 502
    Align = alLeft
    BevelInner = bvLowered
    BevelOuter = bvLowered
    BorderStyle = bsSingle
    Color = clWhite
    TabOrder = 0
    object Img: TImage
      Left = 2
      Top = 2
      Width = 494
      Height = 494
      Align = alClient
    end
  end
  object ControlPanel: TPanel
    Left = 0
    Top = 0
    Width = 228
    Height = 502
    Align = alLeft
    TabOrder = 1
    object TitleLabel: TLabel
      Left = 105
      Top = 10
      Width = 91
      Height = 24
      Caption = 'Approx'#39'Pi'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -20
      Font.Name = 'Arial'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
    end
    object HeaderLabel: TLabel
      Left = 92
      Top = 49
      Width = 124
      Height = 16
      Caption = 'Panneau de controle'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsUnderline]
      ParentFont = False
    end
    object HelpBtn: TSpeedButton
      Left = 193
      Top = 404
      Width = 24
      Height = 30
      Caption = '?'
      OnClick = HelpBtnClick
    end
    object StatBox: TGroupBox
      Left = 10
      Top = 79
      Width = 208
      Height = 178
      Caption = ' Options statistiques '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object OffsetLbl: TLabel
        Left = 10
        Top = 30
        Width = 158
        Height = 16
        Caption = 'Nombre de points (Offset) :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object OffsetValue: TSpinEdit
        Left = 10
        Top = 49
        Width = 188
        Height = 26
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        MaxValue = 2000000000
        MinValue = 5
        ParentFont = False
        TabOrder = 0
        Value = 5
      end
      object RealtimeCheck: TCheckBox
        Left = 10
        Top = 79
        Width = 125
        Height = 21
        Caption = 'Voir en temps reel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
      end
      object UseCircle: TRadioButton
        Left = 10
        Top = 103
        Width = 100
        Height = 21
        Caption = 'Utiliser cercle'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
      end
      object UseArc: TRadioButton
        Left = 10
        Top = 128
        Width = 116
        Height = 21
        Caption = 'Utiliser quadrant'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        TabStop = True
      end
      object BigPointsBox: TCheckBox
        Left = 10
        Top = 153
        Width = 141
        Height = 21
        Caption = 'Faire des gros points'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        State = cbChecked
        TabOrder = 4
      end
    end
    object ResultBox: TGroupBox
      Left = 10
      Top = 266
      Width = 208
      Height = 129
      Caption = ' Resultat et performances '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      object Res_NbLbl: TLabel
        Left = 10
        Top = 25
        Width = 133
        Height = 16
        Caption = '[Aucun calcul effectue]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Res_TickLbl: TLabel
        Left = 10
        Top = 44
        Width = 133
        Height = 16
        Caption = '[Aucun calcul effectue]'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Res_PiLbl: TLabel
        Left = 10
        Top = 69
        Width = 62
        Height = 16
        Caption = 'Pi obtenu :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ExactPi: TLabel
        Left = 10
        Top = 102
        Width = 53
        Height = 16
        Caption = 'Pi exact :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ResEdit: TEdit
        Left = 78
        Top = 65
        Width = 119
        Height = 24
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 0
        Text = '[Aucun calcul]'
      end
    end
    object GoBtn: TButton
      Left = 10
      Top = 404
      Width = 90
      Height = 30
      Caption = 'Calculate Pi'
      TabOrder = 2
      OnClick = GoBtnClick
    end
    object QuitBtn: TButton
      Left = 107
      Top = 404
      Width = 79
      Height = 30
      Caption = 'Exit'
      TabOrder = 3
      OnClick = QuitBtnClick
    end
    object OperBox: TGroupBox
      Left = 10
      Top = 443
      Width = 208
      Height = 51
      Caption = ' Operation en cours '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -15
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
      TabOrder = 4
      object OperLbl: TLabel
        Left = 10
        Top = 20
        Width = 188
        Height = 21
        Alignment = taCenter
        AutoSize = False
        Caption = 'Pret !'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        WordWrap = True
      end
    end
    object Panel1: TPanel
      Left = 10
      Top = 10
      Width = 64
      Height = 61
      BevelInner = bvLowered
      BevelOuter = bvLowered
      BorderStyle = bsSingle
      Color = clWhite
      TabOrder = 5
      object Image1: TImage
        Left = 4
        Top = 4
        Width = 42
        Height = 40
        AutoSize = True
        Picture.Data = {
          0A544A504547496D61676559030000FFD8FFE000104A46494600010100000100
          010000FFDB004300090607080706090807080A0A090B0D160F0D0C0C0D1B1415
          1016201D2222201D1F1F2428342C242631271F1F2D3D2D3135373A3A3A232B3F
          443F384334393A37FFDB0043010A0A0A0D0C0D1A0F0F1A37251F253737373737
          3737373737373737373737373737373737373737373737373737373737373737
          37373737373737373737373737FFC00011080028002A03012200021101031101
          FFC400190000020301000000000000000000000000000805060704FFC4003510
          0001040102040207060700000000000001020304050006111221314107610813
          1432425191152281A1C1D1165355718292B2FFC4001401010000000000000000
          0000000000000000FFC40014110100000000000000000000000000000000FFDA
          000C03010002110311003F009FF17B5CD856BCCE99D2E1C72E65277714CA7896
          D20F40903E23D77EC39F7CC62FA975AD7455585EB36AD31C4125E90EA8F33D3A
          9C6474BE934D55C5B5DCF5B726D6C24295EB80E4D33F0B69DFC80DFE7F86547D
          22E586747448DBF37E6A7979252A3FB6063D0B48EB69D1199712B6CDD8EF202D
          B712A3B2927A11CF226C635E55D91AEB0F6C6260290595B878BEF6C477EFB8C6
          CF45B3ECFA4295AE9C3059FF00818BCEB759B1F1A9E475DEC9867E9C09FD3023
          BF81B5F7F48B5FF63FBE6A94D437ECD3C169E85312EA23B6958279821237EF9A
          EE18062FFE9196C9977B574ACAB7319B2EB807652C8007D13BFF00966DDA8EEA
          2E9EA4976B39403319B2ADB7D8ACF648F327618AAD6C897AC7C4386FCD3C6FCF
          B06CB80744A7886E079048FCB01B4AE63D96BE2C7FE532847D0018B1405FDA3E
          36B6B3CC2EF0ABF04B9BFE98D213B027E58A4E949EDC6F13604D90A0947DA80A
          D47A00A5EC4FE780DBE19CB6B3D8ABAD953E5282598CD29D59276E406F90955A
          86CAC6AE1CE14E1024B087820BFEEF1241DBDDF3C0A5FA42D6DC4FA1AF5D734E
          BD098794A94DB40A883B0E15103B0FBDFDB7CA77811A42C5FD50DDE4B88EB30A
          1A1450B75053EB1C236013BF5D81277C30C062B159F137405AE9FBF97223C379
          FAC90EA9D61E690541209DF855B74237DB9F5C30C0EBD1941AC75BBF1ABAC65D
          98A169692FAA438B0DF08F8520FBC7B0F96330CB48619432D2425B6D212948E8
          00E40618607FFFD9}
      end
    end
  end
end
