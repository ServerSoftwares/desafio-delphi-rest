unit uValidaCep;

interface

  uses
  System.SysUtils, fmx.Edit;

  type
  TValidaCEP = class
  public
  { Public declarations }
  class function FormataCEP(obj: TObject;cep: string): string;
  class function SomenteNumero(str: string): string;
  class function Mask(mascara, str: string): string;
end;

implementation

{ TValidaCEP }

class function TValidaCEP.FormataCEP(obj: TObject;cep: string): string;
begin
  cep := TValidaCEP.Mask('##.###-###', SomenteNumero(cep));
  if obj is TEdit then
  begin
    TEdit(obj).Text := cep;
    TEdit(obj).CaretPosition := TEdit(obj).Text.Length;
  end;
end;

class function TValidaCEP.SomenteNumero(str: string): string;
var
x: integer;
begin
  Result := '';
  for x := 0 to Length(str) - 1 do
  if str.Chars[x] in ['0'..'9'] then
  Result := Result + str.Chars[x];
end;

class function TValidaCEP.Mask(mascara, str: string): string;
var
x, p: integer;
begin
  p := 0;
  Result := '';
  if str.IsEmpty then
  Exit;
  for x := 0 to Length(mascara) - 1 do
  begin
    if mascara.Chars[x] = '#' then
    begin
      if p < Length(str) then
      begin
        Result := Result + str.Chars[p];
        Inc(p);
      end else
      Break;
    end else
    Result := Result + mascara.Chars[x];
  end;
end;

end.
