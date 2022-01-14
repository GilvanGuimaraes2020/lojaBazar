import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';
import '../../../view/screens/models/modelsOfDB/m_DB_entradas_cash.dart';
import '../../../view/shared/messages/idDocs.dart';

class   ReadMovimento{
   
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
 Future<List<ListCashDB>> readResumoCaixa()async{
      DateTime data = DateTime.now();
      IdDocs ids = IdDocs.ids(data: data);
      CollectionReference listDB = FirebaseFirestore.instance.collection("MovimentoCaixa").doc('registroContas').collection(ids.idDoc);
      
      List<ListCashDB> lista = [];
       await listDB.get().then((value) {          
          lista = value.docs.map((e) => ListCashDB.fromMap(e.id, e.data())).toList();
        });
      
      return lista;

  }

  Future<List<ListCashDB>> viewsContas()async{
      DateTime data = DateTime.now();
      IdDocs ids = IdDocs.ids(data: data);
      CollectionReference listDB = FirebaseFirestore.instance.collection("MovimentoCaixa").doc('CContas').collection(ids.anoDoc);
      
      List<ListCashDB> lista = [];
       await listDB.get().then((value) {          
          lista = value.docs.map((e) => ListCashDB.viewConta(e.id, e.data())).toList();
        });
      
      return lista;

  }
  


   }
