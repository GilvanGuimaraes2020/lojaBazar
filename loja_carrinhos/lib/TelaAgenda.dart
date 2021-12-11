import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
//import 'package:loja_carrinhos/ListaProdutos.dart';
import 'package:loja_carrinhos/Models.dart';
//import 'package:loja_carrinhos/listaWidget.dart';

// ignore: must_be_immutable
class TelaAgenda extends StatefulWidget {
  @override
  _TelaAgendaState createState() => _TelaAgendaState();

 String codCliente;
}



class _TelaAgendaState extends State<TelaAgenda> {

  int numCodigo = 0;
   bool dtAtual = false;
   DateFormat formatter = DateFormat('yyyy-MM-dd');
   DateTime data ;
   var db = FirebaseFirestore.instance;
   var dbCliente = FirebaseFirestore.instance;
    List<Clientes> clienteL = [];

   List<Agenda> agenda = [];

   StreamSubscription<QuerySnapshot> ouvidor;
   StreamSubscription<QuerySnapshot> ouvidorC;


  @override
  void initState(){
    super.initState();

    ouvidor?.cancel();

    ouvidor = db.collection('agenda').orderBy('data').snapshots().listen((res) {
      setState(() {
        agenda = res.docs.map((e) => Agenda.fromMap(e.data(), e.id)).toList();
      });
    });

    ouvidorC?.cancel();

    ouvidorC = dbCliente.collection('clientes').orderBy('nome').snapshots().listen((event) {
      setState(() {
         clienteL =event.docs.map((e)=> Clientes.fromMap(e.data(), e.id)).toList();
      });
     for (int x = 0; x < clienteL.length; x++){
       if( int.parse(clienteL[x].codigo)  > numCodigo){
         numCodigo = int.parse(clienteL[x].codigo);
       }
     }
    });


  }

  finalizaCadastroCliente(Map cliente){
   
    String dados;
    
//Faz loop no for tentando encontrar cliente em toda a lista, nao encontrando adiciona-o
          for (int x = 0 ; x < clienteL.length ; x++){
    if ((clienteL[x].telefone == cliente['telefoneCliente']) ||(clienteL[x].endereco == cliente['enderecoCliente'])){
    dados = clienteL[x].codigo;
     return  dados;
     }
     }

     print('saiu do for');
dbCliente.collection('clientes').add({
         'codigo' : (numCodigo + 1).toString(),
         'nome' : cliente['nomeCliente'],
         'endereco' : cliente['enderecoCliente'],
         'bairro' : cliente['bairroCliente'],
         'telefone' : cliente['telefoneCliente']
       });

       return dados = (numCodigo + 1).toString();       

      
        
   }
 

  Widget listaWidget(
    String nomeCliente , String endereco, String bairro,
  String telefone, String tipoproduto, String detalhe, String valor, String id , String operacao){
String detTrim;

//*********IdEstoque traz na variavel detalhe o id do estoque para realizar venda */
String idEstoque; 
   if (detalhe.indexOf("-") > 0){
    detTrim =  detalhe.substring(0 , detalhe.indexOf("-"));
    idEstoque = detalhe.substring(detalhe.indexOf("-"));
   } else{
     detTrim = detalhe;
   }
   
    String produto = tipoproduto + " " + detTrim;
    
     return Container(
           padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
     child: Column(
       children: [
       
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
     Container(
       child: Column(
         children: [

           Text('$operacao ' , style: TextStyle(fontSize: 14 , fontWeight: FontWeight.bold),),
           Text('$produto',style:TextStyle(fontSize: 12),),
           Text('$nomeCliente, $telefone',style:TextStyle(fontSize: 12)),
           Text('$bairro, \$ $valor ' ,style:TextStyle(fontSize: 12)),

         ],
       ),
     ),
     Container(
        
         child: Row(
           children: [
              IconButton(
         icon: Icon(Icons.cached_rounded, 
         color: Colors.blue[200],
         size: 20,
         ),

         onPressed: (){
           Map dadosAlterar = Map();
           dadosAlterar['adressRoute'] = ModalRoute.of(context).settings.name;
           dadosAlterar['idAgenda'] = id;
            Navigator.pushNamed(context, '/agendamento', arguments: dadosAlterar);

         },
       ),
            IconButton(
         icon: Icon(Icons.delete, 
         color: Colors.blue[200],
         size: 20,
         ),

         onPressed: (){
           
           return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text("Remover Dado!!!"),
                content: Text("Tem certeza que deseja remover dado selecionado?"),

                actions: [
                  ElevatedButton(
                    child: Text("Sim"),
                     onPressed: (){
                      db.collection('agenda').doc(id).delete();
                      Navigator.of(context).pop();
                     },
                  ),
                  ElevatedButton(
                    child: Text("Não"),
                     onPressed: (){
                      Navigator.of(context).pop();
                     },
                  ),
                ],
              );
            },
           );
          
             
           
           
         },
       ),
       IconButton(
         icon: Icon(Icons.monetization_on, 
         color: Colors.blue[200],
         size: 20,
         ),

         onPressed: (){
           Map cliente = Map();
           cliente [ 'adressRoute'] = ModalRoute.of(context).settings.name;
           cliente ['nomeCliente'] = nomeCliente;
           cliente ['telefoneCliente'] = telefone;
           cliente['enderecoCliente'] = endereco;
           cliente['bairroCliente'] = bairro;

           //confirmar se cliente ja esta cadastrado
          cliente['codigoCliente'] = finalizaCadastroCliente(cliente);

          cliente['tipoProduto'] = tipoproduto;
          cliente['idAgenda'] = id;
          
           
          
           if(operacao == 'compra'){

            
             
             Navigator.pushNamed(context, '/listaProdutos', arguments: cliente);
           

             
           }else if (operacao == 'venda') {
             Map clienteVenda = Map();
             clienteVenda['adressRoute'] = ModalRoute.of(context).settings.name;
             clienteVenda['idEstoque'] = idEstoque;
             clienteVenda['idAgenda'] = id;
             return showDialog(
               context: context,
               builder: (context) {
                 return AlertDialog(
                   title: Text("Redirecionamento para Venda"),
                   content: Text("Executar venda do produto? "),
                   actions: [
                     ElevatedButton(
                       child: Text("Sim"),
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
                          db.collection('agenda').doc(id).delete();

                         Navigator.pushNamed(context, '/realizarVenda', arguments: clienteVenda);
                       },
                     ),
                      ElevatedButton(
                       child: Text("Nao"),
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
               },
             );
              
           }
         },
       ),  
           ],
         ),
       ),
           
           
          ],
        ),
         Divider(
           color: Colors.brown,
           thickness: 2,
         )
       
       ],
     )
          
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agenda'),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),

      body: Container(
        child: Container(
          child: Column(
            children: [
            
           Expanded(
                        child: ListView.builder(
               itemCount: agenda.length,
               itemBuilder: (context , index){
                                
                 return listaWidget(
                  agenda[index].nome, agenda[index].endereco, agenda[index].bairro, agenda[index].telefone,
                  agenda[index].tipoProduto , agenda[index].detalheProduto , agenda[index].preValor , 
                  agenda[index].id, agenda[index].operacao
                
                 );
               },
             ),
           ),


            
            ],
          ),
        ),
      ),
    );
  }
}