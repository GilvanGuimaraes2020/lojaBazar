import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../view/screens/models/modelsOfDB/m_DB_entradas_cash.dart';

class ReadMovimento{
   
   Future<List<MDBEntradasCash>> readDados()async{

       DocumentReference docReference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection("2022-1").doc("combustivel");
        List<MDBEntradasCash> entradas = [];
      await docReference.get().then((value) {     
        
        Map<String , dynamic> valuesBanco = value.data();

        valuesBanco.forEach((key, val) {
          for (var item in val) {
            entradas.add(MDBEntradasCash.fromMap(key, item));
          }
        });
            
    });
    return entradas;

   }
}