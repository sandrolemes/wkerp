unit conexao;

interface

uses
  System.IniFiles, Data.DB, Data.SqlExpr,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys.MySQL, FireDAC.DApt;
  function ObterConexao: TFDConnection;

implementation

uses
  System.SysUtils;

{ TDatabaseConfig }

function ObterConexao: TFDConnection;
var
  Connection: TFDConnection;
  sArqIni: string;
  arqIni: TIniFile;
begin
  try
    sArqIni := ChangeFileExt(ParamStr(0), '.ini');
    arqIni := TIniFile.Create(sArqIni);

    if (not arqIni.ValueExists('Conexao', 'Host')) or (arqIni.ReadString('Conexao', 'Host', '') = '') then
      arqIni.WriteString('Conexao', 'Host', 'localhost');
    if (not arqIni.ValueExists('Conexao', 'Port')) or (arqIni.ReadString('Conexao', 'Port', '') = '') then
      arqIni.WriteString('Conexao', 'Port', '3306');
    if (not arqIni.ValueExists('Conexao', 'Database')) or (arqIni.ReadString('Conexao', 'Database', '') = '') then
      arqIni.WriteString('Conexao', 'Database', 'wkerp');
    if (not arqIni.ValueExists('Conexao', 'User_Name')) or (arqIni.ReadString('Conexao', 'User_Name', '') = '') then
      arqIni.WriteString('Conexao', 'User_Name', 'root');
    if (not arqIni.ValueExists('Conexao', 'Password')) or (arqIni.ReadString('Conexao', 'Password', '') = '') then
      arqIni.WriteString('Conexao', 'Password', '@p057gr35u5u7401@');
    if (not arqIni.ValueExists('Conexao', 'VendorLib')) or (arqIni.ReadString('Conexao', 'VendorLib', '') = '') then
      arqIni.WriteString('Conexao', 'VendorLib', ExtractFilePath(ParamStr(0)) + '\libmysql.dll');


    Connection := TFDConnection.Create(nil);
    Connection.DriverName := 'MySQL';
    Connection.Params.Add(Format('Server=%s', [arqIni.ReadString('Conexao', 'Host', '')]));
    Connection.Params.Add(Format('Port=%s', [arqIni.ReadString('Conexao', 'Port', '')]));
    Connection.Params.Add(Format('Database=%s', [arqIni.ReadString('Conexao', 'Database', '')]));
    Connection.Params.Add(Format('User_Name=%s', [arqIni.ReadString('Conexao', 'User_Name', '')]));
    Connection.Params.Add(Format('Password=%s', [arqIni.ReadString('Conexao', 'Password', '')]));
    Connection.Params.Add(Format('VendorLib=%s', [arqIni.ReadString('Conexao', 'VendorLib', '')]));
    Connection.LoginPrompt := False;
    Connection.Connected := True;
    Result := Connection;
  except
    on E: Exception do
    begin
      raise Exception.Create('Erro ao conectar no banco de dados: ' + E.Message);
    end;
  end;
end;

end.

