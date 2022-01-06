import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_movimento.dart';

class WriteEstoque{

 Future<String> writeEstoque(Map<String , dynamic> map , List caixa)async{
   String status;
   String id;
   CollectionReference reference = FirebaseFirestore.instance.collection("teste");

  await reference.add(map).then((value) {
    status = "Salvo com Sucesso";
    id = value.id;
  }).catchError((onError){
     status = "Erro ao salvar";
   });

   if (status == "Salvo com Sucesso"){
     status = await WriteMovimento().getCompra(caixa , id);
   }

   return status;

 }
}