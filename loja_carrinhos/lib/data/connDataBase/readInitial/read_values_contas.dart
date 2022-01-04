import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../view/shared/messages/idDocs.dart';

class ReadValuesContas{

  Future<Map<String , dynamic>> readValuesContas(DateTime data , String banco)async{
    IdDocs ids = IdDocs.ids(data: data);
    CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("CContas").collection(ids.anoDoc);
    Map<String , dynamic> x;
    
    Map mapBanco;
    await reference.doc(banco).get().then((value){
      mapBanco = value.data();
    }).catchError((onError){
      x = {ids.idDoc : 0 , 'total' : 0};
    }); 

      x = { ids.idDoc : mapBanco[ids.idDoc], 'total':mapBanco['total']};
    return x ;
  }

  
}

