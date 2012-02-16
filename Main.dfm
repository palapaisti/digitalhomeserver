object MainForm: TMainForm
  Left = 0
  Top = 0
  Caption = 'Notify My Android'
  ClientHeight = 547
  ClientWidth = 607
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 19
  object Label1: TLabel
    Left = 20
    Top = 19
    Width = 56
    Height = 19
    Caption = 'API Key'
  end
  object Label2: TLabel
    Left = 268
    Top = 128
    Width = 52
    Height = 19
    Caption = 'Subject'
  end
  object Label3: TLabel
    Left = 268
    Top = 168
    Width = 59
    Height = 19
    Caption = 'Message'
  end
  object Label4: TLabel
    Left = 20
    Top = 51
    Width = 57
    Height = 19
    Caption = 'Dev Key'
  end
  object Label5: TLabel
    Left = 20
    Top = 84
    Width = 79
    Height = 19
    Caption = 'Application'
  end
  object APIKeyEdit: TEdit
    Left = 112
    Top = 16
    Width = 441
    Height = 27
    TabOrder = 0
    Text = '7d278eb1ad2b383f7b0278abf976fd1bbfbe4b21b3e08f3b'
  end
  object VerifyButton: TButton
    Left = 20
    Top = 120
    Width = 121
    Height = 33
    Caption = 'Verify'
    TabOrder = 1
    OnClick = VerifyButtonClick
  end
  object GroupBox1: TGroupBox
    Left = 20
    Top = 159
    Width = 201
    Height = 202
    TabOrder = 2
    object CodeLabel: TLabel
      Left = 11
      Top = 16
      Width = 6
      Height = 23
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object MsgLabel: TLabel
      Left = 11
      Top = 45
      Width = 174
      Height = 140
      AutoSize = False
      WordWrap = True
    end
  end
  object SendButton: TButton
    Left = 340
    Top = 328
    Width = 121
    Height = 33
    Caption = 'Send'
    TabOrder = 3
    OnClick = SendButtonClick
  end
  object SubjectEdit: TEdit
    Left = 340
    Top = 123
    Width = 121
    Height = 27
    TabOrder = 4
    Text = 'qdf'
  end
  object MessageEdit: TMemo
    Left = 340
    Top = 165
    Width = 249
    Height = 148
    Lines.Strings = (
      'blabla'
      ''
      'haha')
    TabOrder = 5
  end
  object DebugLog: TMemo
    Left = 20
    Top = 376
    Width = 565
    Height = 153
    TabOrder = 6
  end
  object DevKeyEdit: TEdit
    Left = 112
    Top = 48
    Width = 441
    Height = 27
    TabOrder = 7
    Text = '7d278eb1ad2b383f7b0278abf976fd1bbfbe4b21b3e08f3b'
  end
  object ApplicationEdit: TEdit
    Left = 112
    Top = 81
    Width = 185
    Height = 27
    TabOrder = 8
    Text = 'Digital Home Server'
  end
end
