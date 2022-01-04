class ListsShared{
  List<String> dropCategorias = [
    
    'beleza',
    'combustivel',
    'contas',
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
    'veiculo'

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
    'feminino'
  ];
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