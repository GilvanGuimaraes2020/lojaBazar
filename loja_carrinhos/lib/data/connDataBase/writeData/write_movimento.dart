import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_controle.dart';
import 'package:loja_carrinhos/view/shared/messages/idDocs.dart';


class WriteMovimento{

  Future<String> writeDados ({String categoria,  List lista, DateTime data}) async{
     
      IdDocs ids = IdDocs.ids(data: data);
      
     CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection(ids.idDoc);

  await reference.doc(categoria).set({ids.diaDoc: FieldValue.arrayUnion(lista)},SetOptions(merge: true)  ).then((value){
    print("salvo com sucesso");
    
  })
  .catchError((onError){
    
    return "Erro ao salvar Dados";
  });

   String retorno = WriteControle().writeDados("Salvo com Sucesso", data, lista);
    print("Retorno write_controle: $retorno");
    
    return "Salvo com Sucesso";

  }

  Future<String> getCompra (List compra , String idCompra)async{
    IdDocs ids = IdDocs.ids(data: compra[0]['data']);
      String status;
      List lista = [{
        "banco" : compra[0]['banco'],
        "detalhe": idCompra,
        "operacao":compra[0]['operacao'],
        "parcelas":0,
        "status":"Saida",
        "valor":double.tryParse(compra[0]['valor']) 
      }        
      ];
     CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection(ids.idDoc);
    await reference.doc("compra").set({ids.diaDoc: FieldValue.arrayUnion(lista)},SetOptions(merge: true)  ).then((value){
    print("salvo com sucesso");
    status = "salvo com sucesso";
    
  })
  .catchError((onError){
    
    status = "Erro ao salvar Dados";
  });

   String retorno = WriteControle().writeDados(status, compra[0]['data'], lista);
    print("Retorno write_controle: $retorno");
    
    return status;

  }
}