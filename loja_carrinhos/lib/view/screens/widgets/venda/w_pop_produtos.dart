import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../models/m_estoque.dart';

// ignore: must_be_immutable
class WpopupProduto extends StatefulWidget {
  String produto;  
   WpopupProduto({ Key key, this.produto}) ;

  @override
  State<WpopupProduto> createState() => _WpopupProdutoState();
}

class _WpopupProdutoState extends State<WpopupProduto> {
 CollectionReference dbProduto = FirebaseFirestore.instance.collection("estoque");
 List<Estoque> listaProd = [];
 @override
 void initState(){
   super.initState();

  dbProduto.orderBy("resProduto").where("status", isEqualTo: "1").where("resProduto" , isGreaterThanOrEqualTo: widget.produto)
  .where("resProduto", isLessThanOrEqualTo: widget.produto + "z").get().then((value) {
   setState(() {
     listaProd = value.docs.map((e) => Estoque.fromMap(e.data(), e.id)).toList();
   }); 
  });
 }
  @override
  Widget build(BuildContext context)  {
    
    return AlertDialog(
        title: Text("Selecionar produto "),

        //Forma lista com cadastros ja realizados para verificar se ja esta salvo
        content: listaEstoque(listaProd),
        backgroundColor: Colors.blue[200],
        actions: [
          ElevatedButton(
            child: Text("Sair"),
            style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
        onPressed: (){
          Navigator.pop(context);
        
        },
      )
    ],
  );
    
  
  }

  listaEstoque(List<Estoque> lista){
    return Container(
      height: 300,
      width: 300,
      child: ListView.builder(
        itemCount: lista.length,
       
        itemBuilder: (context, index){
         
            return ListTile(
            title: Text("${lista[index].resProduto} ${lista[index].cor} "),
            subtitle: Text("De: ${lista[index].resCliente}, Preço: ${lista[index].valor}"),
            onTap: (){
              Map<String, dynamic> retornoPop = 
                {
                  "idProduto" : lista[index].id,
                  "resProduto" : lista[index].resProduto,
                  "valor" : lista[index].valor,
                  "dataCompra":lista[index].data.toDate().toString()
                }
              ;
              
              Navigator.pop( context , retornoPop );
            },
          );          
        },

      ),
    );
  }
 
}