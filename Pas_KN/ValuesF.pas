unit ValuesF;

interface

uses
  Forms, Classes, Controls, ExtCtrls, StdCtrls;

type
  TValuesForm = class(TForm)
    ValuesFormFrageLabel: TLabel;
    ValuesFormFitnessLabel: TLabel;
    ValuesFormHowOftenDominantLabel: TLabel;
    ValuesFormHowOftenRezessivLabel: TLabel;
    ValuesFormSelektionsKoeffizientLabel: TLabel;
    ValuesFormSelektionGegenLabel: TLabel;
    ValuesFormFitnessValueLabel: TLabel;
    ValuesFormHowOftenDominantValueLabel: TLabel;
    ValuesFormHowOftenRezessivValueLabel: TLabel;
    ValuesFormSelektionsKoeffizientValueLabel: TLabel;
    ValuesFormSelektionGegenValueLabel: TLabel;
    ValuesFormObenBevel: TBevel;
    ValuesFormUntenBevel: TBevel;
    ValuesFormOKButton: TButton;
    ValuesFormCancelButton: TButton;

    procedure ValuesFormCancelButtonClick(Sender: TObject);
    procedure ValuesFormOKButtonClick(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  ValuesForm: TValuesForm;

implementation

uses
  ViewF;

{$R *.DFM}

procedure TValuesForm.ValuesFormCancelButtonClick(Sender: TObject);
begin
  try
    AnsichtForm.PrintValues := false;
  except
  end;

  Close;
end;

procedure TValuesForm.ValuesFormOKButtonClick(Sender: TObject);
begin
  try
    AnsichtForm.PrintValues := true;
  except
  end;

  Close;
end;

end.
