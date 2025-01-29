unit produto.dto;

interface

type
  TProdutoDTO = class
  private
    FCodProd: string;
    FDescricao: string;
    FPrecoVenda: Double;
  public
    property CodProd: string read FCodProd write FCodProd;
    property Descricao: string read FDescricao write FDescricao;
    property PrecoVenda: Double read FPrecoVenda write FPrecoVenda;
  end;

implementation

end.

