import 'package:cloud_firestore/cloud_firestore.dart';

class TratarDados {
 String valor;
 String tipoTransacao;
 String detalhe;
 String chave;
 String operacao;
 String dia;
 

 CollectionReference diario = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas');

 TratarDados(this.valor, this.detalhe, this.tipoTransacao, this.operacao, this.chave, this.dia);

 void selecionaOperacao(){
   this.operacao = this.detalhe.substring(this.detalhe.indexOf("-" ) + 1);
 }
 

 TratarDados.banco(dynamic dado, dynamic chave, dynamic dia){
 this.chave = chave;
 this.dia = dia;
   int z = 0;
 for(int i =0 ; i < 3; i++){
  

  if(i==0){
this.valor = dado.substring( z  , dado.indexOf(";" ,  z));
z =dado.indexOf(";" , z) + 1;
  }
 else if(i==1){
this.detalhe = dado.substring( z  , dado.indexOf(";" ,  z));
z =dado.indexOf(";" , z) + 1;
  } else if(i==2){
    this.tipoTransacao = dado.substring( z  , dado.length);

  }
  
 }

selecionaOperacao();


 }

 
}