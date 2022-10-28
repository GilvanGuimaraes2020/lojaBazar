import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_movimento.dart';
import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';

class WriteEstoque{

 Future<String> writeEstoque(Map<String , dynamic> map , List caixa, DateTime data)async{
   String status;
   //Salvamento no banco teste, o qual sera trocado pelo estoque
   CollectionReference reference = FirebaseFirestore.instance.collection("estoque");

  await reference.add(map).then((value) {
    status = RetornoEventos().salvo;
  }).catchError((onError){
    print("Erro write_estoque");
     status = RetornoEventos().erro;
   });

   if (status == RetornoEventos().salvo){
     status = await WriteMovimento().getCompra(caixa , data);
   }

   return status;

 }
}