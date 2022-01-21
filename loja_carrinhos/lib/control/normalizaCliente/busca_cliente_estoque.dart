

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:loja_carrinhos/view/screens/models/m_estoque.dart';

class BuscaClienteEstoque{


  Future<List<Estoque>> listaCliente() async{
    List<Estoque> listEstoque = [];
    CollectionReference estoque = FirebaseFirestore.instance.collection("estoque");
    
    await estoque.where('status' , isEqualTo: "1")
    .get().then((value) {
      listEstoque =  value.docs.map((e) => Estoque.fromMap(e.data(), e.id) ).toList();
    });
    
  return listEstoque;
    
  }
}

class UpDateClient{
  

  buscaId(String idEstoque , String idcliente) async {
     CollectionReference teste = FirebaseFirestore.instance.collection("estoque");
    
    await teste.doc(idEstoque).set(
     {'codCliente' : idcliente} , SetOptions(merge: true));
    

  }

}

class BuscaCliente{

  Future<String> buscaCliente(String cod)async{
     CollectionReference cliente = FirebaseFirestore.instance.collection("clientes");

String t;
    
    await cliente.where("codigo" , isEqualTo: cod)
                  .get().then((value) =>  
                  t = value.docs.map((e)=> e.id ).first);
                 
                  return t;
  }
}

class DeletaCodigo{

  deletaCodigoCliente(String id)async{
         CollectionReference cliente = FirebaseFirestore.instance.collection("clientes");
        await cliente.doc(id).set({"codigo" : FieldValue.delete()} , SetOptions(merge: true));
  }
}