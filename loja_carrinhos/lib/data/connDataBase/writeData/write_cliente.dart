import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';

class WriteCliente{
CollectionReference db = FirebaseFirestore.instance.collection("clientes");
 String status; 
  
  String atualizaCliente(String id, Map<String , dynamic> map){
 
 
 
 db.doc(id).set(map, SetOptions(merge: true)).then((value){
   
   status = RetornoEventos().salvo;
 }).catchError((onError){
   
   status = RetornoEventos().erro + onError;
   return status;
 });
    return status;
  }

   String salvaCliente(Map<String , dynamic> map){ 
String id;
 db.add(map).then((value){
      id = value.id;
 }).catchError((onError){
      status = RetornoEventos().erro + onError;
   return status;
 });
    return RetornoEventos().salvo + " $id" ;
  }

  String deleteCliente(String id){
    db.doc(id).delete().catchError((onError){
      return RetornoEventos().erro + onError;
    });
    return RetornoEventos().delete;
  }

}