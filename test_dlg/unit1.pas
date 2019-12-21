unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  RegExpr;

type
  { TForm1 }

  TForm1 = class(TForm)
    EditRegex: TEdit;
    EditText: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ListDump: TListBox;
    ListRes: TListBox;
    Panel1: TPanel;
    Panel2: TPanel;
    procedure EditRegexChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    reg: TRegExpr;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
begin
  reg:= TRegExpr.Create;
  EditRegex.Text:= '(\w+) (\d+)';
  EditText.Text:= '.. test 23';
  EditRegex.OnChange(nil);
end;

procedure TForm1.EditRegexChange(Sender: TObject);
var
  i: integer;
begin
  ListRes.Items.Clear;
  ListDump.Items.Clear;

  try
    reg.Expression:= EditRegex.Text;
    ListDump.Items.AddText(reg.Dump);
  except
    on e: Exception do
    begin
      ListDump.Items.Add(e.Message);
      exit;
    end;
  end;

  try
    reg.InputString:= EditText.Text;
    if reg.Exec then
    begin
      ListRes.Items.Add(
        'Found at pos: '+IntToStr(reg.MatchPos[0])+
        '  Match: '+reg.Match[0]);
      for i:= 1 to reg.SubExprMatchCount do
        ListRes.Items.Add(Format('Group %d: %s', [i, reg.Match[i]]));
    end
    else
      ListRes.Items.Add('Cannot find');
  except
    on e: Exception do
      ListRes.Items.Add(e.Message);
  end;
end;

end.
