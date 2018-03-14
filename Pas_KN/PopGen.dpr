program PopGen;

uses
  Forms,
  MainF in 'MainF.pas' {MainForm},
  ViewF in 'ViewF.pas' {AnsichtForm},
  InfoF in 'InfoF.pas' {InfoForm},
  ValuesF in 'ValuesF.pas' {ValuesForm};

{$R *.RES}

begin
  Application.Initialize;
  Application.Title := '| Shorei | PopulationsGenetik';
  Application.CreateForm(TMainForm, MainForm);
  Application.CreateForm(TAnsichtForm, AnsichtForm);
  Application.CreateForm(TInfoForm, InfoForm);
  Application.CreateForm(TValuesForm, ValuesForm);
  Application.Run;
end.
