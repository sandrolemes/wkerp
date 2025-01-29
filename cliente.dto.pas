unit cliente.dto;

interface

type
  TClienteDTO = class
  private
    FCodcli: Int64;
    FNome: string;
    FCidade: string;
    FUf: string;
  public
    property Codcli: Int64 read FCodcli write FCodcli;
    property Nome: string read FNome write FNome;
    property Cidade: string read FCidade write FCidade;
    property Uf: string read FUf write FUf;

    constructor Create(ACodcli: Int64; ANome, ACidade, AUf: string); overload;
    constructor Create; overload; // Construtor padrão
  end;

implementation

{ TClienteDTO }

constructor TClienteDTO.Create(ACodcli: Int64; ANome, ACidade, AUf: string);
begin
  FCodcli := ACodcli;
  FNome := ANome;
  FCidade := ACidade;
  FUf := AUf;
end;

constructor TClienteDTO.Create;
begin
  inherited Create;
end;

end.

