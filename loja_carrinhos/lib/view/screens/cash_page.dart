


import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/readInitial/read_movimentoCaixa.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_cash_list.dart';
import 'package:loja_carrinhos/view/shared/messages/listas.dart';

class CashPage extends StatefulWidget {
  const CashPage({ Key key, String title });

  @override
  _CashPageState createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {
  Map <String , dynamic> map = {};

 List<String> categoria= ListsShared().dropCategorias;

  @override
  Widget build(BuildContext context) { 
      List<ListCashDB> listCash = [];
    if(map.isEmpty){
      print("Map vazio");
      for (var item in categoria) {
        listCash.add(ListCashDB.fromList(item));
      }
    } else{
      
      print("map com valor");
      map['resumoMovimento'].forEach((key, value) {

        //if (!['verificador' , 'mesReferencia'].contains(key)){
        listCash.add(ListCashDB.fromMap(key, value));
      //} 
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Movimento Caixa"),
        actions: [
          Container(
          child: Row(
            children: [
              Text("VER"),
              IconButton(
        onPressed: ()async{
          map = await ReadMovimento().readResumoCaixa();
          setState((){
          map;
          print(map);
          });
        }, 
        icon:Icon(
          Icons.remove_red_eye_outlined,
          color: Colors.white,
          size: 24,) ,),
            ],
          ),
        ),
        ], ),

      body:  Container(
        child: Column(
            children: <Widget> [
               WcashList(listCash: listCash )
            ],
          ),
      ),
          
      

    );
  }
}