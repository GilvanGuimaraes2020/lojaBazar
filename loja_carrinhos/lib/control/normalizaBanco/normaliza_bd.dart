import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/view/shared/messages/idDocs.dart';

class NormalizaBd{

Future<Map<String, dynamic>> registroAntigo(DateTime data)async{
  IdDocs ids = IdDocs.ids(data: data);
  DocumentReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("48yPK84Rbpi307lcrUBq").collection("contasVariadas").doc(ids.idDoc);
  Map<String , dynamic> map;
  await reference.get().then((value) {
    map = {"id":value.id, 
            "dados": value.data()};
  });
  print(map);
  return map;
} 

Future<String> registraNovo(String categoria, List lista, DateTime data)async{
  IdDocs ids = IdDocs.ids(data: data);
      
     CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection(ids.idDoc);

  await reference.doc(categoria).set({ids.diaDoc: FieldValue.arrayUnion(lista)},SetOptions(merge: true)  ).then((value){
    print("salvo com sucesso");  
    
  })
  .catchError((onError){
    print(onError);
    return onError.toString();
  });
  return "Salvo com sucesso";
  }


}