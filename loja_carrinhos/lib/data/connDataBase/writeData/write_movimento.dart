import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_controle.dart';
import 'package:loja_carrinhos/view/shared/messages/idDocs.dart';
import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';


class WriteMovimento{
 /*  WriteResumoCaixa resumoCaixa = new WriteResumoCaixa();

  WriteMovimento({this.resumoCaixa}); */
  String status;

  Future<String> writeDados ({String categoria,  List lista, DateTime data}) async{
     
      IdDocs ids = IdDocs.ids(data: data);
      
     CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection(ids.idDoc);

  await reference.doc(categoria).set({ids.diaDoc: FieldValue.arrayUnion(lista)},SetOptions(merge: true)  ).then((value){
    print("salvo com sucesso");
    status = RetornoEventos().salvo;
    
  })
  .catchError((onError){
    status = RetornoEventos().erro;
    return RetornoEventos().erro;
  });

   String retorno = await WriteControle().writeDados(status, data, lista);
    print("Retorno write_controle: $retorno");
    
    return RetornoEventos().salvo;

  }

  Future<String> getCompra (List compra , DateTime data)async{
    IdDocs ids = IdDocs.ids(data: data);
      String status;     
      //salva dados em registro de contas no banco
     CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection(ids.idDoc);
   //abre a lista para extrair os dados
   for (var item in compra) {
      List lista = [{
        "banco" : item['banco'],
        "detalhe": item['detalhe'],
        "operacao":item['operacao'],
        "parcelas":0,
        "status":item['status'],
        "valor":item['valor']
      }        
      ];
      await reference.doc("compra").set({ids.diaDoc: FieldValue.arrayUnion(lista)},SetOptions(merge: true)  ).then((value){
    print("salvo com sucesso");
    status = RetornoEventos().salvo;
    
  })
  .catchError((onError){
    
    status = RetornoEventos().erro;
    return status;
  });

   }
   
   String retorno = await WriteControle().writeDados(status, data, compra);
    print("Retorno write_controle: $retorno");
    
    return status;

  }

  Future<String> getVenda (List compra , String idCompra, DateTime data)async{
    IdDocs ids = IdDocs.ids(data: data);
      String status;
     
     
      //salva dados em registro de contas no banco
     CollectionReference reference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("registroContas").collection(ids.idDoc);
   //abre a lista para extrair os dados
   for (var item in compra) {
      List lista = [{
        "banco" : item['banco'] + "-" + idCompra,
        "detalhe": item['detalhe'],
        "operacao":item['operacao'],
        "parcelas":int.tryParse(item['parcelas']),
        "status":item['status'],
        "valor":item['valor']
      }        
      ];
      await reference.doc("venda").set({ids.diaDoc: FieldValue.arrayUnion(lista)},SetOptions(merge: true)  ).then((value){
    
    status = RetornoEventos().salvo;
    print("$status write_movimento.getVendas");
  })
  .catchError((onError){
    
    status = RetornoEventos().erro;
    print("$status write_movimento.getVendas");
    return status;
  });

   }
   
   String retorno = await WriteControle().writeDados(status, data, compra);
    print("Retorno write_controle: $retorno");
    
    return status;

  }
}