program ApproxPi;

uses
  Forms,
  Main in 'Main.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Approx''Pi';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
