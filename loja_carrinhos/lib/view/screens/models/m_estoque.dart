import 'package:cloud_firestore/cloud_firestore.dart';

class Estoque{
 String id;
  String resCliente;  
  String resProduto;
  String codCliente;
  String codProduto;
  String valor;
  String status;
  Timestamp data;
  String cor;
  

  Estoque(this.id, this.resCliente, this.resProduto, this.codCliente, this.codProduto, 
  this.valor, this.status, this.data, this.cor);

  Estoque.fromMap(Map<String , dynamic>map , String id) {
   this.id = id ?? '';
    this.resCliente = map['resCliente'];
    this.resProduto = map['resProduto'];    
    this.codCliente = map['codCliente'];
    this.codProduto = map['codProduto'];
    this.valor = map['valor'];
    this.status = map['status'];
    this.data = map['data'];
    this.cor = map['corProduto'];

  }
  
}