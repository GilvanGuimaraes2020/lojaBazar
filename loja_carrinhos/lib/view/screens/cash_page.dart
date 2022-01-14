


import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/readInitial/read_movimentoCaixa.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';
import 'package:loja_carrinhos/view/screens/routes/routes.dart';
import 'package:loja_carrinhos/view/screens/view_contas_page.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_cash_list.dart';
import 'package:loja_carrinhos/view/shared/messages/listas.dart';

class CashPage extends StatefulWidget {
  const CashPage({ Key key, String title });

  @override
  _CashPageState createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {
  bool datasBase = false;
//forma lista com as categorias
 List<String> categoria= ListsShared().dropCategorias;
  List<ListCashDB> listCash = [];
  @override
  Widget build(BuildContext context) { 
      
    if(!datasBase){
      print("Map vazio");
      //forma widgets quando nao houver dados
      for (var item in categoria) {
        //forma classe atribuindo total 0 para categorias
        if(!['compra' , 'venda'].contains(item)){
          listCash.add(ListCashDB.fromList(item));
        }        
      
      }
    } else{
      //Condicional para map com valores do banco
      print("map com valor");
    
      datasBase = false;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Movimento Caixa"),
        actions: [
          IconButton(
            onPressed: ()async{
             listCash = await ReadMovimento().viewsContas();
            Routes.rota(context, ViewContasPage(viewContas: listCash,));
            }, 
            icon: Icon(
              Icons.cabin,
              color: Colors.white,
              size: 24,)),
          IconButton(
        onPressed: ()async{
          listCash = await ReadMovimento().readResumoCaixa();
          setState((){
          listCash;
          datasBase = true;          
          });
        }, 
        icon:Icon(
          Icons.art_track,
          color: Colors.white,
          size: 24,) ,),
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