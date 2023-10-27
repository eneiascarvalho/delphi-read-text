unit Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, System.RegularExpressions,
  Generics.Collections;

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
  strBefor: string;
  strCurrent: string;
begin
  Result  :=  TStringList.Create;
  strSequence := '';

  for i := 0 to Length(str) do
  begin
    strCurrent := str[i];

    if (Pos(strCurrent, '0123456789') > 0) and (strCurrent <> #0) and (strBefor <> #0) then
    begin
      if StrToIntDef(strCurrent, -99) = StrToIntDef(strBefor, -99) + 1 then
      begin
        if Pos(strBefor, strSequence) = 0 then
          strSequence := strSequence + strBefor;

        if Pos(strCurrent, strSequence) = 0 then
          strSequence := strSequence + strCurrent;
      end
      else
      if Length(strSequence) > 1 then
      begin
        Result.Add(strSequence);
        strSequence  :=  '';
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

  if strSequence <> '' then
    Result.Add(strSequence);
end;

procedure TfrmMain.btnSearchClick(Sender: TObject);
var
  idx, idxAux: integer;
  lst: TStringList;
  results: TDictionary<integer, integer>;
  count: integer;
  key: integer;
  str: string;
begin
  memoResult.Clear;
  lst :=  TStringList.Create;
  results :=  TDictionary<integer, integer>.Create;
  try
    if (length(memoTextToProcess.Text) > 0) then
      for idx := 0 to memoTextToProcess.Lines.Count - 1 do
      begin
        lst.Clear;
        lst :=  FoundSequence(memoTextToProcess.Lines.Strings[idx]);

        count :=  0;
        for idxAux := 0 to lst.Count - 1 do
          if lst.Strings[idxAux] <> '' then
          begin
            if results.ContainsKey(StrToInt(lst.Strings[idxAux])) then
            begin
              if results.TryGetValue(StrToInt(lst.Strings[idxAux]), count) then
                results.AddOrSetValue(StrToInt(lst.Strings[idxAux]), count + 1)
            end
            else
              results.Add(StrToInt(lst.Strings[idxAux]), 1);
          end;
      end;

    if results.Count > 0 then
    begin
      lst.Clear;
      for key in results.Keys do
      begin
        if results.TryGetValue(key, count) then
          lst.Add(count.ToString + ',' + key.ToString);
      end;

      lst.Sort;

      for idx := lst.Count downto 1 do
      begin
        str :=  lst.Strings[idx-1];
        str :=  Copy(str, Pos(',', str) + 1) + ' ' + Copy(str, 1, Pos(',', str) - 1);
        memoResult.Lines.Add(str);;
      end;
    end;
  finally
    results.Free;
  end;
end;

procedure TfrmMain.rgOptionClick(Sender: TObject);
begin
  memoTextToProcess.Clear;
  if (rgOption.ItemIndex = 0) and (odTextFile.Execute) then
    memoTextToProcess.Lines.LoadFromFile(odTextFile.FileName);
end;

end.
