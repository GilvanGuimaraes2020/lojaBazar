import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:loja_carrinhos/AtualizaCaixa.dart';

import 'package:loja_carrinhos/Models.dart';

class RealizarVenda extends StatefulWidget {
  @override
  _RealizarVendaState createState() => _RealizarVendaState();
}

class _RealizarVendaState extends State<RealizarVenda> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  StreamSubscription<QuerySnapshot> ouvidor;
  StreamSubscription<QuerySnapshot> ouvidorC;
  var dbEstoque =FirebaseFirestore.instance;
  var dbCliente =FirebaseFirestore.instance;
  var dbVenda = FirebaseFirestore.instance;
  List<Estoque> estoque = [];
  List<Clientes> cliente = [];
   int selec ;
   String idProduto;
   String idCliente;
   String valorCompra;
   List dadosCliente = [];
   ScrollController listControle;
   final itemSize = 400.0;
   var codProdCtrl = TextEditingController();
   var codClienCtrl = TextEditingController();
   var nomeClienCtrl = TextEditingController();
   var nomeProdCtrl = TextEditingController();
   var valorCtrl = TextEditingController();
   var dataCtrl = TextEditingController();
   var foneCtrl = TextEditingController();
   var qtdParcelasCtrl = TextEditingController();

   var qtdFormaPag = TextEditingController();
   var pag1Ctrl = TextEditingController();
   var pag2Ctrl = TextEditingController();
   String transf = "Selecione o Banco";
   List pagAlternativo = [];
   String tipoPagamento = "Dinheiro";
   String transBanco = "Nubank";
   String operacao = "Credito";
   double valorDesc ;
   DateTime data;
    CollectionReference diario = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas');
 List<ControleGastos> listaIdCaixa = [];


void _openDrawer() {
  _scaffoldKey.currentState.openDrawer();
}

void _closeDrawer() {
  Navigator.of(context).pop();
}

//**************************Inicializaçao da lista de estoque e lista de cliente*************************** */
@override
void initState(){
  listControle = ScrollController();
 super.initState();

 ouvidor?.cancel();
 ouvidorC?.cancel();

ouvidor = dbEstoque.collection('estoque').where('status', isEqualTo: "1")
.orderBy('resProduto').snapshots().listen((res) {
  setState(() {
    
    estoque = res.docs.map((e) => Estoque.fromMap(e.data(), e.id)).toList();
  });

});
 
 ouvidorC = dbCliente.collection('clientes').orderBy('nome').snapshots().listen((resC) {
  setState(() {
    
    cliente = resC.docs.map((e) => Clientes.fromMap(e.data(), e.id)).toList();
  });

});

diario.snapshots().listen((res) {
   
  

  listaIdCaixa =  res.docs.map((e) => ControleGastos.fromMap(e.data(), e.id)).toList();
 });

}

//******************************************Codigo para gerar lista de produtos************************/
 Widget geraLista(){
   
   print('Lista produtos');
   return StreamBuilder<QuerySnapshot>(
     stream: dbEstoque.collection('estoque').snapshots(),
     builder: (context , snapshots){
       switch(snapshots.connectionState){
         case (ConnectionState.none):
         return Center(child: Text("Erro ao conectar"),);
         case(ConnectionState.waiting) :
         return Center(child: CircularProgressIndicator());
         default : return ListView.builder(

           itemCount: estoque.length,
           itemBuilder: (context , index){
             return ListTile(
               title: Text("${estoque[index].resProduto}, ${estoque[index].resCliente}"
               , style: TextStyle(fontSize: 14),),
               subtitle: Text("R\$ ${estoque[index].valor}",style: TextStyle(fontSize: 12),),
              
               onTap: (){
                  setState(() {
                    
                     idProduto = estoque[index].id;
                     codProdCtrl.text = estoque[index].codProduto;
                     nomeProdCtrl.text = estoque[index].resProduto;
                     dataCtrl.text = estoque[index].data.toDate().toString();
                     valorCompra = estoque[index].valor;
                   });
                   Navigator.of(context).pop();
               },
               
             );
           },
         );
       }
     },
   );
} 

//*****************************Codigo para criar a lista de Clientes************************************* */

Widget geraListaCliente(){
  print('Lista Clientes');

   return StreamBuilder<QuerySnapshot>(
     stream: dbCliente.collection('clientes').snapshots(),
     builder: (context , snapshots){
       switch(snapshots.connectionState){
         case (ConnectionState.none):
         return Center(child: Text("Erro ao conectar"),);
         case(ConnectionState.waiting) :
         return Center(child: CircularProgressIndicator());
         default : return ListView.builder(
           itemExtent: 50,
           controller: listControle,
           itemCount: cliente.length,
           itemBuilder: (context , index){
             return ListTile(
               title: Text("${cliente[index].nome} , ${cliente[index].telefone} "
               , style: TextStyle(fontSize: 14),),
               subtitle: Text("${cliente[index].bairro}",style: TextStyle(fontSize: 12),),
               onTap: (){
                 setState(() {
                  
                     idCliente = cliente[index].id;
                     nomeClienCtrl.text = cliente[index].nome;
                    
                     foneCtrl.text = cliente[index].telefone;
                   });


                 Navigator.of(context).pop();
               },
               
             );
           },
         );
       }
     },
   );
} 

Widget geraDadosAlternativo(){
 return Column(
      children: [
      

          TextField(
            decoration: InputDecoration(
             labelText: 'Valor pago em dinheiro'
            ),
            controller: pag1Ctrl,
            keyboardType: TextInputType.number,            
          ),
        

             DropdownButton(
              
                 value: transf,
                 items:<String> ["Selecione o Banco","Bradesco" , "Santander", "Caixa", "Nubank", "Outro"]
                 .map<DropdownMenuItem<String>>((String value){
                   return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value, style: TextStyle(fontSize: 14),),
                   );
                 }).toList(),
                 isExpanded: true,
                 onChanged: (String newValue){
                   setState(() {
                     transf = newValue;
                     pag2Ctrl.text = (double.tryParse(valorCtrl.text) - double.tryParse(pag1Ctrl.text)).toString();
                  
                   });
                 },
               ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Valor pagamento 2'
          ),
          enabled: false,
          controller: pag2Ctrl,
        ),

        ElevatedButton(
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
            setState(() {
             pagAlternativo.add("Dinheiro");
             pagAlternativo.add(transBanco);//igualar os laços ate encontrar maneira mais adequada
             pagAlternativo.add(pag1Ctrl.text);
             pagAlternativo.add("Transferencia");
             pagAlternativo.add(transf);
             pagAlternativo.add(pag2Ctrl.text);
                  print(pagAlternativo.length);  

                  Navigator.of(context).pop();

            });
           


          }, child: Text("OK"))
        


      ],
    );
}

//*****************************Busca produto que esta no estoque pelo ID********** */

getEstoqueById(String id){
  dbEstoque.collection('estoque').doc(id).get().then((doc) {
    codProdCtrl.text = doc.data()['codProduto'];
    nomeProdCtrl.text = doc.data()['resProduto'];
    dataCtrl.text = doc.data()['data'];
    valorCompra = doc.data()['valor'];
  });

}

//*************Retorna dados relacionado ao produto vindo diretamente do estoque****** */


  @override
  Widget build(BuildContext context) {
   Map dadosRetorno = ModalRoute.of(context).settings.arguments;

   if(dadosRetorno!=null){
     if(dadosRetorno['adressRoute'] == '/agenda'){
       getEstoqueById(dadosRetorno['idProduto']);
     } else if(dadosRetorno['adressRoute'] == '/telaEstoque'){
        
        valorCompra = dadosRetorno['valorCompra'];
        idProduto = dadosRetorno['idProduto'];
        codProdCtrl.text = dadosRetorno['codProdEst'];
        nomeProdCtrl.text = dadosRetorno['nomeProduto'];
        dataCtrl.text = dadosRetorno['dataCompra'];

     }

   }
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Venda"),
        leading: IconButton(
          icon:Icon(Icons.keyboard_backspace) ,
          onPressed: (){
            Navigator.of(context).pop();
          },
        ) ,
      ),

      key: _scaffoldKey,

      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
             ElevatedButton(
                 
                 child: Text("Lista produtos "),
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
                   setState(() {
                     if(valorCompra==null){
                       selec = 1;
               print(selec);
                    _openDrawer();
                     } else{
                       return showDialog(
                         context: context,
                         builder: (context){
                           return AlertDialog(
                             title: Text("Buscar outro produto!!!"),
                             content: Text("Deseja buscar produto diferente?"),
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
                                   setState(() {
                                     selec = 1;
                                      print(selec);
                                      _openDrawer();
                                      Navigator.pop(context);
                                   });
                                    
                                 },
                               )
                             ],
                             );
                         }
                           );
                         }
                       
                     
                     
                   });
                   
                   
                 },
               ),
              ElevatedButton(
                 child: Text("Lista cliente"),
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
                   setState(() {
              selec = 2;
              print(selec);
               _openDrawer();
                   });
                   
                   
                 },
             ),
             TextField(
               decoration: InputDecoration(
                 labelText: 'Codigo Produto'
               ),
               controller: codProdCtrl,
              enabled: false,
             ),
              TextField(
               decoration: InputDecoration(
                 labelText: 'Nome Produto'
               ),
               controller: nomeProdCtrl,
              enabled: false,
             ),
             TextField(
               decoration: InputDecoration(
                 labelText: 'Data Compra'
               ),
               controller: dataCtrl,
              enabled: false,
             ),
             TextField(
               decoration: InputDecoration(
                 labelText: 'Nome Cliente'
               ),
               controller: nomeClienCtrl,
              enabled: false,
             ),
             TextField(
               decoration: InputDecoration(
                 labelText: 'Telefone'
               ),
               controller: foneCtrl,
              enabled: false,
             ),
             TextField(
               decoration: InputDecoration(
                 labelText: 'Valor Venda'
               ),
               controller: valorCtrl,
              enabled: true,
             ),
               Row(
                 
                 children: [
                   Text(data==null?"Escolher Data":
                    "Data: $data"
         ),
                   IconButton(
            icon: Icon(Icons.today),
            onPressed: ()async{
              
                 data = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2019),
                    lastDate: DateTime(2023),
                    cancelText: 'SEM FILTRO',
                    builder: (context , child){
                      return Theme(
                        child: child,
                        data: ThemeData.dark(),
                      );
                    }

              );
              setState(() {
                print(data);
              });
              
            },
          ),
         
          
                 ],
               ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   
                    DropdownButton(
            
               value: tipoPagamento,
               items:<String> ["Maquina Cartao" ,"Pagamento Alternativo" , "Dinheiro", "Transferencia",
               "Troca Negociaçao" ,"N/D"]
               .map<DropdownMenuItem<String>>((String value){
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value, style: TextStyle(fontSize: 14),),
                 );
               }).toList(),
               onChanged: (String newValue){
                 setState(() {
                   tipoPagamento = newValue;
                 });
               },
             ),
                 ],
               ),
               //Opçao quando pagamento for alternativo
                            Visibility(
                              visible: tipoPagamento =="Pagamento Alternativo",
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Quantas formas de pagamento'
                                ),
                                keyboardType: TextInputType.number,
                                controller: qtdFormaPag,
                                onChanged: (String qtdPag){
                                 

                                  if (qtdPag == '2'){
                                  setState(() {
                                     selec = 3;
                                   _openDrawer();
                                  });
                                   
                                  }
                                },
                              )),
                Visibility(
                  visible: tipoPagamento == "Maquina Cartao",
                                  child: DropdownButton<String>(
                              value: operacao,
                              items: <String>['Credito' , 'Debito' ]
                              .map<DropdownMenuItem <String>>((String value){
                                return DropdownMenuItem <String>(
                                  value: value,
                                  child: Text(
                                    value , style: TextStyle(fontSize: 16),
                                  ));
                              } ).toList(), 
                              onTap: (){
                               
                              },                            
                              onChanged: (String newValue){
                                setState(() {
                                  operacao = newValue;
                                  print(operacao);
                                });
                              }),
                ),
         
             
             Visibility(
               visible: tipoPagamento == "Maquina Cartao" && operacao!="Debito",
               child:  TextField(
               decoration: InputDecoration(
                 labelText: 'Quantidade Parcelas'
               ),
               controller: qtdParcelasCtrl,
              
             ),
             ),
             Visibility(
               visible: tipoPagamento == "Transferencia",
               child:   DropdownButton(
            
               value: transBanco,
               items:<String> ["Bradesco" , "Santander", "Caixa", "Nubank", "Outro"]
               .map<DropdownMenuItem<String>>((String value){
                 return DropdownMenuItem<String>(
                   value: value,
                   child: Text(value, style: TextStyle(fontSize: 14),),
                 );
               }).toList(),
               onChanged: (String newValue){
                 setState(() {
                   transBanco = newValue;
                 });
               },
             ),
             ),
              ElevatedButton(
               child: Text("Salvar"),
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
                 String detTransacao;
                 double taxa;

                  if(tipoPagamento == "Maquina Cartao"){
                    detTransacao = qtdParcelasCtrl.text;

                    if(operacao == "Debito"){
                    taxa = 0.019;
                   
                     qtdParcelasCtrl.text = "1";
                     valorDesc = double.parse(valorCtrl.text) * ( 1 - taxa)  ;

                  } else if (operacao == "Credito"){

                     if (int.parse(qtdParcelasCtrl.text) > 1 ){

                    taxa = 0.039;
                     valorDesc = double.parse(valorCtrl.text) * ( 1 - taxa)  ;
                   } else if(int.parse(qtdParcelasCtrl.text) == 1 ){

                     taxa = 0.031; 
                     valorDesc = double.parse(valorCtrl.text) * ( 1 - taxa)  ;
                   } 
                  }
                  } else if (tipoPagamento == "Dinheiro"){
                    detTransacao = "1";
                    valorDesc = double.tryParse(valorCtrl.text) ;
                  } else if(tipoPagamento == "Transferencia"){
                    detTransacao = transBanco;
                    valorDesc = double.tryParse(valorCtrl.text) ;
                  } else {
                    detTransacao = "N/D";
                    valorDesc = double.tryParse(valorCtrl.text) ;
                  }

                 if (idCliente != null && idProduto!=null && valorCtrl.text != null && data != null){                

                    dbVenda.collection('historicoVenda').add({
                     'idCliente' : idCliente,
                     'idProduto' : idProduto,
                     'nomeCliente' : nomeClienCtrl.text,
                     'nomeProduto' :nomeProdCtrl.text,
                     'telefone' : foneCtrl.text,
                     'valor' : valorDesc.toString(),
                     'transacao' : tipoPagamento,
                     'detTransacao' :detTransacao,
                     'valorCompra': valorCompra,
                     'dataCompra' : dataCtrl.text,
                     'data' : Timestamp.fromDate (data)

                   });
                     dbEstoque.collection('estoque').doc(idProduto).update({
                      'status' : "0"
                    }); 
                  
                 } else {
                   return showDialog(
                     context: context,
                     builder: (context) {
                       return AlertDialog(
                        title: Text("Dados incompletos"),
                        content: Text("Verificar valores"),
                        actions: [
                          ElevatedButton(
                            child: Text("OK"),
                            onPressed: (){
                              Navigator.pop(context);
                            },
                          )
                        ],
                       );
                     },
                   );
                 }
                 int contItemCaixa = 0;
 
for (final e in listaIdCaixa){
  if(e.id.contains("${data.year}-${data.month}")){
    Map mapDadosCaixa = e.dias[data.day.toString()];
    print(mapDadosCaixa);
    if(mapDadosCaixa!=null){
      mapDadosCaixa.forEach((key, value) {
         print(key);
if( key.toString().substring(0 , 5) == "venda"){
  contItemCaixa++;
  print( contItemCaixa);
}
        });
        break;
    }
}
}

                    if(pagAlternativo.length>0){
                      for (int i =0; i<2; i++){
                        if (i == 1) {
                          contItemCaixa = contItemCaixa + 1;
                          i = 3;
                        }
                      AtualizaCaixa.venda ( data,  pagAlternativo[i + 2] , "e" ,
                    "vendaItemPA", pagAlternativo[i + 1] ,pagAlternativo[i],nomeProdCtrl.text, contItemCaixa, qtdParcelasCtrl.text);  
                      }
                    }else{
                      AtualizaCaixa.venda ( data,  valorDesc.toString() , "e" ,
                    "vendaItem", transBanco,tipoPagamento,nomeProdCtrl.text, contItemCaixa, qtdParcelasCtrl.text);
                    }
                 
               
                Navigator.pop(context);
               },
             ),
            ],
          ),
        ),
      ),

      drawer: Drawer(
        child: Scaffold(
          appBar: AppBar(
            title: Text("Lista do estoque"),
            leading: IconButton(
              icon: Icon(Icons.keyboard_backspace),
              onPressed: (){
                Navigator.of(context).pop();
              },
            ),
            actions: [
              IconButton(
                 icon:Icon(Icons.close) ,
                 onPressed: (){
                   _closeDrawer();
                 },
               ) ,
            ],
          ),
          body: 
           selec == 1?
           geraLista() :
           selec == 2?
           geraListaCliente():
           geraDadosAlternativo(),

            floatingActionButton: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
               selec == 2 ? FloatingActionButton(
        child: Icon(Icons.search),
        onPressed: (){
          var pesquisaCtrl = TextEditingController();
          int posicaoPesquisa;
          showDialog(context: context, 
          builder: (context){
            return AlertDialog(
              backgroundColor: Colors.black,
              title: Text("Digite abaixo nome ou iniciais da pesquisa" , style: TextStyle(color: Colors.white),),
              content: TextField(
                decoration: InputDecoration(labelText: "Digite Aqui!!!",
                labelStyle: TextStyle(color: Colors.white), 
                
                fillColor: Colors.grey[400]
                ),
                style: TextStyle(color: Colors.white),
                controller: pesquisaCtrl,
              ),
              actions: [
                ElevatedButton(
                  onPressed: (){
                    print(cliente.length);
         posicaoPesquisa = cliente.indexWhere((element) => 
         
         element.nome.startsWith(pesquisaCtrl.text));
         print(cliente.indexWhere((element) => element.nome.contains(pesquisaCtrl.text)));
           listControle.animateTo( double.tryParse(posicaoPesquisa.toString())  * 50, 
          duration: Duration(seconds: 1),
          curve: Curves.fastLinearToSlowEaseIn
          ); 
          Navigator.of(context).pop();
                  }, 
                  child: Text("Ok")),
                  ElevatedButton(
                    onPressed: (){
                      Navigator.of(context).pop();
                    }, 
                    child: Text("Sair"))
              ],
            );
          });
         
          //listControle.createScrollPosition(physics, context, oldPosition)
          //print(listControle.position);
        },
      ) :
      Text(""),
       FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
          selec == 1 ?
          Navigator.pushNamed(context, '/realizarCompra') :
          selec == 2?
          Navigator.pushNamed(context, '/telaCadastroCliente') :
          Navigator.pop(context);

        },
      ),
              ],
            ),
        ),

      ),
     
    );
  }
}