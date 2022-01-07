import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';

import '../../../view/shared/messages/idDocs.dart';

class ReadValuesContas{

  Future<Map<String , dynamic>> readValuesContas(DateTime data , String banco)async{
    IdDocs ids = IdDocs.ids(data: data);
    CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("CContas").collection(ids.anoDoc);
    Map<String , dynamic> x;
    
    Map mapBanco;
    //busca no banco os gastos referentes ao mes e o total
    await reference.doc(banco).get().then((value){
      mapBanco = value.data();
    }).catchError((onError){
     return {'erro':RetornoEventos().erro};
    }); 
//Caso nao haja campo criado no banco os valores virao setados com 0
      x = { 
        ids.idDoc : mapBanco[ids.idDoc]!=null?mapBanco[ids.idDoc]:0, 
        'total':mapBanco['total']!=null?mapBanco['total']:0};
    print(x);
    return x ;
  }

  
}

