unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.RegularExpressions;

type
  TfrmMain = class(TForm)
    rgOption: TRadioGroup;
    odTextFile: TOpenDialog;
    memoTextToProcess: TMemo;
    lblTextProcess: TLabel;
    btnSearch: TButton;
    lblResult: TLabel;
    memoResult: TMemo;
    procedure rgOptionClick(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}

function FoundSequence(str: string): TStringList;
var
  i: integer;
  strSequence: string;
  strNumber: string;
  strBefor: string;
  strCurrent: string;
  strResult: string;
begin
  Result  :=  TStringList.Create;

  strSequence := '';
  strResult := '';

  for i := 0 to Length(str) do
  begin
    strCurrent := str[i];

    if (Pos(strCurrent, '0123456789') > 0) and (strCurrent <> #0) and (strBefor <> #0) then
    begin
      if StrToIntDef(strCurrent, -1) = StrToIntDef(strBefor, -1) + 1 then
      begin
        if Pos(strBefor, strSequence) = 0 then
          strSequence := strSequence + strBefor;

        if Pos(strCurrent, strSequence) = 0 then
          strSequence := strSequence + strCurrent;
      end;
    end
    else
    begin
      if strSequence <> '' then
        Result.Add(strSequence);
      strSequence  :=  '';
    end;

    strBefor := strCurrent;
  end;
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
var
  idx: integer;
  str: string;
begin
  memoResult.Clear;
  if (length(memoTextToProcess.Text) > 0) then
    for idx := 0 to memoTextToProcess.Lines.Count - 1 do
      memoResult.Lines.Add(FoundSequence(memoTextToProcess.Lines.Strings[idx]).Text);
end;

procedure TfrmMain.rgOptionClick(Sender: TObject);
begin
  memoTextToProcess.Clear;
  if (rgOption.ItemIndex = 0) and (odTextFile.Execute) then
    memoTextToProcess.Lines.LoadFromFile(odTextFile.FileName);
end;

end.
