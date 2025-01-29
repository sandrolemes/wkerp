program prjWKErp;

uses
  Vcl.Forms,
  form.Principal in 'form.Principal.pas' {formPrincipal},
  utilitarios in 'utilitarios.pas',
  form.PedidoVenda in 'form.PedidoVenda.pas' {formPedidoVenda},
  produto.dao in 'produto.dao.pas',
  Produto.dto in 'Produto.dto.pas',
  conexao in 'conexao.pas',
  pedidovenda.controller in 'pedidovenda.controller.pas',
  cliente.dao in 'cliente.dao.pas',
  cliente.dto in 'cliente.dto.pas',
  pedidosCab.DAO in 'pedidosCab.DAO.pas',
  pedidoscab.DTO in 'pedidoscab.DTO.pas',
  pedidositens.DTO in 'pedidositens.DTO.pas',
  pedidositens.DAO in 'pedidositens.DAO.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TformPrincipal, formPrincipal);
  Application.Run;
end.
