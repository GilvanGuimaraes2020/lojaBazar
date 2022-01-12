import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/view/shared/messages/listas.dart';

class WriteResumoCaixa{
DocumentReference<Map> resumo = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas");
 /*  String banco;
  List lista;
  WriteResumoCaixa({this.banco, this.lista}); */
  
  String resetarValores(){
    
    List<String> categoria = ListsShared().dropCategorias;
    for (var item in categoria) {
      Map<String , dynamic> dado = {
        "resumoMovimento" : {
          item : {
            "total" : 0 
          }
        }
      };
      resumo.set(dado , SetOptions(merge: true)).
      catchError((erro){
        return "Erro resetar Dados";
      });  

    }
    resumo.set({"verificador":false}  ,SetOptions(merge: true));
    return "Sucesso resetar Dados";


}

String ativarVerificador(){
  resumo.set({"verificador" : true} , SetOptions(merge: true)).
  catchError((onError){
    return "Erro ao ativar verificador";
  });

    return "Sucesso ao ativar verificador";

}

String atualizaValores(String categoria,  double valorCorrente, String status, DateTime data){
var valor;

resumo.get().then((value) {
  valor = value.data()["resumoMovimento"];

});

status == "Entrada"?
valorCorrente = valorCorrente * 1:
valorCorrente = -1 * valorCorrente;

Map<String , dynamic> dado ={
"resumoMovimento" :{
  categoria :{
    'total' : valor[categoria] + valorCorrente
  }
}
};
resumo.set(dado , SetOptions(merge: true));
return null;
}


}