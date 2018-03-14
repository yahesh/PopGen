object AnsichtForm: TAnsichtForm
  Left = 90
  Top = 13
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = '| Shorei | PopulationsGenetik - [Ansichtsfenster]'
  ClientHeight = 498
  ClientWidth = 665
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Courier New'
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
  Menu = AnsichtFormMainMenu
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object AnsichtFormDLabel: TLabel
    Left = 104
    Top = 8
    Width = 168
    Height = 14
    Caption = 'D = Homozygot - dominant'
  end
  object AnsichtFormHLabel: TLabel
    Left = 304
    Top = 8
    Width = 245
    Height = 14
    Caption = 'H = Heterozygot - dominant/rezessiv'
  end
  object AnsichtFormRLabel: TLabel
    Left = 104
    Top = 24
    Width = 168
    Height = 14
    Caption = 'R = Homozygot - rezessiv'
  end
  object AnsichtFormPLabel: TLabel
    Left = 304
    Top = 24
    Width = 231
    Height = 14
    Caption = 'Z = ph'#228'notypisch dominant (D + H)'
  end
  object MainFormObenBevel: TBevel
    Left = 0
    Top = -7
    Width = 671
    Height = 9
    Shape = bsBottomLine
  end
  object AnichtFormUntenBevel: TBevel
    Left = 10
    Top = 48
    Width = 641
    Height = 10
    Shape = bsTopLine
  end
  object AnsichtFormItemsListBox: TListBox
    Left = 8
    Top = 59
    Width = 97
    Height = 398
    ItemHeight = 14
    TabOrder = 0
    OnClick = AnsichtFormItemsListBoxClick
    OnKeyPress = AnsichtFormItemsListBoxKeyPress
  end
  object AnsichtFormScrollCheckBox: TCheckBox
    Left = 8
    Top = 480
    Width = 649
    Height = 17
    Caption = 
      '&automatisch scrollen (zum makieren von mehreren Zeilen bitte de' +
      'aktivieren)'
    Checked = True
    State = cbChecked
    TabOrder = 1
    OnClick = AnsichtFormScrollCheckBoxClick
  end
  object AnsichtFormTextListBox: TListBox
    Left = 104
    Top = 59
    Width = 553
    Height = 414
    ItemHeight = 14
    TabOrder = 2
    OnClick = AnsichtFormTextListBoxClick
    OnKeyPress = AnsichtFormTextListBoxKeyPress
  end
  object AnsichtFormMainMenu: TMainMenu
    Images = MainForm.MainFormImageList
    Left = 50
    Top = 10
    object AnsichtFormAnsichtMenuItem: TMenuItem
      Caption = 'A&nsicht'
      object AnsichtFormDruckenMenuItem: TMenuItem
        Caption = '&Drucken'
        ImageIndex = 4
        ShortCut = 16452
        OnClick = AnsichtFormDruckenMenuItemClick
      end
    end
  end
  object AnsichtFormPrintDialog: TPrintDialog
    Collate = True
    Options = [poSelection, poWarning, poDisablePrintToFile]
    Left = 570
    Top = 10
  end
  object AnsichtFormTextListBoxTimer: TTimer
    Interval = 200
    OnTimer = AnsichtFormTextListBoxTimerTimer
    Left = 8
    Top = 8
  end
end
