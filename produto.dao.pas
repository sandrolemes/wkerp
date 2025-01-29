unit produto.dao;

interface

uses
  System.SysUtils,
  Data.DB,
  FireDAC.Comp.Client,
  produto.dto;

type


  TProdutoDAO = class
  private
    FConexao: TFDConnection;
  public
    constructor Create(AConexao: TFDConnection);
    function Inserir(const Produto: TProdutoDTO): Boolean;
    function Atualizar(const Produto: TProdutoDTO): Boolean;
    function Excluir(const CodProd: string): Boolean;
    function ConsultarPorCodigo(const CodProd: string): TProdutoDTO;
  end;


implementation


constructor TProdutoDAO.Create(AConexao: TFDConnection);
begin
  FConexao := AConexao;
end;

function TProdutoDAO.Inserir(const Produto: TProdutoDTO): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'INSERT INTO produtos (codprod, descricao, precovenda) VALUES (:codprod, :descricao, :precovenda)';
    Query.ParamByName('codprod').AsString := Produto.CodProd;
    Query.ParamByName('descricao').AsString := Produto.Descricao;
    Query.ParamByName('precovenda').AsFloat := Produto.PrecoVenda;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TProdutoDAO.Atualizar(const Produto: TProdutoDTO): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'UPDATE produtos SET descricao = :descricao, precovenda = :precovenda WHERE codprod = :codprod';
    Query.ParamByName('codprod').AsString := Produto.CodProd;
    Query.ParamByName('descricao').AsString := Produto.Descricao;
    Query.ParamByName('precovenda').AsFloat := Produto.PrecoVenda;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TProdutoDAO.Excluir(const CodProd: string): Boolean;
var
  Query: TFDQuery;
begin
  Result := False;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'DELETE FROM produtos WHERE codprod = :codprod';
    Query.ParamByName('codprod').AsString := CodProd;
    Query.ExecSQL;
    Result := True;
  finally
    Query.Free;
  end;
end;

function TProdutoDAO.ConsultarPorCodigo(const CodProd: string): TProdutoDTO;
var
  Query: TFDQuery;
  Produto: TProdutoDTO;
begin
  Result := nil;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConexao;
    Query.SQL.Text := 'SELECT codprod, descricao, precovenda FROM produtos WHERE codprod = :codprod';
    Query.ParamByName('codprod').AsString := CodProd;
    Query.Open;
    if not Query.IsEmpty then
    begin
      Produto := TProdutoDTO.Create;
      Produto.CodProd := Query.FieldByName('codprod').AsString;
      Produto.Descricao := Query.FieldByName('descricao').AsString;
      Produto.PrecoVenda := Query.FieldByName('precovenda').AsFloat;
      Result := Produto;
    end;
  finally
    Query.Free;
  end;
end;

end.
