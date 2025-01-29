unit pedidositens.DTO;

interface

type
  TPedidosItensDTO = class
  private
    FNumPed: Int64;
    FNumPedItem: Int64;
    FCodProd: string;
    FQuantidade: Double;
    FValorUnit: Double;
    FValorTotal: Double;

  public
    property NumPed: Int64 read FNumPed write FNumPed;
    property NumPedItem: Int64 read FNumPedItem write FNumPedItem;
    property CodProd: string read FCodProd write FCodProd;
    property Quantidade: Double read FQuantidade write FQuantidade;
    property ValorUnit: Double read FValorUnit write FValorUnit;
    property ValorTotal: Double read FValorTotal write FValorTotal;

    procedure Limpar;
  end;

implementation

{ TPedidosItensDTO }

procedure TPedidosItensDTO.Limpar;
begin
  FNumPed := 0;
  FNumPedItem := 0;
  FCodProd := '';
  FQuantidade := 0;
  FValorUnit := 0;
  FValorTotal := 0;
end;

end.

