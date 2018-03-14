unit MainF;

interface

uses
  SysUtils, Forms, Dialogs, Controls, StdCtrls, ExtCtrls, Menus, ImgList,
  Classes;

const
  CDruckenBreite = 100;

type
  TValues = record
    Fitness               : Extended;
    HowOftenDominant      : Extended;
    HowOftenRezessiv      : Extended;
    SelektionsKoeffizient : Extended;
    UseDominantGen        : Boolean;
  end;

  TMainForm = class(TForm)
    MainFormListBox: TListBox;
    MainFormMitteBevel: TBevel;
    MainFormUntenBevel: TBevel;
    MainFormStartButton: TButton;
    MainFormStoppButton: TButton;
    MainFormMainMenu: TMainMenu;
    MainFormDateiMenuItem: TMenuItem;
    MainFormBeendenMenuItem: TMenuItem;
    MainFormBreiteLabel: TLabel;
    MainFormBreiteEdit: TEdit;
    MainFormStandartBreiteLabel: TLabel;
    MainFormDominantGroupBox: TGroupBox;
    MainFormFitnessDominantLabel: TLabel;
    MainFormHowOftenDominantEdit: TEdit;
    MainFormFitnessDominantEdit: TEdit;
    MainFormRezessivGroupBox: TGroupBox;
    MainFormHowOftenRezessivLabel: TLabel;
    MainFormHowOftenRezessivEdit: TEdit;
    MainFormFitnessRezessivLabel: TLabel;
    MainFormFitnessRezessivEdit: TEdit;
    MainFormHowOftenDominantLabel: TLabel;
    MainFormAnsichtMenuItem: TMenuItem;
    MainFormAnsichtFormMenuItem: TMenuItem;
    MainFormFragezeichenMenuItem: TMenuItem;
    MainFormInfoMenuItem: TMenuItem;
    MainFormImageList: TImageList;
    MainFormUnterNeuTrennMenuItem: TMenuItem;
    MainFormNeuMenuItem: TMenuItem;
    MainFormInfoLabel: TLabel;
    MainFormObenBevel: TBevel;
    MainFormDruckenCheckBox: TCheckBox;

    procedure EditChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure MainFormListBoxClick(Sender: TObject);
    procedure MainFormStoppButtonClick(Sender: TObject);
    procedure MainFormBeendenMenuItemClick(Sender: TObject);
    procedure MainFormStartButtonClick(Sender: TObject);
    procedure MainFormAnsichtFormMenuItemClick(Sender: TObject);
    procedure MainFormInfoMenuItemClick(Sender: TObject);
    procedure MainFormListBoxKeyPress(Sender: TObject; var Key: Char);
    procedure MainFormNeuMenuItemClick(Sender: TObject);
    procedure MainFormDruckenCheckBoxClick(Sender: TObject);
  private
    { Private-Deklarationen }
    StillRun : Boolean;

    Values : TValues;

    function Line(Value : Integer)  : String;
    function Space(Value : Integer) : String;

    procedure ChangeMainFormListBox;
    procedure PopulationsGenetik;
    procedure PrepareNumbers;
  public
    { Public-Deklarationen }
    Breite         : Integer;
    CanPrint       : Boolean;
    StandartBreite : Integer;
  end;

var
  MainForm: TMainForm;

implementation

uses
  ViewF, InfoF;

{$R *.DFM}

procedure TMainForm.EditChange(Sender: TObject);
var
  Index : Integer;
  Text  : String;
begin
  try
    if (Sender.ClassType = TEdit) then
    begin
      Text  := TEdit(Sender).Text;

      for Index := 1 to Length(Text) do
      begin
        if not(Text[Index] in [#8, #43..#45, #48..#57, #69, #101]) then
          Delete(Text, Index, 1)
      end;

      TEdit(Sender).Text := Text;

      if not(TEdit(Sender).Text = '') then
      begin
        if (TEdit(Sender).Name = 'MainFormFitnessDominantEdit') then
          MainFormFitnessRezessivEdit.Text := '';
        if (TEdit(Sender).Name = 'MainFormFitnessRezessivEdit') then
          MainFormFitnessDominantEdit.Text := '';
        if (TEdit(Sender).Name = 'MainFormHowOftenDominantEdit') then
          MainFormHowOftenRezessivEdit.Text := '';
        if (TEdit(Sender).Name = 'MainFormHowOftenRezessivEdit') then
          MainFormHowOftenDominantEdit.Text := '';
      end;
    end;
  except
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  try
    MainFormListBox.ItemIndex := 0;

    MainFormDominantGroupBox.Enabled := true;
    MainFormRezessivGroupBox.Enabled := false;

    MainFormHowOftenDominantEdit.Enabled  := true;
    MainFormHowOftenDominantLabel.Enabled := true;
    MainFormHowOftenRezessivEdit.Enabled  := false;
    MainFormHowOftenRezessivLabel.Enabled := false;

    MainFormFitnessDominantEdit.Enabled  := true;
    MainFormFitnessDominantLabel.Enabled := true;
    MainFormFitnessRezessivEdit.Enabled  := false;
    MainFormFitnessRezessivLabel.Enabled := false;

    StandartBreite := 70;
  except
  end;
end;

procedure TMainForm.MainFormListBoxClick(Sender: TObject);
begin
  try
    ChangeMainFormListBox;
  except
  end;
end;

procedure TMainForm.MainFormStoppButtonClick(Sender: TObject);
begin
  try
    StillRun := false;
  except
  end;
end;

procedure TMainForm.MainFormBeendenMenuItemClick(Sender: TObject);
begin
  Close;
end;

procedure TMainForm.MainFormStartButtonClick(Sender: TObject);
begin
  try
    if (MainFormListBox.ItemIndex = 0) then
      Values.UseDominantGen := true
    else
      Values.UseDominantGen := false;

    if Values.UseDominantGen then
    begin
      try
        Values.Fitness := StrToFloat(MainFormFitnessDominantEdit.Text);

        if not((Values.Fitness > 0) and (Values.Fitness < 1)) then
        begin
          MessageDlg('Die Fitness des dominanten Gens muss größer als 0' + #13#10 +
                     'und kleiner 1 sein!',
                     mtError, [mbOK], 0);

          Exit;
        end;
      except
        MessageDlg('Die Fitness des dominanten Gens muss als Zahl angegeben werden!',
                   mtError, [mbOK], 0);

        Exit;
      end;
      try
        Values.HowOftenDominant := StrToFloat(MainFormHowOftenDominantEdit.Text);

        if not((Values.HowOftenDominant > 0) and (Values.HowOftenDominant < 1)) then
        begin
          MessageDlg('Die Häufigkeit des dominanten Gens muss größer als 0' + #13#10 +
                     'und kleiner 1 sein!',
                     mtError, [mbOK], 0);

          Exit;
        end;
      except
        MessageDlg('Die Häufigkeit des dominanten Gens muss als Zahl angegeben werden!',
                   mtError, [mbOK], 0);

        Exit;
      end;
    end
    else
    begin
      try
        Values.Fitness := StrToFloat(MainFormFitnessRezessivEdit.Text);

        if not((Values.Fitness > 0) and (Values.Fitness < 1)) then
        begin
          MessageDlg('Die Fitness des rezessiven Gens muss größer als 0' + #13#10 +
                     'und kleiner 1 sein!',
                     mtError, [mbOK], 0);

          Exit;
        end;
      except
        MessageDlg('Die Fitness des rezessiven Gens muss als Zahl angegeben werden!',
                   mtError, [mbOK], 0);

        Exit;
      end;
      try
        Values.HowOftenRezessiv := StrToFloat(MainFormHowOftenRezessivEdit.Text);

        if not((Values.HowOftenRezessiv > 0) and (Values.HowOftenRezessiv < 1)) then
        begin
          MessageDlg('Die Häufigkeit des rezessiven Gens muss größer als 0' + #13#10 +
                     'und kleiner 1 sein!',
                     mtError, [mbOK], 0);

          Exit;
        end;
      except
        MessageDlg('Die Häufigkeit des rezessiven Gens muss als Zahl angegeben werden!',
                   mtError, [mbOK], 0);

        Exit;
      end;
    end;

    try
      if (MainFormBreiteEdit.Text = '') then
        MainFormBreiteEdit.Text := FloatToStr(StandartBreite);

      Breite := StrToInt(MainFormBreiteEdit.Text);
    except
        MessageDlg('Die Breite der Ansicht muss als Zahl angegeben werden!',
                   mtError, [mbOK], 0);

        Exit;
    end;

    MainFormHowOftenDominantEdit.Enabled  := false;
    MainFormHowOftenDominantLabel.Enabled := false;
    MainFormHowOftenRezessivEdit.Enabled  := false;
    MainFormHowOftenRezessivLabel.Enabled := false;

    MainFormFitnessDominantEdit.Enabled  := false;
    MainFormFitnessDominantLabel.Enabled := false;
    MainFormFitnessRezessivEdit.Enabled  := false;
    MainFormFitnessRezessivLabel.Enabled := false;

    MainFormDruckenCheckBox.Enabled := false;

    if not(MainFormDruckenCheckBox.Checked) then
    begin
      MainFormBreiteEdit.Enabled  := false;
      MainFormBreiteLabel.Enabled := false;

      MainFormStandartBreiteLabel.Enabled := false;
    end;

    MainFormListBox.Enabled := false;

    MainFormStartButton.Enabled := false;
    MainFormStoppButton.Enabled := true;

    MainFormInfoLabel.Visible := true;

    AnsichtForm.Show;
    AnsichtForm.Enabled := false;

    AnsichtForm.AnsichtFormTextListBox.Clear;
    AnsichtForm.AnsichtFormItemsListBox.Clear;

    FormStyle := fsStayOnTop;

    PrepareNumbers;
    PopulationsGenetik;

    FormStyle := fsNormal;

    MainFormInfoLabel.Visible := false;

    MainFormStartButton.Enabled := true;
    MainFormStoppButton.Enabled := false;

    MainFormListBox.Enabled := true;

    if not(MainFormDruckenCheckBox.Checked) then
    begin
      MainFormStandartBreiteLabel.Enabled := false;

      MainFormBreiteEdit.Enabled  := true;
      MainFormBreiteLabel.Enabled := true;
    end;

    MainFormDruckenCheckBox.Enabled := true;

    ChangeMainFormListBox;

    AnsichtForm.LastBreite := Breite;
    AnsichtForm.LastValues := Values;

    AnsichtForm.AnsichtFormItemsListBox.ItemIndex := - 1;
    AnsiChtForm.AnsichtFormTextListBox.ItemIndex  := - 1;
    
    AnsichtForm.Enabled := true;
    AnsichtForm.BringToFront;
    AnsichtForm.FormShow(nil);
  except
  end;
end;

procedure TMainForm.MainFormAnsichtFormMenuItemClick(Sender: TObject);
begin
  try
    AnsichtForm.Show;
  except
  end;
end;

procedure TMainForm.MainFormInfoMenuItemClick(Sender: TObject);
begin
  try
    InfoForm.ShowModal;
  except
  end;
end;

procedure TMainForm.MainFormListBoxKeyPress(Sender: TObject;
  var Key: Char);
begin
  try
    ChangeMainFormListBox;
  except
  end;
end;

procedure TMainForm.MainFormNeuMenuItemClick(Sender: TObject);
begin
  try
    AnsichtForm.AnsichtFormItemsListBox.Clear;
    AnsichtForm.AnsichtFormTextListBox.Clear;

    Breite := 0;
    
    Values.Fitness               := 0;
    Values.SelektionsKoeffizient := 0;

    Values.HowOftenDominant := 0;
    Values.HowOftenRezessiv := 0;

    MainFormListBox.ItemIndex := 0;

    ChangeMainFormListBox;

    MainFormDruckenCheckBox.Checked := false; 
   
    MainFormBreiteEdit.Text := '';

    MainFormFitnessDominantEdit.Text := '';
    MainFormFitnessRezessivEdit.Text := '';

    MainFormHowOftenDominantEdit.Text := '';
    MainFormHowOftenRezessivEdit.Text := '';

    MainFormListBox.SetFocus;
  except
  end;
end;

function TMainForm.Line(Value: Integer): String;
var
  Index : Integer;
begin
  try
    Result := '';

    for Index := 1 to Value do
      Result := Result + #45;
  except
    Result := '';
  end;
end;

function TMainForm.Space(Value: Integer): String;
var
  Index : Integer;
begin
  try
    Result := '';

    for Index := 1 to Value do
      Result := Result + #32;
  except
    Result := '';
  end;
end;

procedure TMainForm.PopulationsGenetik;
var
  Dominant    : Extended;
  Generation  : Integer;
  Heterozygot : Extended;
  Index       : Integer;
  NewDominant : Extended;
  NewRezessiv : Extended;
  NextLine    : String;
  Phaenotyp   : Extended;
  Rezessiv    : Extended;
  CharNumber  : Integer;
begin
  try
    Generation  := 0;
    NewDominant := Values.HowOftenDominant;
    NewRezessiv := Values.HowOftenRezessiv;
    NextLine    := '';
    StillRun    := true;

    AnsichtForm.AnsichtFormItemsListBox.Items.Add('Generation');
    AnsichtForm.AnsichtFormItemsListBox.Items.Add(Line(10));

    AnsichtForm.AnsichtFormTextListBox.Items.Add('0.0' + Space((Breite div 2) - 6) + '0.5' + Space((Breite div 2) - 3) + '1.0');
    AnsichtForm.AnsichtFormTextListBox.Items.Add(Line(Breite));

    repeat
    begin
      if (Frac(AnsichtForm.AnsichtFormItemsListBox.Items.Count / 25) = 0) then
        Application.ProcessMessages;

      Inc(Generation);
      AnsichtForm.AnsichtFormItemsListBox.Items.Add(IntToStr(Generation));

      if Values.UseDominantGen then
      begin
        NewDominant := ((NewDominant - (NewDominant * Values.SelektionsKoeffizient)) /
                        (1 + (Values.SelektionsKoeffizient * NewDominant * NewDominant) - (2 * Values.SelektionsKoeffizient * NewDominant)));
        NewRezessiv := (1 - NewDominant);
      end
      else
      begin
        NewRezessiv := (NewRezessiv * (1 - (Values.SelektionsKoeffizient * NewRezessiv)) /
                        (1 - (Values.SelektionsKoeffizient * NewRezessiv * NewRezessiv)));
        NewDominant := (1 - NewRezessiv);
      end;

      Dominant    := NewDominant * NewDominant * Breite;
      Heterozygot := 2 * NewDominant * NewRezessiv * Breite;
      Phaenotyp   := Dominant + Heterozygot;
      Rezessiv    := NewRezessiv * NewRezessiv * Breite;

      Index    := 1;
      NextLine := '';
      while (Index < Succ(Round(Breite))) do
      begin
        Inc(Index);

        CharNumber := 0;

        if (Round(Dominant) = Index) then
        begin
          Inc(CharNumber);
          NextLine := NextLine + 'D';
        end;
        if (Round(Heterozygot) = Index) then
        begin
          Inc(CharNumber);
          NextLine := NextLine + 'H';
        end;
        if (Round(Phaenotyp) = Index) then
        begin
          Inc(CharNumber);
          NextLine := NextLine + 'Z';
        end;
        if (Round(Rezessiv) = Index) then
        begin
          Inc(CharNumber);
          NextLine := NextLine + 'R';
        end;

        NextLine := NextLine + Space(1);
        Index    := Index + CharNumber;
      end;

      AnsichtForm.AnsichtFormTextListBox.Items.Add(NextLine);
    end;
    until not(StillRun);
  except
  end;
end;

procedure TMainForm.PrepareNumbers;
begin
  try
    Values.SelektionsKoeffizient := 1 - Values.Fitness;

    if Values.UseDominantGen then
      Values.HowOftenRezessiv := 1 - Values.HowOftenDominant
    else
      Values.HowOftenDominant := 1 - Values.HowOftenRezessiv;
  except
  end;
end;

procedure TMainForm.ChangeMainFormListBox;
begin
  try
    if (MainFormListBox.ItemIndex = 0) then
    begin
      MainFormDominantGroupBox.Enabled := true;
      MainFormRezessivGroupBox.Enabled := false;

      MainFormHowOftenDominantEdit.Enabled  := true;
      MainFormHowOftenDominantLabel.Enabled := true;
      MainFormHowOftenRezessivEdit.Enabled  := false;
      MainFormHowOftenRezessivLabel.Enabled := false;

      MainFormFitnessDominantEdit.Enabled  := true;
      MainFormFitnessDominantLabel.Enabled := true;
      MainFormFitnessRezessivEdit.Enabled  := false;
      MainFormFitnessRezessivLabel.Enabled := false;
    end
    else
    begin
      MainFormDominantGroupBox.Enabled := false;
      MainFormRezessivGroupBox.Enabled := true;

      MainFormHowOftenDominantEdit.Enabled  := false;
      MainFormHowOftenDominantLabel.Enabled := false;
      MainFormHowOftenRezessivEdit.Enabled  := true;
      MainFormHowOftenRezessivLabel.Enabled := true;

      MainFormFitnessDominantEdit.Enabled  := false;
      MainFormFitnessDominantLabel.Enabled := false;
      MainFormFitnessRezessivEdit.Enabled  := true;
      MainFormFitnessRezessivLabel.Enabled := true;
    end;
  except
  end;
end;

procedure TMainForm.MainFormDruckenCheckBoxClick(Sender: TObject);
begin
  try
    CanPrint := MainFormDruckenCheckBox.Checked;

    MainFormBreiteEdit.Enabled  := not(MainFormDruckenCheckBox.Checked);
    MainFormBreiteLabel.Enabled := not(MainFormDruckenCheckBox.Checked);

    MainFormStandartBreiteLabel.Enabled := not(MainFormDruckenCheckBox.Checked);

    MainFormBreiteEdit.Text := IntToStr(CDruckenBreite);
  except
  end;
end;

end.

