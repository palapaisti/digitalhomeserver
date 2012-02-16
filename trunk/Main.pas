(***********************************************************)
(* Notify My Android Demo                                  *)
(* https://www.notifymyandroid.com                         *)
(*                                                         *)
(* part of the Digital Home Server project                 *)
(* http://www.digitalhomeserver.net                        *)
(* info@digitalhomeserver.net                              *)
(*                                                         *)
(* This unit is freeware, credits are appreciated          *)
(***********************************************************)
unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, NMAUnit, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TMainForm = class(TForm)
    APIKeyEdit: TEdit;
    Label1: TLabel;
    VerifyButton: TButton;
    GroupBox1: TGroupBox;
    SendButton: TButton;
    SubjectEdit: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    MessageEdit: TMemo;
    DebugLog: TMemo;
    Label4: TLabel;
    DevKeyEdit: TEdit;
    ApplicationEdit: TEdit;
    Label5: TLabel;
    CodeLabel: TLabel;
    MsgLabel: TLabel;
    procedure VerifyButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SendButtonClick(Sender: TObject);
  private
    { Private declarations }
    NMA : TNMA;
    procedure LogData(LogData : String);
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure TMainForm.FormCreate(Sender: TObject);
begin
  NMA := TNMA.Create;         // Create the Notify My Android object
  NMA.OnLogData := LogData;   // event trigger for logging purposes
end;

// Verify the api key
procedure TMainForm.VerifyButtonClick(Sender: TObject);
begin
  if Trim(APIKeyEdit.Text) = '' then
    begin
      ShowMessage('API Key can not be empty');
      Exit;
    end;
  if NMA.GetInfo(APIKeyEdit.Text) then
    begin
      CodeLabel.Caption := 'Success';
      MsgLabel.Caption := '';
    end
  else
    begin
      CodeLabel.Caption := 'Error';
      MsgLabel.Caption := NMA.ErrorInfo.Msg;
    end;
end;

// Send a message
procedure TMainForm.SendButtonClick(Sender: TObject);
begin
  NMA.SendMessage(APIKeyEdit.Text,SubjectEdit.Text,MessageEdit.Text,ApplicationEdit.Text,0);
end;

procedure TMainForm.LogData(LogData: string);
begin
  DebugLog.Lines.Add(LogData);
end;

end.
