unit pedidovenda.controller;

interface

uses
  Vcl.ComCtrls,
  Vcl.StdCtrls,
  Vcl.Controls,
  FireDAC.Comp.Client,
  FireDAC.VCLUI.Wait,
  System.SysUtils,
  Vcl.Dialogs,
  Vcl.Forms,
  Winapi.Windows,
  form.PedidoVenda;

type
  iPedidoVendaController = interface
    ['{AF49F832-179D-4E2A-9F96-E34F67553218}']
    procedure carregarCliente(pCodCli: Integer; pEditCodCli, pEditDescrCli: TEdit);
    procedure carregarProduto(pCodProd: string; pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd: TEdit);
    procedure adicionaProdGrid(pCodProd: string; pEditIndex, pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd, pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
    procedure editaProdGrid(pCodProd: string; pEditIndex, pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd, pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
    procedure removerProdGrid(pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
    procedure calculaTotalGrid(pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
    procedure controlaBotoesPedido(pFormPed: TformPedidoVenda);

    procedure removerPedido(pFormPed: TformPedidoVenda);
    procedure gravarPedido(pFormPed: TformPedidoVenda);
    procedure carregarPedido(pFormPed: TformPedidoVenda);
  end;

  TPedidoVendaController = class(TInterfacedObject, iPedidoVendaController)
  private
    procedure calculaTotalGrid(pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
  public
    FConexao: TFDConnection;
    class function New(AConexao: TFDConnection): iPedidoVendaController;
    constructor Create(AConexao: TFDConnection);

    procedure removerPedido(pFormPed: TformPedidoVenda);
    procedure gravarPedido(pFormPed: TformPedidoVenda);
    procedure carregarPedido(pFormPed: TformPedidoVenda);

    procedure controlaBotoesPedido(pFormPed: TformPedidoVenda);
    procedure carregarCliente(pCodCli: Integer; pEditCodCli, pEditDescrCli: TEdit);
    procedure carregarProduto(pCodProd: string; pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd: TEdit);
    procedure adicionaProdGrid(pCodProd: string; pEditIndex, pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd, pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
    procedure editaProdGrid(pCodProd: string; pEditIndex, pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd, pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
    procedure removerProdGrid(pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
  end;

implementation

uses
  cliente.dto,
  cliente.dao,
  produto.dto,
  produto.dao,
  pedidoscab.dto,
  pedidoscab.dao,
  pedidositens.dto,
  pedidositens.dao;


{ TPedidoVendaController }

constructor TPedidoVendaController.Create(AConexao: TFDConnection);
begin
  inherited Create;
  FConexao := AConexao;
end;

class function TPedidoVendaController.New(AConexao: TFDConnection): iPedidoVendaController;
begin
  Result := Self.Create(AConexao);
end;

procedure TPedidoVendaController.carregarCliente(pCodCli: Integer; pEditCodCli, pEditDescrCli: TEdit);
var
  clienteDAO: TClienteDAO;
  clienteDTO: TClienteDTO;
begin
  try
    clienteDAO := TClienteDAO.Create(Self.FConexao);
    clienteDTO := clienteDAO.ConsultarPorCodigo(pCodCli);

    if clienteDTO <> nil then
    begin
      if pEditCodCli <> nil then
      begin
        TEdit(pEditCodCli).Text := IntToStr(clienteDTO.CodCli);
      end;
      if pEditDescrCli <> nil then
      begin
        TEdit(pEditDescrCli).Text := clienteDTO.Nome;
      end;
    end;
  finally
    clienteDAO.Free;
    clienteDTO.Free;
  end;
end;

procedure TPedidoVendaController.carregarProduto(pCodProd: string; pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd: TEdit);
var
  produtoDAO: TProdutoDAO;
  produtoDTO: TProdutoDTO;
begin
  try
    produtoDAO := TProdutoDAO.Create(Self.FConexao);
    produtoDTO := produtoDAO.ConsultarPorCodigo(pCodProd);

    if produtoDTO <> nil then
    begin
      if pEditCodProd <> nil then
      begin
        TEdit(pEditCodProd).Text := produtoDTO.CodProd;
      end;
      if pEditDescrProd <> nil then
      begin
        TEdit(pEditDescrProd).Text := produtoDTO.Descricao;
      end;
      if pEditVlrUnitProd <> nil then
      begin
        TEdit(pEditVlrUnitProd).Text := FormatFloat('0.00', produtoDTO.PrecoVenda);
      end;
      if pEditQtdProd <> nil then
      begin
        TEdit(pEditQtdProd).Text := '0';
      end;
    end;
  finally
    produtoDAO.Free;
    produtoDTO.Free;
  end;
end;

procedure TPedidoVendaController.adicionaProdGrid(pCodProd: string; pEditIndex, pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd, pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
var
  iIndex: Integer;
  iItem: TListItem;
begin
  iIndex := -1;
  if pEditIndex <> nil then
  begin
    if Trim(TEdit(pEditIndex).Text) <> EMptyStr then
    begin
      iIndex := StrToIntDef(Trim(TEdit(pEditIndex).Text), -1);
    end;
  end;

  if iIndex > -1 then
  begin
    if pEditCodProd <> nil then
    begin
      pLsvGrid.Items[iIndex].SubItems[0] := TEdit(pEditCodProd).Text;
    end;
    if pEditDescrProd <> nil then
    begin
      pLsvGrid.Items[iIndex].SubItems[1] := TEdit(pEditDescrProd).Text;
    end;
    if pEditQtdProd <> nil then
    begin
      pLsvGrid.Items[iIndex].SubItems[2] := TEdit(pEditQtdProd).Text;
    end;
    if pEditVlrUnitProd <> nil then
    begin
      pLsvGrid.Items[iIndex].SubItems[3] := TEdit(pEditVlrUnitProd).Text;
    end;

    pLsvGrid.Items[iIndex].SubItems[4] := FormatFloat('0.00', StrToFloatDef(TEdit(pEditQtdProd).Text, 0) * StrToFloatDef(TEdit(pEditVlrUnitProd).Text, 0));
  end
  else
  begin
    iItem := pLsvGrid.Items.Add;
    iItem.Caption := ''; //IntToStr(iItem.Index);
    if pEditCodProd <> nil then
    begin
      iItem.SubItems.Add( TEdit(pEditCodProd).Text );
    end;
    if pEditDescrProd <> nil then
    begin
      iItem.SubItems.Add( TEdit(pEditDescrProd).Text );
    end;
    if pEditQtdProd <> nil then
    begin
      iItem.SubItems.Add( TEdit(pEditQtdProd).Text );
    end;
    if pEditVlrUnitProd <> nil then
    begin
      iItem.SubItems.Add( TEdit(pEditVlrUnitProd).Text );
    end;
    iItem.SubItems.Add( FormatFloat('0.00', StrToFloatDef(TEdit(pEditQtdProd).Text, 0) * StrToFloatDef(TEdit(pEditVlrUnitProd).Text, 0)) );
  end;


  if pEditIndex <> nil then
  begin
    TEdit(pEditIndex).Clear;
  end;
  if pEditDescrProd <> nil then
  begin
    TEdit(pEditDescrProd).Clear;
  end;
  if pEditQtdProd <> nil then
  begin
    TEdit(pEditQtdProd).Clear;
  end;
  if pEditVlrUnitProd <> nil then
  begin
    TEdit(pEditVlrUnitProd).Clear;
  end;
  if pEditCodProd <> nil then
  begin
    TEdit(pEditCodProd).Clear;
    if TEdit(pEditCodProd).CanFocus then
    begin
      TEdit(pEditCodProd).SetFocus;
    end;
  end;

  calculaTotalGrid(pEditVlrTotalPed, pLsvGrid);
end;

procedure TPedidoVendaController.editaProdGrid(pCodProd: string; pEditIndex, pEditCodProd, pEditDescrProd, pEditQtdProd, pEditVlrUnitProd, pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
var
  iItem: TListItem;
begin
  if pLsvGrid.SelCount > 0 then
  begin
    if pEditIndex <> nil then
    begin
      TEdit(pEditIndex).Text := IntToStr(pLsvGrid.Selected.Index);
    end;
    if pEditCodProd <> nil then
    begin
      TEdit(pEditCodProd).Text := pLsvGrid.Items[pLsvGrid.Selected.Index].SubItems[0];
    end;
    if pEditDescrProd <> nil then
    begin
      TEdit(pEditDescrProd).Text := pLsvGrid.Items[pLsvGrid.Selected.Index].SubItems[1];
    end;
    if pEditQtdProd <> nil then
    begin
      TEdit(pEditQtdProd).Text := pLsvGrid.Items[pLsvGrid.Selected.Index].SubItems[2];
    end;
    if pEditVlrUnitProd <> nil then
    begin
      TEdit(pEditVlrUnitProd).Text := pLsvGrid.Items[pLsvGrid.Selected.Index].SubItems[3];
    end;

    calculaTotalGrid(pEditVlrTotalPed, pLsvGrid);
  end;
end;

procedure TPedidoVendaController.removerPedido(pFormPed: TformPedidoVenda);
var
  Query: TFDQuery;
  iNumPed: Integer;
begin
  try
    try
      Query := TFDQuery.Create(nil);
      Query.Connection := Self.FConexao;

      iNumPed := StrToIntDef( InputBox('Remover pedido', 'Informe um número inteiro:', ''), 0);

      if iNumPed > 0 then
      begin
        Self.FConexao.StartTransaction;

        Query.SQL.Clear;
        Query.Params.Clear;
        Query.SQL.Add('DELETE FROM pedidositens WHERE numped = :numped ');
        Query.ParamByName('numped').AsLargeInt := iNumPed;
        Query.ExecSQL;

        Query.SQL.Clear;
        Query.Params.Clear;
        Query.SQL.Add('DELETE FROM pedidoscab WHERE numped = :numped ');
        Query.ParamByName('numped').AsLargeInt := iNumPed;
        Query.ExecSQL;

        Self.FConexao.Commit;
        ShowMessage(Pchar(Format('Pedido de número %s removido com sucesso!', [IntToStr(iNumPed)])));
      end;

    finally
      Query.Free;
    end;
  except
    on E: Exception do
    begin
      Self.FConexao.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TPedidoVendaController.removerProdGrid(pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
var
  iItem: TListItem;
begin
  if pLsvGrid.SelCount > 0 then
  begin
    if Application.MessageBox(Pchar('Deseja excluir ítem do grid ?'), Pchar('Exclusão ítem'), mb_yesNo + mb_IconQuestion) = mrYes then
    begin
      pLsvGrid.DeleteSelected;
    end;
  end;
  calculaTotalGrid(pEditVlrTotalPed, pLsvGrid);
end;

procedure TPedidoVendaController.calculaTotalGrid(pEditVlrTotalPed: TEdit; pLsvGrid: TListView);
var
  iIdx: Integer;
  iVlrTot: Double;
  iItem: TListItem;
begin
  iVlrTot := 0;

  if pLsvGrid <> nil then
  begin
    for iIdx := 0 to pLsvGrid.Items.Count - 1 do
    begin
      iVlrTot := iVlrTot + StrToFloatDef(pLsvGrid.Items[iIdx].SubItems[4], 0);
    end;
  end;

  if pEditVlrTotalPed <> nil then
  begin
    TEdit(pEditVlrTotalPed).Text := FormatFloat('0.00', iVlrTot);
  end;
end;

procedure TPedidoVendaController.gravarPedido(pFormPed: TformPedidoVenda);
var
  iIdx: Integer;
  Query: TFDQuery;
  pedcabDTO: TPedidosCabDTO;
  pedcabDAO: TPedidosCabDAO;
  peditemDTO: TPedidosItensDTO;
  peditemDAO: TPedidosItensDAO;
begin
  try
    try
      Query := TFDQuery.Create(nil);
      Query.Connection := Self.FConexao;
      pedcabDAO := TPedidosCabDAO.Create(Self.FConexao);
      pedcabDTO := TPedidosCabDTO.Create;
      peditemDAO := TPedidosItensDAO.Create(Self.FConexao);
      peditemDTO := TPedidosItensDTO.Create;

      Self.FConexao.StartTransaction;

      pedcabDTO.NumPed := StrToIntDef(pFormPed.edtNumPed.Text, 0);
      pedcabDTO.DataEmissao := Now();
      pedcabDTO.CodCli := StrToIntDef(pFormPed.edtCodCliente.Text, 0);
      pedcabDTO.ValorTotal := StrToFloatDef(pFormPed.edtVlrTotalPed.Text, 0);

      if pedcabDTO.NumPed > 0 then
      begin
        pedcabDAO.Atualizar(pedcabDTO)
      end
      else
      begin
        pedcabDTO.NumPed := pedcabDAO.Inserir(pedcabDTO);
      end;

      Query.SQL.Add('DELETE FROM pedidositens WHERE numped = :numped ');
      Query.ParamByName('numped').AsLargeInt := pedcabDTO.NumPed;
      Query.ExecSQL;

      for iIdx := 0 to pFormPed.lsvItens.Items.Count -1 do
      begin
        peditemDTO.Limpar;
        peditemDTO.NumPed := pedcabDTO.NumPed;
        peditemDTO.CodProd := pFormPed.lsvItens.Items[iIdx].SubItems[0];
        peditemDTO.Quantidade := StrToFloatDef(pFormPed.lsvItens.Items[iIdx].SubItems[2], 0);
        peditemDTO.ValorUnit := StrToFloatDef(pFormPed.lsvItens.Items[iIdx].SubItems[3], 0);
        peditemDTO.ValorTotal := StrToFloatDef(pFormPed.lsvItens.Items[iIdx].SubItems[2], 0) * StrToFloatDef(pFormPed.lsvItens.Items[iIdx].SubItems[3], 0);

        peditemDAO.Inserir(peditemDTO)
      end;

      Self.FConexao.Commit;

      pFormPed.edtNumPed.Text := IntToStr(pedcabDTO.NumPed);
      pFormPed.edtDataPedido.Text := FormatDateTime('dd/mm/yyyy', pedcabDTO.DataEmissao);
    finally
      Query.Free;
      pedcabDTO.Free;
      pedcabDAO.Free;
      peditemDTO.Free;
      peditemDAO.Free;
    end;
  except
    on E: Exception do
    begin
      Self.FConexao.Rollback;
      raise Exception.Create(E.Message);
    end;
  end;
end;

procedure TPedidoVendaController.carregarPedido(pFormPed: TformPedidoVenda);
var
  iNumPed: Integer;
  Query: TFDQuery;
  iItem: TListItem;
  pedcabDTO: TPedidosCabDTO;
  pedcabDAO: TPedidosCabDAO;

begin
  iNumPed := StrToIntDef( InputBox('Carregar pedido', 'Informe um número inteiro:', ''), 0);

  if iNumPed > 0  then
  begin
    pedcabDAO := TPedidosCabDAO.Create(Self.FConexao);

    pedcabDTO := pedcabDAO.ObterPedido( iNumPed );
    if pedcabDTO <> nil then
    begin
      pFormPed.edtNumPed.Text := IntToStr(pedcabDTO.NumPed);
      pFormPed.edtDataPedido.Text := FormatDateTime('dd/mm/yyyy', pedcabDTO.DataEmissao);
      pFormPed.edtCodCliente.Text := IntToStr(pedcabDTO.CodCli);
      pFormPed.edtNomeCliente.Text := pedcabDTO.NomeCli;
      pFormPed.edtVlrTotalPed.Text := FormatFloat('0.00', pedcabDTO.ValorTotal);

      try
        Query := TFDQuery.Create(nil);
        Query.Connection := Self.FConexao;
        Query.SQL.Add('SELECT ');
        Query.SQL.Add('   i.codprod ');
        Query.SQL.Add('  ,i.quantidade ');
        Query.SQL.Add('  ,i.valorunit ');
        Query.SQL.Add('  ,i.valortotal ');
        Query.SQL.Add('  ,p.descricao ');
        Query.SQL.Add('FROM pedidositens i ');
        Query.SQL.Add('join produtos p ');
        Query.SQL.Add('  on p.codprod = i.codprod ');
        Query.SQL.Add('WHERE i.numped = :numped ');
        Query.ParamByName('numped').AsLargeInt := iNumPed;
        Query.Open;

        pFormPed.lsvItens.Items.Clear;
        while not Query.Eof do
        begin
          iItem := pFormPed.lsvItens.Items.Add;
          iItem.Caption := IntToStr(iItem.Index);
          iItem.SubItems.Add(Query.FieldByName('codprod').AsString);
          iItem.SubItems.Add(Query.FieldByName('descricao').AsString);
          iItem.SubItems.Add(Query.FieldByName('quantidade').AsString);
          iItem.SubItems.Add(FormatFloat('0.00', Query.FieldByName('valorunit').AsFloat));
          iItem.SubItems.Add(FormatFloat('0.00', Query.FieldByName('quantidade').AsFloat * Query.FieldByName('valorunit').AsFloat));

          Query.Next;
        end;
      finally
        Query.Free;
      end;
    end
    else
    begin
      ShowMessage(Pchar(Format('Pedido de número %s não encontrado!', [IntToStr(iNumPed)])));
    end;
  end;
end;

procedure TPedidoVendaController.controlaBotoesPedido(pFormPed: TformPedidoVenda);
begin
  pFormPed.btnCarregarPed.Enabled := (Trim(pFormPed.edtCodCliente.Text) = EmptYstr);
  pFormPed.btnCancelarPed.Enabled := (Trim(pFormPed.edtCodCliente.Text) = EmptYstr);
  pFormPed.btnGravarPed.Enabled := (Trim(pFormPed.edtCodCliente.Text) <> EmptYstr) and (pFormPed.lsvItens.Items.Count > 0);
end;


end.


