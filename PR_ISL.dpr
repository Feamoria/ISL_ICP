program PR_ISL;

uses
  Vcl.Forms,
  ISL in 'ISL.pas' {MainFM},
  OP_Control in 'OP_Control.pas' {OP_Control_Fm},
  u_log in 'u_log.pas' {FM_log};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainFM, MainFM);
  Application.CreateForm(TOP_Control_Fm, OP_Control_Fm);
  Application.CreateForm(TFM_log, FM_log);
  Application.Run;
end.
