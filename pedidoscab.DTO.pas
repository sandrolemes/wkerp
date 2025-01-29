unit pedidoscab.DTO;

interface

type
  TPedidosCabDTO = class
  private
    FNumPed: Int64;
    FDataEmissao: TDateTime;
    FCodCli: Int64;
    FValorTotal: Double;
    FNomeCli: string;

  public
    property NumPed: Int64 read FNumPed write FNumPed;
    property DataEmissao: TDateTime read FDataEmissao write FDataEmissao;
    property CodCli: Int64 read FCodCli write FCodCli;
    property NomeCli: string read FNomeCli write FNomeCli;
    property ValorTotal: Double read FValorTotal write FValorTotal;
  end;

implementation

end.

