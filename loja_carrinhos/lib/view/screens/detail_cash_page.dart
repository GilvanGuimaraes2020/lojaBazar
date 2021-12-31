import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/readInitial/read_movimentoCaixa.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_entradas_cash.dart';

class DetailCashPage extends StatefulWidget {
  final String categoria;
  final String inOrOut;
  const DetailCashPage({ Key key, this.categoria,this.inOrOut }) ;

  @override
  State<DetailCashPage> createState() => _DetailCashPageState();
}

class _DetailCashPageState extends State<DetailCashPage> {
 
  
  @override
  Widget build(BuildContext context) {
   //List<MDBEntradasCash> entradas = ReadMovimento().readDados();
   return Scaffold(
      appBar: AppBar(
        title: Text("Detalhamento de conta"),
      ),
      body: FutureBuilder(
        future: ReadMovimento().readDados(),
        builder:(context , snapshot){
          
          if (snapshot.hasData){
            
             return Container(      
          child:ListView.builder(
            itemCount: snapshot.data.length,
            padding: EdgeInsets.all(5),          
            shrinkWrap: true,
            itemBuilder: (context , ind){
              return ListTile(
                title: Text(snapshot.data[ind].detalhe),
                subtitle: Text("${snapshot.data[ind].operacao} "),
              );
            }),
         
        );
          } else if(snapshot.hasError){
            return Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              );
          } else{
            return CircularProgressIndicator();
          }
          
           
        }
      ),

    );
  }
}

 