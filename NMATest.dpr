program NMATest;

uses
  Forms,
  Main in 'Main.pas' {MainForm},
  NMAUnit in 'NMAUnit.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
