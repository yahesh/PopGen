object ValuesForm: TValuesForm
  Left = 226
  Top = 149
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'Angaben drucken?'
  ClientHeight = 205
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    0000000000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000001111100001111001100110000000000
    1111111101111110110011000000000011000011111110001100110000000000
    1101111111101110110011000000000011001111111001101110110000000000
    1100000000111110111111000000000001100000000111001101100000000000
    0111001100000000000000000000000000111111000000000000000000000000
    0001111000000000000000000000000000000000000000000000000000000000
    0000000000000000000000000000000000000000000000022000000000000000
    0000000000000002200000000000000000000000000000022000000000000000
    0000000000000002200000000000000000220000022200022222000000000000
    0022000022222002222220000000000000220000220022022002200000000000
    0022000022002202200220000000000000222200220022022002200000000000
    0022222002222202222220000000000000220220002220022222000000000000
    0022022000000000000000000000000000222220000000000000000000000000
    0022220000000000000000000000000000000000000000000000000000000000
    000000000000000000000000000000000000000000000000000000000000FFFF
    FFFFFFFFFFFFFFFFFFFFF83C333FF008133FF3C0733FF201133FF301913FF3FC
    103FF9FE327FF8CFFFFFFC0FFFFFFE1FFFFFFFFFFFFFFFFFFFFFFFFFE7FFFFFF
    E7FFFFFFE7FFFFFFE7FFFCF8E0FFFCF0607FFCF3267FFCF3267FFC33267FFC18
    207FFC9C60FFFC9FFFFFFC1FFFFFFC3FFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object ValuesFormFrageLabel: TLabel
    Left = 10
    Top = 10
    Width = 289
    Height = 13
    Caption = 'Sollen die getätigten Angaben im Blattkopf gedruckt werden?'
  end
  object ValuesFormFitnessLabel: TLabel
    Left = 10
    Top = 70
    Width = 36
    Height = 13
    Caption = 'Fitness:'
  end
  object ValuesFormHowOftenDominantLabel: TLabel
    Left = 10
    Top = 110
    Width = 157
    Height = 13
    Caption = 'Häufigkeit des dominanten Gens:'
  end
  object ValuesFormHowOftenRezessivLabel: TLabel
    Left = 10
    Top = 130
    Width = 152
    Height = 13
    Caption = 'Häufigkeit des rezessiven Gens:'
  end
  object ValuesFormSelektionsKoeffizientLabel: TLabel
    Left = 10
    Top = 90
    Width = 100
    Height = 13
    Caption = 'Selektionskoeffizient:'
  end
  object ValuesFormSelektionGegenLabel: TLabel
    Left = 10
    Top = 50
    Width = 100
    Height = 13
    Caption = 'Selektion gegen das:'
  end
  object ValuesFormFitnessValueLabel: TLabel
    Left = 200
    Top = 70
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ValuesFormHowOftenDominantValueLabel: TLabel
    Left = 200
    Top = 110
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ValuesFormHowOftenRezessivValueLabel: TLabel
    Left = 200
    Top = 130
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ValuesFormSelektionsKoeffizientValueLabel: TLabel
    Left = 200
    Top = 90
    Width = 6
    Height = 13
    Caption = '0'
  end
  object ValuesFormSelektionGegenValueLabel: TLabel
    Left = 200
    Top = 50
    Width = 121
    Height = 13
    Caption = 'dominante/rezessive Gen'
  end
  object ValuesFormObenBevel: TBevel
    Left = 10
    Top = 40
    Width = 311
    Height = 5
    Shape = bsTopLine
  end
  object ValuesFormUntenBevel: TBevel
    Left = 10
    Top = 146
    Width = 311
    Height = 10
    Shape = bsBottomLine
  end
  object ValuesFormOKButton: TButton
    Left = 20
    Top = 170
    Width = 101
    Height = 25
    Caption = '&Ja'
    Default = True
    TabOrder = 0
    OnClick = ValuesFormOKButtonClick
  end
  object ValuesFormCancelButton: TButton
    Left = 210
    Top = 170
    Width = 101
    Height = 25
    Cancel = True
    Caption = '&Nein'
    TabOrder = 1
    OnClick = ValuesFormCancelButtonClick
  end
end
