import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_entradas_cash.dart';

class DetailCashPage extends StatefulWidget {
  final String categoria;
  final String inOrOut;
  const DetailCashPage({ Key key, this.categoria,this.inOrOut }) ;


  @override
  State<DetailCashPage> createState() => _DetailCashPageState();
}

class _DetailCashPageState extends State<DetailCashPage> {
 
  DocumentReference docReference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("entradas").collection("2022-1").doc("combustivel");
  List<MDBEntradasCash> entradas = [];
  
 
 
  @override
  void initState(){
    super.initState();

    docReference.get().then((value) {
      setState(() {
        
        Map<String , dynamic> valuesBanco = value.data();

        valuesBanco.forEach((key, val) {
          for (var item in val) {
            entradas.add(MDBEntradasCash.fromMap(key, item));
          }
        });
      
      });
    });

  
  }

  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalhamento de conta"),
      ),
      body: Container(

        child: ListView.builder(
          itemCount: entradas.length,
          padding: EdgeInsets.all(5),          
          shrinkWrap: true,
          itemBuilder: (context , ind){
            return ListTile(
              title: Text(entradas[ind].detalhe),
              subtitle: Text("${entradas[ind].operacao} "),
            );
          }),
      ),
    );
  }
}