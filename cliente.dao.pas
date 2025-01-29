unit cliente.dao;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  cliente.dto;

type
  TClienteDAO = class
  private
    FConexao: TFDConnection;
  public
    constructor Create(AConexao: TFDConnection);
    procedure Inserir(const Cliente: TClienteDTO);
    procedure Atualizar(const Cliente: TClienteDTO);
    procedure Excluir(const CodCli: Integer);
    function ConsultarPorCodigo(const CodCli: Integer): TClienteDTO;
  end;

implementation

{ TClienteDAO }

constructor TClienteDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TClienteDAO.ConsultarPorCodigo(const CodCli: Integer): TClienteDTO;
var
  Query: TFDQuery;
  Cliente: TClienteDTO;
begin
  Result := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'SELECT codcli, nome, cidade, uf FROM clientes WHERE codcli = :codcli';
    Query.ParamByName('codcli').AsInteger := CodCli;
    Query.Open;
    if not Query.IsEmpty then
    begin
      Cliente := TClienteDTO.Create;
      Cliente.CodCli := Query.FieldByName('codcli').AsInteger;
      Cliente.Nome := Query.FieldByName('nome').AsString;
      Cliente.Cidade := Query.FieldByName('cidade').AsString;
      Cliente.Uf := Query.FieldByName('uf').AsString;
      Result := Cliente;
    end;
  finally
    Query.Free;
  end;
end;

procedure TClienteDAO.Inserir(const Cliente: TClienteDTO);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'INSERT INTO clientes (codcli, nome, cidade, uf) VALUES (:codcli, :nome, :cidade, :uf)';
    Query.ParamByName('codcli').AsInteger := Cliente.Codcli;
    Query.ParamByName('nome').AsString := Cliente.Nome;
    Query.ParamByName('cidade').AsString := Cliente.Cidade;
    Query.ParamByName('uf').AsString := Cliente.Uf;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TClienteDAO.Atualizar(const Cliente: TClienteDTO);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'UPDATE clientes SET nome = :nome, cidade = :cidade, uf = :uf WHERE codcli = :codcli';
    Query.ParamByName('codcli').AsInteger := Cliente.Codcli;
    Query.ParamByName('nome').AsString := Cliente.Nome;
    Query.ParamByName('cidade').AsString := Cliente.Cidade;
    Query.ParamByName('uf').AsString := Cliente.Uf;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TClienteDAO.Excluir(const CodCli: Integer);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'DELETE FROM clientes WHERE codcli = :codcli';
    Query.ParamByName('codcli').AsInteger := CodCli;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

end.

