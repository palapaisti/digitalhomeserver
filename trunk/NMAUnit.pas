(***********************************************************)
(* Notify My Android Unit                                  *)
(* https://www.notifymyandroid.com                         *)
(*                                                         *)
(* part of the Digital Home Server project                 *)
(* http://www.digitalhomeserver.net                        *)
(* info@digitalhomeserver.net                              *)
(*                                                         *)
(* This unit is freeware, credits are appreciated          *)
(***********************************************************)
unit NMAUnit;

// REQUIRED
// OpenSSL Libraries
// libeay32.dll and ssleay32.dll

interface

Uses Forms, Classes, IdIOHandler, IdIOHandlerSocket, IdIOHandlerStack,
  IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, XMLDoc, XMLIntf, SysUtils;

type
  TOnLogData = procedure(LogData : String) of object;

  TSuccessInfo = Record
    CallsRemaining : Integer;
    MinutesLeft : Integer;
  End;

  TErrorInfo = Record
    Msg : String;
    MinutesLeft : Integer;
  End;

  TPriority = -2..2;

  TNMA = class
    constructor Create;
    destructor Destroy; override;
  private
    IdHTTP : TIdHTTP;
    SSLHandler: TIdSSLIOHandlerSocketOpenSSL;
    XMLDocument : TXMLDocument;
    function GetReturnCodeMsg(Code : String) : String;
    function ParseXML(Str : String) : Boolean;
  public
    OnLogData : TOnLogData;
    SuccessInfo : TSuccessInfo;
    ErrorInfo : TErrorInfo;
    function GetInfo(Key : String; DevKey : String = '') : Boolean;
    function SendMessage(Key, Subject, Msg, Application : String; Priority : TPriority; DevKey : String = '') : Boolean;
    property ReturnCodeMsg[Code : String] : String read GetReturnCodeMsg;
  end;

implementation

const
  // The base URLs
  VerifyBaseURL = 'https://www.notifymyandroid.com/publicapi/verify';
  SendBaseURL = 'https://www.notifymyandroid.com/publicapi/notify';

type
  TReturnCodeRec = record
    Code : String;
    Msg : String;
  end;

const
  // Return codes
  ReturnCodes : array[0..4] of TReturnCodeRec =
    ((Code : '200'; Msg : 'The ''apikey'' supplied is valid.'),
     (Code : '400'; Msg : 'The data supplied is in the wrong format, invalid length or null.'),
     (Code : '401'; Msg : 'The ''apikey'' provided is not valid.'),
     (Code : '402'; Msg : 'Maximum number of API calls per hour exceeded.'),
     (Code : '500'; Msg : 'Internal server error. Please contact our support if the problem persists.'));

// Check if a key is valid, and return some info
// Result is true if success code is returned, false otherwise
function TNMA.GetInfo(Key: string; DevKey : String = '') : Boolean;
var
  Str : String;
  URL : String;
begin
  // Validate the account with the given key
  URL := VerifyBaseURL+'?apikey='+key;
  if DevKey <> '' then
    URL := URL+'&developerkey='+DevKey;
  if Assigned(OnLogData) then
    OnLogData('Sent : '+URL);
  Str := IdHTTP.Get(URL);
  if Assigned(OnLogData) then
    OnLogData('Received : '+Str);
  Result := ParseXML(Str);
end;


function TNMA.SendMessage(Key, Subject, Msg, Application : String; Priority : TPriority; DevKey : String = '') : Boolean;
var
  Params : TStringList;
  Str : String;
begin
  Params := TStringList.Create;
  try
    if DevKey <> '' then
      Params.Add('developerkey='+DevKey);
    Params.Add('application='+Application);
    Params.Add('event='+Subject);
    Params.Add('description='+Msg);
    Params.Add('priority='+IntToStr(Priority));
    Params.Add('apikey='+key);
    if Assigned(OnLogData) then
      OnLogData('Sent : '+SendBaseURL+' with parameters '+Params.Text);
    Str := IdHTTP.Post(SendBaseURL,Params);
    if Assigned(OnLogData) then
      OnLogData('Received : '+Str);
    Result := ParseXML(Str);
  finally
    Params.Free;
  end;
end;

function TNMA.ParseXML(Str : String) : Boolean;
var
  Node : IXMLNode;
begin
  // Parse
  XMLDocument.LoadFromXML(Str);
  Node := XMLDocument.ChildNodes['nma'].Childnodes[0];
  Str := Node.Attributes['code'];
  if Trim(Str) = '200' then
    begin  // Success
      Result := True;
      SuccessInfo.CallsRemaining := StrToInt(Node.Attributes['remaining']);
      SuccessInfo.MinutesLeft := StrToInt(Node.Attributes['resettimer']);
    end
  else
    begin  // error
      Result := False;
      ErrorInfo.Msg := ReturnCodeMsg[Str];
      if Trim(Str) = '402' then
        ErrorInfo.MinutesLeft := StrToInt(Node.Attributes['resettimer']);
    end;
end;

constructor TNMA.Create;
begin
  IdHTTP := TIdHTTP.Create(nil);
  SSLHandler := TIdSSLIOHandlerSocketOpenSSL.Create(nil);
  IdHTTP.IOHandler := SSLHandler;
  XMLDocument := TXMLDocument.Create(application);
end;

destructor TNMA.Destroy;
begin
  IdHTTP.Free;
end;

function TNMA.GetReturnCodeMsg(Code: string) : String;
var
  i : Integer;
begin
  Result := '';
  for i := 0 to Length(ReturnCodes)-1 do
    if Code = ReturnCodes[i].Code then
      begin
        Result := ReturnCodes[i].Msg;
        Break;
      end;
end;

end.
