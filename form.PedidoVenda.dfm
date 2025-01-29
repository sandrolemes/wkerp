object formPedidoVenda: TformPedidoVenda
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'WKErp - Pedido de venda'
  ClientHeight = 500
  ClientWidth = 765
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIChild
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnShow = FormShow
  TextHeight = 15
  object lblNumPed: TLabel
    Left = 32
    Top = 33
    Width = 84
    Height = 15
    Caption = 'Pedido N'#250'mero'
  end
  object lblDataPedido: TLabel
    Left = 159
    Top = 33
    Width = 64
    Height = 15
    Caption = 'Data Pedido'
  end
  object lblCodCliente: TLabel
    Left = 32
    Top = 97
    Width = 65
    Height = 15
    Caption = 'C'#243'd. Cliente'
  end
  object produtos: TGroupBox
    Left = 32
    Top = 214
    Width = 713
    Height = 220
    Caption = #205'tens :'
    TabOrder = 0
    object Label1: TLabel
      Left = 537
      Top = 197
      Width = 25
      Height = 15
      Caption = 'Total'
    end
    object lsvItens: TListView
      Left = 3
      Top = 14
      Width = 705
      Height = 169
      Columns = <
        item
          Caption = 'numpeditem'
          Width = 0
        end
        item
          Caption = 'C'#243'd. Produto'
          Width = 100
        end
        item
          Caption = 'Descri'#231#227'o'
          Width = 300
        end
        item
          Alignment = taRightJustify
          Caption = 'Quantidade'
          Width = 85
        end
        item
          Alignment = taRightJustify
          Caption = 'Valor Unit.'
          Width = 85
        end
        item
          Alignment = taRightJustify
          Caption = 'Valor Total'
          Width = 100
        end>
      GridLines = True
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
      OnDblClick = lsvItensDblClick
      OnDeletion = lsvItensDeletion
      OnInsert = lsvItensInsert
      OnKeyDown = lsvItensKeyDown
    end
    object edtVlrTotalPed: TEdit
      Left = 568
      Top = 189
      Width = 106
      Height = 23
      Alignment = taRightJustify
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 1
    end
  end
  object edtNumPed: TEdit
    Left = 32
    Top = 54
    Width = 121
    Height = 23
    TabStop = False
    Color = clInfoBk
    ReadOnly = True
    TabOrder = 1
  end
  object edtDataPedido: TEdit
    Left = 159
    Top = 54
    Width = 121
    Height = 23
    TabStop = False
    Color = clInfoBk
    ReadOnly = True
    TabOrder = 2
  end
  object edtCodCliente: TEdit
    Left = 32
    Top = 118
    Width = 121
    Height = 23
    TabOrder = 3
    OnChange = edtCodClienteChange
    OnExit = edtCodClienteExit
  end
  object GroupBox1: TGroupBox
    Left = 32
    Top = 147
    Width = 713
    Height = 61
    TabOrder = 4
    object lblCodProd: TLabel
      Left = 5
      Top = 6
      Width = 71
      Height = 15
      Caption = 'C'#243'd. Produto'
    end
    object lblDescricao: TLabel
      Left = 132
      Top = 6
      Width = 51
      Height = 15
      Caption = 'Descricao'
    end
    object lblQuantidade: TLabel
      Left = 457
      Top = 6
      Width = 62
      Height = 15
      Caption = 'Quantidade'
    end
    object lblValorUnitario: TLabel
      Left = 558
      Top = 6
      Width = 71
      Height = 15
      Caption = 'Valor Unit'#225'rio'
    end
    object edtCodProd: TEdit
      Left = 5
      Top = 27
      Width = 121
      Height = 23
      TabOrder = 0
      OnExit = edtCodProdExit
    end
    object edtDescrProd: TEdit
      Left = 132
      Top = 27
      Width = 276
      Height = 23
      TabStop = False
      Color = clInfoBk
      ReadOnly = True
      TabOrder = 1
    end
    object edtQtdProd: TEdit
      Left = 414
      Top = 27
      Width = 105
      Height = 23
      Alignment = taRightJustify
      TabOrder = 2
      OnExit = edtQtdProdExit
      OnKeyPress = edtQtdProdKeyPress
    end
    object edtVlrUnitProd: TEdit
      Left = 525
      Top = 27
      Width = 104
      Height = 23
      Alignment = taRightJustify
      TabOrder = 3
      OnExit = edtVlrUnitProdExit
      OnKeyPress = edtVlrUnitProdKeyPress
    end
    object Button1: TButton
      Left = 635
      Top = 27
      Width = 73
      Height = 23
      Caption = 'Adicionar'
      TabOrder = 4
      OnClick = Button1Click
    end
    object edtItemIndex: TEdit
      Left = 21
      Top = 27
      Width = 20
      Height = 23
      TabOrder = 5
      Visible = False
      OnExit = edtCodProdExit
    end
  end
  object edtNomeCliente: TEdit
    Left = 159
    Top = 118
    Width = 586
    Height = 23
    TabStop = False
    Color = clInfoBk
    ReadOnly = True
    TabOrder = 5
  end
  object btnGravarPed: TButton
    Left = 421
    Top = 456
    Width = 104
    Height = 25
    Caption = 'Gravar Pedido'
    Enabled = False
    TabOrder = 6
    OnClick = btnGravarPedClick
  end
  object btnCarregarPed: TButton
    Left = 531
    Top = 456
    Width = 104
    Height = 25
    Caption = 'Carregar Pedido'
    Enabled = False
    TabOrder = 7
    OnClick = btnCarregarPedClick
  end
  object btnCancelarPed: TButton
    Left = 641
    Top = 456
    Width = 104
    Height = 25
    Caption = 'Cancelar Pedido'
    Enabled = False
    TabOrder = 8
    OnClick = btnCancelarPedClick
  end
end
