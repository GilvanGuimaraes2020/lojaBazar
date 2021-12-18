//import 'dart:async';



import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models.dart';

class Relatorios extends StatefulWidget {
  @override
  _RelatoriosState createState() => _RelatoriosState();
}

class _RelatoriosState extends State<Relatorios> {

  var db = FirebaseFirestore.instance; 
  var dbCliente = FirebaseFirestore.instance;
  var dbEstoque = FirebaseFirestore.instance;
   DateTime dataStart;
   DateTime dataEnd;
   DateFormat formatter = DateFormat("yyyy-MM-dd");
   var dataStartCtrl = TextEditingController();
  var dataEndCtrl = TextEditingController();
  double totalCompra = 0;
  double totalVenda = 0;
  List<Historico> historico = [];
  List<int> total = [];
  var scaffoldKey = GlobalKey<ScaffoldState>();

   filtrarCompra()async{

  await db.collection('historicoVenda').where('data' , isGreaterThanOrEqualTo: Timestamp.fromDate(dataStart) )
  .where('data' , isLessThanOrEqualTo: Timestamp.fromDate(dataEnd)).orderBy('data' , descending: true).get().then((doc) => {
     historico = doc.docs.map((e) => Historico.fromMap(e.data(), e.id)).toList()
    });

   setState(() {
      // ignore: unnecessary_statements
      historico;
   });

print(historico.length);
    
  } 

  openDrawer(){
    scaffoldKey.currentState.openDrawer();
  }
resultadoNegocios(){
  
  if(historico!=null){
    for (int i =0; i< historico.length; i++){
       setState(() {
    totalCompra = totalCompra + double.parse(historico[i].valorCompra) ;
    totalVenda = totalVenda + double.parse(historico[i].valor) ;
  });
    }
  }
 
}

Widget detalhes(){
  List<String> produtos = ['Carrinho' , 'Banheira', 'Andador', 'Berço','Chiqueirinho'
                        ,'Conjunto','Bebe Conf c base','Bebe Conf s base' ,'Cadeira p auto', 'Cadeirinha',
                        'Cadeirão','tapete educ', 'Lote Roupas'];

 // List<String> lista = List();

  Map<String , int> dados = Map();
  
  if (historico.length > 0){

    produtos.forEach((e) {
     historico.forEach((element)  {
      if(element.nomeProduto.contains(e)){
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
//print(listaKeys);

    return Container(
      height: 300,
     
      decoration: ShapeDecoration(
        shape: Border.all(),
        color: Colors.blue[100]
      ),
      width: double.maxFinite,
      child: ListView.builder(
          itemCount: listaKeys.length,
          itemBuilder: (context , index){
            return ListTile(
      title: Text('${listaKeys[index]}: ${dados[listaKeys[index]]} itens vendidos')
            );
          },
            

          ),
    );
  } else{
    return Center(
      child: Text( "Escolha periodo para gerar detalhe"),
    );
  }
}


  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Relatorios"),
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            Navigator.pop(context);
          }
          ,
        ),
        
      ),
      key: scaffoldKey,
      body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            children: [
      
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
  //*******************Data inicial***************** */
                Container(
                  height: 130,
                  width: 100,
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Column(
                    children: [
                      Text("Data Inicio"),
                      IconButton(
       icon: Icon(Icons.calendar_today,
       size: 30,),
        onPressed: () async {
                      dataStart = await showDatePicker(
                       context: context,
                       initialDate: DateTime.now(),
                       firstDate: DateTime(2018),
                       lastDate: DateTime(2025),
                       
                       builder: (context , child) {
                         return Theme(
                           data: ThemeData.dark(),
                           child: child,
                         );
                       }
           );
                      setState(() {
                      
                      dataStartCtrl.text =formatter.format(dataStart) ;
                      
                      });
         
         },
             ),

             TextField(
       enabled: false,
       controller: dataStartCtrl,
             )
             
                    ],
                  ),
                ),
 //************Data final para pesquisa************ */         
      Container(
        height: 130,
        width: 100,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          children: [
            Text("Data Final"),
            IconButton(
             icon: Icon(Icons.calendar_today,
             semanticLabel: 'Data Fim',
             size: 30,),
              onPressed: () async {
                      dataEnd = await showDatePicker(
                       context: context,
                       initialDate: DateTime.now(),
                       firstDate: DateTime(2018),
                       lastDate: DateTime(2030),
                       
                       builder: (context , child) {
                         return Theme(
                           data: ThemeData.dark(),
                           child: child,
                         );
                       }
                 );
                      setState(() {
                      
                       print(dataEnd);
                      dataEndCtrl.text = formatter.format(dataEnd);


                      });
               
               
               },
             ),
             
             TextField(
       enabled: false,
       controller: dataEndCtrl,
             )
          
          ],
        ),
      ),
              ],
            
            ),

            
             
      ElevatedButton(
        child: Text("Buscar"),
        style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
            
        onPressed: ()async {
          totalCompra =0;
          totalVenda = 0;
          if(dataEnd!=null && dataStart!= null){
             await filtrarCompra();
       print(historico.length);
       resultadoNegocios();
          } else{
            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("Falta informaçao!!!"),
                  content: Text("Inserir os intervalos das datas"),
                  actions: [
                    ElevatedButton(
                      child: Text("Ok"),
                      onPressed: (){

                        Navigator.pop(context);
                      },
                    )
                  ],
                );

              },
            );
          }
        
       
        }
          ),

          Visibility(
            visible: historico.length>0,

            child: Container(
              color: Colors.blue[150],
              child: Expanded(
                child: ListView.builder(
                  itemCount: historico.length,
                  itemBuilder: (context , index){
                    /* //somarPreco(int.parse(historico[index].dataCompra));   
                    total.add(int.parse(historico[index].dataCompra));       */               
                    return ListTile(
                      title: Text("${historico[index].nomeProduto}, ${historico[index].nomeCliente}" ,
                       style: TextStyle(fontSize: 14),),
                      subtitle: Text("Valor Venda: R\$ ${historico[index].valor}" , style: TextStyle(fontSize: 14),),
                    trailing: IconButton(
                      icon: Icon(Icons.arrow_forward_ios_sharp),
                      onPressed: ()async{
                        String nome;
                        String fone;
                        String bairro;
                        String nomeC;
                        Timestamp dataV = historico[index].data;
                        String dataC = historico[index].dataCompra;

                       await dbCliente.collection('clientes').doc(historico[index].idCliente).get().then((doc){
                          nome = doc.data()['nome'];
                          fone = doc.data()['telefone'];
                          bairro = doc.data()['bairro'];                        

                        });

                        await dbEstoque.collection('estoque').doc(historico[index].idProduto).get().then((doc){
                          nomeC = doc.data()['resCliente'];

                        });
                        //formatter.format(dataV.toDate())
                        return showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Detalhe do Cliente"),
                              content: Column(
                                children: [
                                  Text("$nome , $bairro"),
                                  Text("$fone"),
                                  Text("Data Venda: ${formatter.format(dataV.toDate())} "),
                                  Text("Dados Compra: $nomeC,  $dataC")
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  child: Text("OK"),
                                  onPressed: (){
                                    Navigator.pop(context);
                                  },
                                )
                              ],
                            );
                          });
                      },
                    ),
                    );
                  },
                ),
              )),
            
          ),

            Visibility(
              visible:historico.length>0 ,
          
          
          child: Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              width: double.infinity,
              color: Colors.blue[100],
        child: Column(
            children: [
                Text("Quantidade de itens Vendido: ${historico.length}",
                style: TextStyle(color: Colors.green,
                fontStyle: FontStyle.italic),),
                Text("Total Compra: R\$ $totalCompra ", 
                style: TextStyle(color: Colors.green,
                fontStyle: FontStyle.italic),),
                Text("Total Venda: R\$ $totalVenda",
                style: TextStyle(color: Colors.green,
                fontStyle: FontStyle.italic),),
                Text("Total Lucro bruto: R\$ ${totalVenda - totalCompra}",
                style: TextStyle(color: Colors.green,
                fontStyle: FontStyle.italic),),

            ],
        ),
      ),
            ),
             

            ],
          ),
        ),
        drawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Detalhes - Itens Vendidos"),

            ),
            body: Container(
              child: Column(
              children: [
                detalhes(),
              ],
            )),
          ),
        ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.plagiarism),
        elevation: 5,         
         backgroundColor: Colors.blue,
         foregroundColor: Colors.white,
        onPressed: (){
          openDrawer();
        },

      ),
    );
  }
}