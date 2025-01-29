unit form.PedidoVenda;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ComCtrls,
  form.principal;

type
  TformPedidoVenda = class(TForm)
    produtos: TGroupBox;
    lsvItens: TListView;
    Label1: TLabel;
    edtVlrTotalPed: TEdit;
    lblNumPed: TLabel;
    edtNumPed: TEdit;
    edtDataPedido: TEdit;
    lblDataPedido: TLabel;
    edtCodCliente: TEdit;
    lblCodCliente: TLabel;
    GroupBox1: TGroupBox;
    lblCodProd: TLabel;
    edtCodProd: TEdit;
    lblDescricao: TLabel;
    edtDescrProd: TEdit;
    lblQuantidade: TLabel;
    edtQtdProd: TEdit;
    edtVlrUnitProd: TEdit;
    lblValorUnitario: TLabel;
    Button1: TButton;
    edtNomeCliente: TEdit;
    edtItemIndex: TEdit;
    btnGravarPed: TButton;
    btnCarregarPed: TButton;
    btnCancelarPed: TButton;
    procedure edtQtdProdExit(Sender: TObject);
    procedure edtVlrUnitProdExit(Sender: TObject);
    procedure edtQtdProdKeyPress(Sender: TObject; var Key: Char);
    procedure edtVlrUnitProdKeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtCodClienteExit(Sender: TObject);
    procedure edtCodProdExit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure lsvItensKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCarregarPedClick(Sender: TObject);
    procedure btnGravarPedClick(Sender: TObject);
    procedure edtCodClienteChange(Sender: TObject);
    procedure btnCancelarPedClick(Sender: TObject);
    procedure lsvItensInsert(Sender: TObject; Item: TListItem);
    procedure lsvItensDeletion(Sender: TObject; Item: TListItem);
    procedure FormShow(Sender: TObject);
    procedure lsvItensDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  formPedidoVenda: TformPedidoVenda;

implementation

{$R *.dfm}

uses
  Utilitarios,
  pedidovenda.controller;

procedure TformPedidoVenda.btnCancelarPedClick(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).removerPedido( Self );
end;

procedure TformPedidoVenda.btnCarregarPedClick(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).carregarPedido( Self );
end;

procedure TformPedidoVenda.btnGravarPedClick(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).gravarPedido( Self );
end;

procedure TformPedidoVenda.Button1Click(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).adicionaProdGrid( edtCodProd.Text, edtItemIndex, edtCodProd, edtDescrProd, edtQtdProd, edtVlrUnitProd, edtVlrTotalPed, lsvItens );
end;

procedure TformPedidoVenda.edtCodClienteChange(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).controlaBotoesPedido( Self );
end;

procedure TformPedidoVenda.edtCodClienteExit(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).carregarCliente( StrToIntDef(TEdit(Sender).Text, 0), TEdit(Sender), edtNomeCliente );
end;

procedure TformPedidoVenda.edtCodProdExit(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).carregarProduto( TEdit(Sender).Text, TEdit(Sender), edtDescrProd, edtQtdProd, edtVlrUnitProd );
end;

procedure TformPedidoVenda.edtQtdProdExit(Sender: TObject);
begin
  utilitarios.FormatarDecimaisExit(TEdit(Sender), 6);
end;

procedure TformPedidoVenda.edtQtdProdKeyPress(Sender: TObject; var Key: Char);
begin
  utilitarios.ValorKeyPress(Sender, Key, 6);
end;

procedure TformPedidoVenda.edtVlrUnitProdExit(Sender: TObject);
begin
  utilitarios.FormatarDecimaisExit(TEdit(Sender), 2);
end;

procedure TformPedidoVenda.edtVlrUnitProdKeyPress(Sender: TObject; var Key: Char);
begin
  utilitarios.ValorKeyPress(Sender, Key, 2);
end;

procedure TformPedidoVenda.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  formPedidoVenda := nil;
  Action := caFree;
end;

procedure TformPedidoVenda.FormShow(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).controlaBotoesPedido( Self );
end;

procedure TformPedidoVenda.lsvItensDblClick(Sender: TObject);
begin
  TPedidoVendaController.New(form.Principal.FConexao).editaProdGrid( edtCodProd.Text, edtItemIndex, edtCodProd, edtDescrProd, edtQtdProd, edtVlrUnitProd, edtVlrTotalPed, lsvItens );
end;

procedure TformPedidoVenda.lsvItensDeletion(Sender: TObject; Item: TListItem);
begin
  TPedidoVendaController.New(form.Principal.FConexao).controlaBotoesPedido( Self );
end;

procedure TformPedidoVenda.lsvItensInsert(Sender: TObject; Item: TListItem);
begin
  TPedidoVendaController.New(form.Principal.FConexao).controlaBotoesPedido( Self );
end;

procedure TformPedidoVenda.lsvItensKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
    begin
      TPedidoVendaController.New(form.Principal.FConexao).editaProdGrid( edtCodProd.Text, edtItemIndex, edtCodProd, edtDescrProd, edtQtdProd, edtVlrUnitProd, edtVlrTotalPed, lsvItens );
    end;

    VK_DELETE:
    begin
      TPedidoVendaController.New(form.Principal.FConexao).removerProdGrid( edtVlrTotalPed, lsvItens );
    end;
  end;
end;

end.

