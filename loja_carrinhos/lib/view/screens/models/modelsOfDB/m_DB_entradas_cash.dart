class MDBEntradasCash{
  
  String dia;
  String detalhe;
  String operacao;
  String banco;
  double parcelas;
  double valor;
   
  MDBEntradasCash({ this.dia, this.detalhe, this.operacao, this.banco, this.parcelas, this.valor});

  MDBEntradasCash.fromMap(String dia , Map<String , dynamic> map){
    this.dia = dia;
    this.detalhe = map['detalhe'];
    this.operacao = map['operacao'];
    this.banco = map['banco'];
    this.parcelas = map['parcelas'];
    this.valor = map['valor'];  
    
  }
}