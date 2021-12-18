import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'Models.dart';

// ignore: must_be_immutable
class ListaProdutos extends StatefulWidget {
  @override
  _ListaProdutosState createState() => _ListaProdutosState();


}

class _ListaProdutosState extends State<ListaProdutos> {

var db = FirebaseFirestore.instance;
var dbCliente = FirebaseFirestore.instance;
List<Produtos> produto = [];
List<Produtos> produtoFilter = [];
bool aux;





StreamSubscription<QuerySnapshot> ouvidor;

@override
void initState(){  
  super.initState();
  ouvidor?.cancel();
   ouvidor = db.collection('produtos').orderBy('tipoProduto').snapshots().listen((res) {
     setState(() {
       produto = res.docs.map((e) => Produtos.fromMap(e.data(), e.id)).toList();
     });     
      
   });

}




 

  @override
  Widget build(BuildContext context) {
    //String teste = ModalRoute().
     //int x = 0;
     
    Map cliente = ModalRoute.of(context).settings.arguments;

    produtoFilter.clear();

    if (cliente != null ) {

      if(cliente['adressRoute'] == '/agenda'){
         for(int i = 0; i < produto.length; i++){
        print('entrou no for'); 
      
        if (produto[i].tipoProduto == cliente['tipoProduto'] ){
          print('entrou no if'); 
          produtoFilter.add(produto[i]);
          
         
        }    
      }
print('encontrou ${cliente['tipoProduto']}');
      } 
     
    } else{
      produtoFilter = produto;
    }

   
  

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Produtos Cadastrados"),
      ),

      body:StreamBuilder(
        stream: db.collection('produtos').snapshots(),
        builder: (context , snapshot){
          switch (snapshot.connectionState) {
            case (ConnectionState.none):
            return Center(child: Text("Conexao nao estabelecida"),);
            case (ConnectionState.waiting):
            return Center(child: CircularProgressIndicator());
            default:
            return ListView.builder(
                itemCount: produtoFilter.length,
                itemBuilder: (context , index){
                  return ListTile(
                    title: Text('${produtoFilter[index].tipoProduto} , ${produtoFilter[index].marca} , ${produtoFilter[index].modelo}',
                    style: TextStyle(fontSize: 16, ),),
                    
                    
                    trailing: IconButton(
                     icon: Icon(Icons.arrow_forward_ios_sharp),
                     tooltip: 'Realizar Compra', 
                     onPressed: (){
                       Map dados = cliente;
                        dados['codigoProduto'] = produtoFilter[index].codigo;
                       dados['produto'] = produtoFilter[index].tipoProduto;
                       dados['marca'] = produtoFilter[index].marca; 

                       Navigator.pushNamed(context, '/realizarCompra', arguments: dados);
                     },
                     ),
                  );
                },
              );
          }

        },
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Adicionar Produto',
        onPressed: (){
          Navigator.pushNamed(context, '/cadastroProduto');
        },),
      
    );
  }
}