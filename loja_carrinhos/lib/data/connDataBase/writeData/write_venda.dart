import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_movimento.dart';

import '../../../view/shared/messages/retornoEventos.dart';

class WriteVenda{

  Future<String> writeVenda(Map<String , dynamic> map, List caixa , DateTime data, String idProduto)async{
    String status;
    String id;
   //Salvamento no banco teste, o qual sera trocado pelo estoque
   CollectionReference reference = FirebaseFirestore.instance.collection("testeVenda");

   CollectionReference refEstoque = FirebaseFirestore.instance.collection("teste");

  await reference.add(map).then((value) {
    refEstoque.doc(idProduto).update({"status": "0" });    
    status = RetornoEventos().salvo;
    print("$status write_venda");
    id = value.id;
  }).catchError((onError){
    
     status = RetornoEventos().erro;
     print("$status Erro write_Venda");
   });

   if (status == RetornoEventos().salvo){
     status = await WriteMovimento().getVenda(caixa , id, data);
   }

   return status;
  }


}