unit ViewF;

interface

uses
  Messages, SysUtils, Forms, ExtCtrls, Printers, MainF, Classes, Controls,
  Dialogs, StdCtrls, Menus, Windows;

type
  TAnsichtForm = class(TForm)
    AnsichtFormItemsListBox: TListBox;
    AnsichtFormDLabel: TLabel;
    AnsichtFormHLabel: TLabel;
    AnsichtFormRLabel: TLabel;
    AnsichtFormPLabel: TLabel;
    MainFormObenBevel: TBevel;
    AnsichtFormScrollCheckBox: TCheckBox;
    AnsichtFormMainMenu: TMainMenu;
    AnsichtFormAnsichtMenuItem: TMenuItem;
    AnsichtFormDruckenMenuItem: TMenuItem;
    AnichtFormUntenBevel: TBevel;
    AnsichtFormPrintDialog: TPrintDialog;
    AnsichtFormTextListBox: TListBox;
    AnsichtFormTextListBoxTimer: TTimer;

    procedure AnsichtFormDruckenMenuItemClick(Sender: TObject);
    procedure AnsichtFormItemsListBoxClick(Sender: TObject);
    procedure AnsichtFormItemsListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure AnsichtFormScrollCheckBoxClick(Sender: TObject);
    procedure AnsichtFormTextListBoxClick(Sender: TObject);
    procedure AnsichtFormTextListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure AnsichtFormTextListBoxTimerTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
    procedure ShowValuesForm(AValues : TValues);
  public
    { Public-Deklarationen }
    LastBreite  : Integer;
    LastValues  : TValues;
    PrintValues : Boolean;
  end;

var
  AnsichtForm: TAnsichtForm;

implementation

uses
  ValuesF;

{$R *.DFM}

procedure TAnsichtForm.AnsichtFormDruckenMenuItemClick(Sender: TObject);
var
  Index       : Integer;
  PrintHeight : Integer;
  PrintLine   : Integer;
  Text        : TStrings;
begin
  try
    if AnsichtFormPrintDialog.Execute then
    begin
      Printer.Canvas.Font.Name := 'Courier New';

      ShowValuesForm(LastValues);

      try
        Text := TStringList.Create;

        if (AnsichtFormPrintDialog.PrintRange = prAllPages) then
          Text.Assign(AnsichtFormTextListBox.Items)
        else
        begin
          Text.Add(AnsichtFormTextListBox.Items[0]);
          Text.Add(AnsichtFormTextListBox.Items[1]);

          for Index := 0 to Pred(AnsichtFormTextListBox.Items.Count) do
          begin
            if (AnsichtFormTextListBox.Selected[Index]) then
            begin
              if not((Index = 0) or (Index = 1)) then
                Text.Add(AnsichtFormTextListBox.Items[Index]);
            end;
          end;
        end;

        try
          PrintLine := 0;

          Printer.Title := '';
          if (PrintValues) then
          begin
            if LastValues.UseDominantGen then
            begin
              Printer.Title := 'SgDG / ' +
                               'FdDG = ' + FloatToStr(LastValues.Fitness) + ' / ';
            end
            else
            begin
              Printer.Title := 'SgRG / ' +
                               'FdRG = ' + FloatToStr(LastValues.Fitness) + ' / ';
            end;

            Printer.Title := Printer.Title + 'HdDG = ' + FloatToStr(LastValues.HowOftenDominant) + ' / ' +
                                             'HdRG = ' + FloatToStr(LastValues.HowOftenRezessiv) + ' / ' +
                                             'SKE  = ' + FloatToStr(LastValues.SelektionsKoeffizient);
          end;
          
          Printer.BeginDoc;

          PrintHeight := Printer.Canvas.TextHeight('AAA') * 2;

          Printer.Canvas.TextOut(25, 25 + PrintHeight, Printer.Title);
          Inc(PrintHeight, Printer.Canvas.TextHeight(Printer.Title));

          PrintHeight := PrintHeight + Printer.Canvas.TextHeight('AAA') * 2;

          while (PrintLine < Text.Count) do
          begin
            if (PrintHeight >= Printer.PageHeight - 50) then
            begin
              Printer.NewPage;

              PrintHeight := Printer.Canvas.TextHeight('AAA') * 2;

              Printer.Canvas.TextOut(25, 25 + PrintHeight, Printer.Title);
              Inc(PrintHeight, Printer.Canvas.TextHeight(Printer.Title));

              PrintHeight := PrintHeight + Printer.Canvas.TextHeight('AAA') * 2;

              Printer.Canvas.TextOut(25, 25 + PrintHeight, Text[0]);
              Inc(PrintHeight, Printer.Canvas.TextHeight(Text[0]));

              Printer.Canvas.TextOut(25, 25 + PrintHeight, Text[1]);
              Inc(PrintHeight, Printer.Canvas.TextHeight(Text[1]));
            end;

            Printer.Canvas.TextOut(25, 25 + PrintHeight, Text[PrintLine]);
            Inc(PrintHeight, Printer.Canvas.TextHeight(Text[PrintLine]));

            Inc(PrintLine);
          end;
        finally
          Printer.EndDoc;
        end;
      finally
        FreeAndNil(Text);
      end;
    end;
  except
  end;
end;

procedure TAnsichtForm.AnsichtFormItemsListBoxClick(Sender: TObject);
begin
  try
    if AnsichtFormScrollCheckBox.Checked then
      AnsichtFormTextListBox.ItemIndex := AnsichtFormItemsListBox.ItemIndex;
  except
  end;
end;

procedure TAnsichtForm.AnsichtFormItemsListBoxKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if AnsichtFormScrollCheckBox.Checked then
      AnsichtFormTextListBox.ItemIndex := AnsichtFormItemsListBox.ItemIndex;
  except
  end;
end;

procedure TAnsichtForm.AnsichtFormScrollCheckBoxClick(Sender: TObject);
begin
  try
    AnsichtFormTextListBox.MultiSelect := not(AnsiChtFormScrollCheckBox.Checked);
  except
  end;
end;

procedure TAnsichtForm.AnsichtFormTextListBoxClick(Sender: TObject);
begin
  try
    if AnsichtFormScrollCheckBox.Checked then
      AnsichtFormItemsListBox.ItemIndex := AnsichtFormTextListBox.ItemIndex
  except
  end;
end;

procedure TAnsichtForm.AnsichtFormTextListBoxKeyPress(Sender: TObject; var Key: Char);
begin
  try
    if AnsichtFormScrollCheckBox.Checked then
      AnsichtFormItemsListBox.ItemIndex := AnsichtFormTextListBox.ItemIndex
  except
  end;
end;

procedure TAnsichtForm.AnsichtFormTextListBoxTimerTimer(Sender: TObject);
begin
  try
    SendMessage(AnsichtFormTextListBox.Handle, LB_SetHorizontalExtent, Round(Canvas.TextWidth('-') * (LastBreite + 5)), Longint(0));
  except
  end;
end;

procedure TAnsichtForm.FormCreate(Sender: TObject);
begin
  try
    DoubleBuffered := true;
  except
  end;
end;

procedure TAnsichtForm.FormShow(Sender: TObject);
begin
  try
    AnsichtFormDruckenMenuItem.Enabled := ((LastBreite <= CDruckenBreite) and
                                          (Printer.Printers.Count > - 1));
  except
  end;
end;

procedure TAnsichtForm.ShowValuesForm(AValues: TValues);
begin
  try
    ValuesForm.ValuesFormFitnessValueLabel.Caption               := FloatToStr(LastValues.Fitness);
    ValuesForm.ValuesFormHowOftenDominantValueLabel.Caption      := FloatToStr(LastValues.HowOftenDominant);
    ValuesForm.ValuesFormHowOftenRezessivValueLabel.Caption      := FloatToStr(LastValues.HowOftenRezessiv);
    ValuesForm.ValuesFormSelektionsKoeffizientValueLabel.Caption := FloatToStr(LastValues.SelektionsKoeffizient);

    if (LastValues.UseDominantGen) then
    begin
      ValuesForm.ValuesFormFitnessLabel.Caption := 'Fitness des dominanten Gens:';

      ValuesForm.ValuesFormSelektionGegenValueLabel.Caption := 'dominante Gen';
    end
    else
    begin
      ValuesForm.ValuesFormFitnessLabel.Caption := 'Fitness des rezessiven Gens:';

      ValuesForm.ValuesFormSelektionGegenValueLabel.Caption := 'rezessive Gen';
    end;

    ValuesForm.ShowModal;
  except
    ValuesForm.Close;
  end;
end;

end.
