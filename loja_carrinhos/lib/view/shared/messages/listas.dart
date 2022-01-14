class ListsShared{
  List<String> dropCategorias = [
    
    'beleza',
    'combustivel',
    'contas',
    'compra',
    'doacao',
    'emprestimo',
    'estudo',
    'lazer',
    'mercado',
    'padaria',
    'pet',
    'recarga',
    'saude',
    'servicos',
    'utilidades',
    'veiculo',
    'venda'

  ];
  List<String> dropBancos =[
    'Nubank',
    'Sumup',
    'Caixa Giro',
    'Caixa Federal',
    'Bradesco',
    'Santander'
  ];
  List<String> dropPagamento = [
    'dinheiro',
    'pagamento alternativo',
    'transferencia',
    'credito',
    'maquina cartao'
  ];
  List<String> dropSexo =[
    'masculino',
    'feminino',
    'unissex'
  ];

  List<String> dropProdutos =['Carrinho' , 'Banheira','Eletronico', 'Andador', 'Berço','Chiqueirinho'
                        ,'Conjunto','Bebe Conf c base','Bebe Conf s base' ,'Cadeira p auto', 'Cadeirinha',
                        'Cadeirão','Selecione','tapete educ','Triciclo','Kit Berço','Kit Higiene', 'Lote Roupas','Colchão',
                        'Cobertor', 'Almofada', 'Carrinho Bug' ];

  List<String> dropMarca =['Galzerano' , 'Burigotto', 'BabyStyle' ,'Fischer Price', 'Tutti', 'Infanti', 'Chicco',
                    'Cosco', 'Voyage','Gracco', 'Safety', 'Peg-Perego' ,'Outros'];
//funçao para selecionar lista para dropdown
  List<String> selectList(String item){
    switch (item) {
      case "operacao":
        return this.dropCategorias;
        break;
      case "pagamento":
        return this.dropPagamento;
        break;
      case "banco":
        return this.dropBancos;
        break;
      case "sexo":
        return this.dropSexo;
        break;
      default:
        return [];
    }
  }
    
    
    
}