import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_builder_estoque.dart';
import 'package:loja_carrinhos/view/shared/messages/listas.dart';

import 'models/m_estoque.dart';

class EstoquePage extends StatefulWidget {
  @override
  _EstoquePageState createState() => _EstoquePageState();
}



class _EstoquePageState extends State<EstoquePage> {
List<Estoque> estoque ;
var db = FirebaseFirestore.instance;
StreamSubscription<QuerySnapshot> ouvidor;


@override
  void initState() {
    super.initState();
    ouvidor?.cancel();
    
    ouvidor = db.collection("estoque").
    orderBy("resProduto").
    where("status", isEqualTo: "1")
    .snapshots().listen((value) {
      setState(() {
        estoque = value.docs.map((e) => Estoque.fromMap(e.data(), e.id)).toList();
      });

    });    
    
  } 

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
        appBar: AppBar(
        title: Text("Estoque") ,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            ouvidor.cancel();
            Navigator.of(context).pop();
          },),),
       

        body: BuilderEstoque(estoque: estoque,), 

        floatingActionButton: IconButton(
          onPressed: (){           
     
     
   List<String> produtos = ListsShared().dropProdutos;
 
  Map<String , int> dados = Map();
  
  if (estoque.length > 0){

    produtos.forEach((e) {
     estoque.forEach((element)  {
      if(element.resProduto.contains(e)){
       // print("contem Elemento $e");
        if(!dados.containsKey(e) ){
        dados[e] = 1;
        }else if(dados.containsKey(e) ){
           dados[e] = dados[e] +  1;
        }
      } 
     });
    });
    List<String> listaKeys = dados.keys.toList();
    
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("${estoque.length} itens no estoque"),
                  content: Container(
                    height: 300,
                    width: double.maxFinite,
                    child: ListView.builder(
                      itemCount: listaKeys.length,
                      itemBuilder: (context , index){
                        return ListTile(
                          title: Text("${listaKeys[index]} : ${dados[listaKeys[index]]} itens"),
                        );
                      },

                    ),
                  ) ,

                  actions: [
                    ElevatedButton(
                      child: Text("ok"),
                      onPressed: (){
                        Navigator.pop(context);
                      },
                    )
                  ],

                );
              },
            );
          }
          
    
          }, 
          icon: Icon(Icons.plagiarism,
          size: 48, color: Colors.blue,)),
       
        );

   } 

   
  
}