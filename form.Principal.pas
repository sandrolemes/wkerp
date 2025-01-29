unit form.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, FireDAC.Comp.Client;

type
  TformPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Movimentao1: TMenuItem;
    PedidodeVenda1: TMenuItem;
    N1: TMenuItem;
    Sair1: TMenuItem;
    procedure Sair1Click(Sender: TObject);
    procedure PedidodeVenda1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FConexao: TFDConnection;
  formPrincipal: TformPrincipal;

implementation

{$R *.dfm}

uses
  form.PedidoVenda,
  conexao;

procedure TformPrincipal.FormCreate(Sender: TObject);
begin
  FConexao :=  conexao.ObterConexao();
end;

procedure TformPrincipal.PedidodeVenda1Click(Sender: TObject);
begin
  if formPedidoVenda = nil then
  begin
    Application.CreateForm(TformPedidoVenda, formPedidoVenda);
  end;
  formPedidoVenda.Show;
end;

procedure TformPrincipal.Sair1Click(Sender: TObject);
begin
  Application.Terminate;
end;

end.
