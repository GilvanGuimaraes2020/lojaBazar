class MDBEntradasCash{
  
  String dia;
  String detalhe;
  String operacao;
  String banco;
  double parcelas;
  String valor;
  String status;
   
  MDBEntradasCash({ this.dia, this.detalhe, this.operacao, this.banco, this.parcelas, this.valor, this.status});

  MDBEntradasCash.fromMap(String dia , Map<String , dynamic> map){
    this.dia = dia;
    this.detalhe = map['detalhe'];
    this.operacao = map['operacao'];
    this.banco = map['banco'];
    this.parcelas = map['parcelas'];
    this.valor = map['valor']; 
    this.status = map['status']; 
    
  }
}