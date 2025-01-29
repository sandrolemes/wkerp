unit pedidosCab.DAO;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  pedidosCab.DTO;

type
  TPedidosCabDAO = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    function Inserir(const APedido: TPedidosCabDTO): Int64;
    function ObterPedido(NumPed: Int64): TPedidosCabDTO;
    procedure Atualizar(const APedido: TPedidosCabDTO);
    procedure Deletar(NumPed: Int64);
  end;

implementation

constructor TPedidosCabDAO.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

function TPedidosCabDAO.Inserir(const APedido: TPedidosCabDTO): Int64;
var
  Query: TFDQuery;
begin
  Result := 0;
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'INSERT INTO pedidoscab (numped, dataemissao, codcli, valortotal) ' +
                      'VALUES (:numped, :dataemissao, :codcli, :valortotal)';
    Query.ParamByName('numped').AsLargeInt := APedido.NumPed;
    Query.ParamByName('dataemissao').AsDateTime := APedido.DataEmissao;
    Query.ParamByName('codcli').AsLargeInt := APedido.CodCli;
    Query.ParamByName('valortotal').AsFloat := APedido.ValorTotal;
    Query.ExecSQL;


    Query.SQL.Clear;
    Query.Params.Clear;
    Query.SQL.Add('SELECT LAST_INSERT_ID() AS NUMPED;');
    Query.Open;

    if not Query.IsEmpty then
    begin
      Result := Query.FieldByName('NUMPED').AsInteger;
    end;

  finally
    Query.Free;
  end;
end;

function TPedidosCabDAO.ObterPedido(NumPed: Int64): TPedidosCabDTO;
var
  Query: TFDQuery;
  Pedido: TPedidosCabDTO;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Add('SELECT ');

    Query.SQL.Add('   pc.numped ');
    Query.SQL.Add('  ,pc.dataemissao ');
    Query.SQL.Add('  ,pc.codcli ');
    Query.SQL.Add('  ,pc.valortotal ');
    Query.SQL.Add('  ,c.nome as nomecli ');
    Query.SQL.Add('FROM pedidoscab pc ');
    Query.SQL.Add('JOIN clientes c ');
    Query.SQL.Add('  ON c.codcli = pc.codcli ');
    Query.SQL.Add('WHERE numped = :numped ');
    Query.ParamByName('numped').AsLargeInt := NumPed;
    Query.Open;

    if not Query.IsEmpty then
    begin
      Pedido := TPedidosCabDTO.Create;
      Pedido.NumPed := Query.FieldByName('numped').AsLargeInt;
      Pedido.DataEmissao := Query.FieldByName('dataemissao').AsDateTime;
      Pedido.CodCli := Query.FieldByName('codcli').AsLargeInt;
      Pedido.NomeCli := Query.FieldByName('NomeCli').AsString;
      Pedido.ValorTotal := Query.FieldByName('valortotal').AsFloat;
      Result := Pedido;
    end
    else
      Result := nil;
  finally
    Query.Free;
  end;
end;

procedure TPedidosCabDAO.Atualizar(const APedido: TPedidosCabDTO);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'UPDATE pedidoscab SET dataemissao = :dataemissao, codcli = :codcli, ' +
                      'valortotal = :valortotal WHERE numped = :numped';
    Query.ParamByName('numped').AsLargeInt := APedido.NumPed;
    Query.ParamByName('dataemissao').AsDateTime := APedido.DataEmissao;
    Query.ParamByName('codcli').AsLargeInt := APedido.CodCli;
    Query.ParamByName('valortotal').AsFloat := APedido.ValorTotal;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TPedidosCabDAO.Deletar(NumPed: Int64);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'DELETE FROM pedidoscab WHERE numped = :numped';
    Query.ParamByName('numped').AsLargeInt := NumPed;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

end.

