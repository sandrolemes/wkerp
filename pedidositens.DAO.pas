unit pedidositens.DAO;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  pedidositens.DTO;

type
  TPedidosItensDAO = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(AConnection: TFDConnection);
    procedure Inserir(const AItem: TPedidosItensDTO);
    function ObterItem(NumPedItem: Int64): TPedidosItensDTO;
    procedure Atualizar(const AItem: TPedidosItensDTO);
    procedure Deletar(NumPedItem: Int64);
  end;

implementation

constructor TPedidosItensDAO.Create(AConnection: TFDConnection);
begin
  FConnection := AConnection;
end;

procedure TPedidosItensDAO.Inserir(const AItem: TPedidosItensDTO);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'INSERT INTO pedidositens (numped, codprod, quantidade, valorunit, valortotal) ' +
                      'VALUES (:numped, :codprod, :quantidade, :valorunit, :valortotal)';
    Query.ParamByName('numped').AsLargeInt := AItem.NumPed;
    Query.ParamByName('codprod').AsString := AItem.CodProd;
    Query.ParamByName('quantidade').AsFloat := AItem.Quantidade;
    Query.ParamByName('valorunit').AsFloat := AItem.ValorUnit;
    Query.ParamByName('valortotal').AsFloat := AItem.ValorTotal;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

function TPedidosItensDAO.ObterItem(NumPedItem: Int64): TPedidosItensDTO;
var
  Query: TFDQuery;
  Item: TPedidosItensDTO;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'SELECT * FROM pedidositens WHERE numpeditem = :numpeditem';
    Query.ParamByName('numpeditem').AsLargeInt := NumPedItem;
    Query.Open;

    if not Query.IsEmpty then
    begin
      Item := TPedidosItensDTO.Create;
      Item.NumPed := Query.FieldByName('numped').AsLargeInt;
      Item.NumPedItem := Query.FieldByName('numpeditem').AsLargeInt;
      Item.CodProd := Query.FieldByName('codprod').AsString;
      Item.Quantidade := Query.FieldByName('quantidade').AsFloat;
      Item.ValorUnit := Query.FieldByName('valorunit').AsFloat;
      Item.ValorTotal := Query.FieldByName('valortotal').AsFloat;
      Result := Item;
    end
    else
      Result := nil;
  finally
    Query.Free;
  end;
end;

procedure TPedidosItensDAO.Atualizar(const AItem: TPedidosItensDTO);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'UPDATE pedidositens SET numped = :numped, codprod = :codprod, ' +
                      'quantidade = :quantidade, valorunit = :valorunit, valortotal = :valortotal ' +
                      'WHERE numpeditem = :numpeditem';
    Query.ParamByName('numped').AsLargeInt := AItem.NumPed;
    Query.ParamByName('numpeditem').AsLargeInt := AItem.NumPedItem;
    Query.ParamByName('codprod').AsString := AItem.CodProd;
    Query.ParamByName('quantidade').AsFloat := AItem.Quantidade;
    Query.ParamByName('valorunit').AsFloat := AItem.ValorUnit;
    Query.ParamByName('valortotal').AsFloat := AItem.ValorTotal;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

procedure TPedidosItensDAO.Deletar(NumPedItem: Int64);
var
  Query: TFDQuery;
begin
  Query := TFDQuery.Create(nil);
  try
    Query.Connection := FConnection;
    Query.SQL.Text := 'DELETE FROM pedidositens WHERE numpeditem = :numpeditem';
    Query.ParamByName('numpeditem').AsLargeInt := NumPedItem;
    Query.ExecSQL;
  finally
    Query.Free;
  end;
end;

end.

