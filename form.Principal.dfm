object formPrincipal: TformPrincipal
  Left = 0
  Top = 0
  Caption = 'WKErp '
  ClientHeight = 442
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  WindowState = wsMaximized
  OnCreate = FormCreate
  TextHeight = 15
  object MainMenu1: TMainMenu
    Left = 32
    Top = 16
    object Movimentao1: TMenuItem
      Caption = 'Movimenta'#231#227'o'
      object PedidodeVenda1: TMenuItem
        Caption = 'Pedido de Venda...'
        OnClick = PedidodeVenda1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Sair1: TMenuItem
        Caption = 'Sair...'
        OnClick = Sair1Click
      end
    end
  end
end
