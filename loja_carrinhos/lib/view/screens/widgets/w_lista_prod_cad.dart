import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../Models.dart';

class WlistaProdCad extends StatefulWidget {
  String codProduto;
  String produto;
  
   WlistaProdCad({ Key key, this.codProduto, this.produto }) ;

  @override
  _WlistaProdCadState createState() => _WlistaProdCadState();
}

class _WlistaProdCadState extends State<WlistaProdCad> {
  
   Future<List<Produtos>> gerarLista(FirebaseFirestore dbProduto) async{

  
  List<Produtos> produtos = [];
   await dbProduto.collection('produtos').orderBy('tipoProduto').get().then((doc) {
   
       produtos = doc.docs.map((e) => Produtos.fromMap(e.data(), e.id)).toList();
    
  });

  return Future.value(produtos) ;
}

  @override
  Widget build(BuildContext context) {
     
  var dbProduto = FirebaseFirestore.instance;
    
  List<Produtos> produtos = [];
  
 Future< List<Produtos>> futureList =  gerarLista(dbProduto) ;
 futureList.then((doc) {
   produtos = doc;
 });
  
   return Container(
       height: 300,
       width: 300,
       child: FutureBuilder<QuerySnapshot>(
         future: dbProduto.collection('produtos').get(),
        
       
       builder: (contexto , snapshot){
    switch (snapshot.connectionState) {
      case (ConnectionState.none) :
        return Center(child: Text("Nao conectou"),);

      case(ConnectionState.waiting):
       return Center(child: CircularProgressIndicator());
        
      default:
      return  ListView.builder(
        itemCount: produtos.length,
     
        itemBuilder: (contexto, index){
         
            return ListTile(
            title: Text('${produtos[index].tipoProduto} , ${produtos[index].marca} , ${produtos[index].modelo}',
         style: TextStyle(fontSize: 12, ),),
         onTap: (){
           widget.codProduto = produtos[index].codigo;
           widget.produto = produtos[index].tipoProduto + " " + produtos[index].marca;
           
           Navigator.pop(contexto);
         },
          );
          
          
        
        }
    ) ;
    }
       }
      
    ),
     );
  }
}