unit utilitarios;

interface

uses
  Vcl.StdCtrls, System.SysUtils, Vcl.Dialogs;

  procedure ValorKeyPress(Sender: TObject; var Key: Char; pQtdDecimais: Integer);
  procedure FormatarDecimaisExit(pEdit: TEdit; pQtdDecimais: Integer);


implementation


procedure ValorKeyPress(Sender: TObject; var Key: Char; pQtdDecimais: Integer);
var
  sTextoAtual: string;
begin
  sTextoAtual := TEdit(Sender).Text;
  // Permitir apenas números, ponto decimal e Backspace
  if not (Key in ['0'..'9', ',', #8]) then
  begin
    Key := #0;
    Exit;
  end;
  // Permitir apenas um ponto decimal
  if (Key = ',') and (Pos(',', sTextoAtual) > 0) then
  begin
    Key := #0;
    Exit;
  end;
  // Limitar a quantidade de decimais ao informado em pQtdDecimais
  if (Pos(',', sTextoAtual) > 0) and (Length(sTextoAtual) - Pos(',', sTextoAtual) >= pQtdDecimais) then
  begin
    if (Key in ['0'..'9']) then
      Key := #0;
  end;
end;
procedure FormatarDecimaisExit(pEdit: TEdit; pQtdDecimais: Integer);
var
  dValor: Double;
begin
  if TryStrToFloat(pEdit.Text, dValor) then
  begin
    pEdit.Text := FormatFloat('0.' + StringOfChar('0', pQtdDecimais), dValor);
  end
  else
  begin
    pEdit.Text := '0,00';
  end;
end;

end.
