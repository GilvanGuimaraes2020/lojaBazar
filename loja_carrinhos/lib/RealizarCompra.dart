import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/AtualizaCaixa.dart';
import 'package:loja_carrinhos/Models.dart';

class RealizarCompra extends StatefulWidget {
  @override
  _RealizarCompraState createState() => _RealizarCompraState();
}

class _RealizarCompraState extends State<RealizarCompra> {

  var nomeControl = TextEditingController();
  var produtoControl = TextEditingController();
  var enderecoControl = TextEditingController();
  var valorControl = TextEditingController();
  var codClienteControl = TextEditingController();
   var codProdControl = TextEditingController();
   var corControl = TextEditingController();
   var qtdFormaPag = TextEditingController();
   var pag1Ctrl = TextEditingController();
   var pag2Ctrl = TextEditingController();

   var _scaffoldKey = GlobalKey<ScaffoldState>();
   DateFormat formatter = DateFormat("yyyy-MM-dd");
   DateTime data;
   int numCodigo = 0;
   String tipoPagamento = "Selecione forma de Pagamento";
   String transBanco = "Nubank";
   
   
  String sexo = "Unissex";
   
   var db = FirebaseFirestore.instance;

   List<Clientes> cliente = [];
    List pagAlternativo = [];

 String pag1 = "Pagamento 1";
 String pag2 = "Pagamento 2";
 String transf = "Selecione o Banco";
 

   var dbCliente = FirebaseFirestore.instance;
   StreamSubscription<QuerySnapshot> ouvidor;

   var dbAgenda = FirebaseFirestore.instance;

   CollectionReference diario = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas');
 List<ControleGastos> listaIdCaixa = [];
 /* List<String> listaId = List();
 List<Map> listaMap = List(); */
 

  
  @override
  void initState(){
    super.initState();
ouvidor?.cancel();
ouvidor = dbCliente.collection('clientes').orderBy('nome').snapshots().listen((res) {
  setState(() {
    
    cliente = res.docs.map((e) => Clientes.fromMap(e.data(), e.id)).toList();
for (int x = 0; x < cliente.length; x++){
       if( int.parse(cliente[x].codigo)  > numCodigo){
         numCodigo = int.parse(cliente[x].codigo);
         
       }
     }
 diario.snapshots().listen((res) {
   
  /*  res.docs.forEach((element) {listaId.add(element.id);
   listaMap.add(element.data());
   }); */

  listaIdCaixa =  res.docs.map((e) => ControleGastos.fromMap(e.data(), e.id)).toList();
 });
   
  });
  });

  

  }


   limpar(){
     
     print("Entrou em limpar");
     nomeControl.text = "";
     produtoControl.text = "";
     enderecoControl.text = "";
     valorControl.text = "";
     codClienteControl.text = "";
     codProdControl.text = ""; 
     
     
   }


 /* verificaDocumentCaixa (DateTime data){
   int compl = 0;
  for (final e in dados){
    if(data.month == int.tryParse(e.id.substring(e.id.indexOf("-")))){
      
      if (e.dias.keys.contains(data.day.toString())){
        Map dadosMap = e.dias[data.day.toString()];
        if(dadosMap.containsKey("compraItem")){
          dadosMap.keys.forEach((element) {
                             if (element.toString().substring(0 , 10) == "compraItem"){
                               print(element);

                               if(int.tryParse(element.substring(element.length-1)) == null){

                              compl = 1;

                            } else{
                              print('element nao nulo');

                              if(compl<=int.tryParse(element.substring(element.length-1))){
                                compl = int.tryParse(element.substring(element.length-1)) + 1;
                               
                              }

                              }

                             }

                            });
        }
      }
      
    }
  }
  
} */


//*******************Funçao para formar a lista dos produtos cadastrados********** */
 Future<List<Produtos>> gerarLista(FirebaseFirestore dbProduto) async{

  
  List<Produtos> produtos = [];
   await dbProduto.collection('produtos').orderBy('tipoProduto').get().then((doc) {
   
       produtos = doc.docs.map((e) => Produtos.fromMap(e.data(), e.id)).toList();
    
  });

  return Future.value(produtos) ;
}


//**************Widget para apresentar showdialog do produtos***************** */
Widget listaProdutoCadastrado(){
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
           codProdControl.text = produtos[index].codigo;
           produtoControl.text = produtos[index].tipoProduto + " " + produtos[index].marca;
           
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
     
// Traz lista dos clientes com cadastro no banco 
  listaClienteCadastrado(List<Map> nomes){
    return Container(
      height: 300,
      width: 300,
      child: ListView.builder(
        itemCount: nomes.length,
       
        itemBuilder: (context, index){
         
            return ListTile(
            title: Text("Nome: ${nomes[index]['nome']}, ${nomes[index]['endereco']} "),
            subtitle: Text("Telefone: ${nomes[index]['telefone']}"),
            onTap: (){
              codClienteControl.text = nomes[index]['codigo'];
              enderecoControl.text = nomes[index]['endereco'];
              Navigator.of(context).pop();
            },
          );          
        },

      ),
    );

  }
  
//Salva no banco clientes que ainda nao possuem cadastro
  salvarCadastroCliente(List<String> salvaCliente){
    dbCliente.collection('clientes').add({
      'codigo' : (numCodigo +1 ).toString(),
      'nome' : salvaCliente[0],
      'telefone' : salvaCliente[1],
      'endereco' : salvaCliente[2],
      'bairro' : salvaCliente[3]
    });

  }

void openDrawer(){
  _scaffoldKey.currentState.openDrawer();
}


  @override
  Widget build(BuildContext context) {

  //Traz os dados vindos da tela agenda para preencher tela de compra  
    Map dados = ModalRoute.of(context).settings.arguments;
    if (dados != null){

      if(dados['adressRoute'] == '/agenda'){
      codClienteControl.text = dados['codigoCliente'];
      nomeControl.text = dados['nomeCliente'];
      enderecoControl.text = dados['enderecoCliente'];
      codProdControl.text = dados['codigoProduto'];
      produtoControl.text = dados['produto']  + " " + dados['marca'] ;
    
      } else if(dados['adressRoute'] == '/realizarCompra'){
         
      codProdControl.text = dados['codigoProduto'];
      produtoControl.text = dados['produto']  + " " + dados['marca'] ;
    
      } 
   
    }
//Apos comparar na lista, gera pop-up para inserir dados para cadastro
     cadastroNaoRealizado(String nome){
       return showDialog(
                                 context: context,
                                 builder: (contexto) {
                                   var telefone = TextEditingController();
                                   var endereco = TextEditingController();
                                   var bairro = TextEditingController();
                                   List<String> salvaCliente = [];
                                   return AlertDialog(
                                     title: Text("Entrar com Dados Faltantes"),
                                     content: SingleChildScrollView(
                                        child: Column(
                                         children: [
                                           TextField(
                                             decoration: InputDecoration(
                                               labelText: 'telefone'

                                             ),
                                             controller: telefone,
                                           ),
                                           TextField(
                                             decoration: InputDecoration(
                                               labelText: 'endereco'
                                             ),
                                             controller: endereco,
                                           ),
                                           TextField(
                                             decoration: InputDecoration(
                                               labelText: 'bairro'
                                             ),
                                             controller: bairro,
                                           ),
                                         ],
                                       ),
                                     ),
                                     actions: [
                                       ElevatedButton(

                                         child: Text("Gravar"),
                                         onPressed: (){
                                           salvaCliente = [nome, telefone.text, endereco.text, bairro.text];
                                           salvarCadastroCliente(salvaCliente);
                                           codClienteControl.text = (numCodigo +1 ).toString();
                                           nomeControl.text = nome;
                                           enderecoControl.text = endereco.text;
                                          // Navigator.of(contexto).pop();
                                          Navigator.popUntil(context, ModalRoute.withName('/realizarCompra'));
                                           
                                         },
                                       )
                                     ],
                                   );
                                 },
                               );
    }
    

//******************Inicio do retorno de builder******************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Compra"),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)
        ),
         
      ),

      key: _scaffoldKey,
      
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

 //Campo desativado onde apresenta codigo automatico do cliente             
              TextField(
               decoration: InputDecoration(
                 labelText: 'Codigo Cliente - Prenchimento Automatico'
               ),
               controller: codClienteControl,
               enabled: false,
                ),

 //Campo para inserir nome do cliente           
             TextField(
               decoration: InputDecoration(
                 labelText: 'Nome Cliente'
               ),
               controller: nomeControl,
              
               
                ),
 //Campo para inserir endereço. Chama funçao para verificar se ja ha existencia de cadastro           
             TextField(
               decoration: InputDecoration(
                 labelText: 'Endereço'
               ),  
               controller: enderecoControl,
                onTap: (){
                   print(numCodigo);

                 if(codClienteControl.text=="" && nomeControl.text != "" && codProdControl.text == ""){
                   List<Map> dadosCliente = [];

                   for(int i =0 ; i < cliente.length; i++){
                     print(cliente[i].nome);
                     if(cliente[i].nome.contains(nomeControl.text)){
                       dadosCliente.add({'nome' : cliente[i].nome, 'telefone' : cliente[i].telefone,
                       'id':cliente[i].id , 'codigo' : cliente[i].codigo, 'endereco': cliente[i].endereco});
                     }
                     
                   }

                   if(dadosCliente.length > 0){
                     return showDialog(
                     context: context,
                     builder: (context) {
                       return AlertDialog(
                         title: Text("Se cadastro existe, clique nele!!! "),

                         //Forma lista com cadastros ja realizados para verificar se ja esta salvo
                         content: listaClienteCadastrado(dadosCliente),
                         actions: [
                           ElevatedButton(
                             child: Text("Não"),
                             onPressed: (){

                               cadastroNaoRealizado(nomeControl.text);
                              // Navigator.pop(context);
                             },
                           )
                         ],
                       );
                     },
                   );
                   } else{
                      cadastroNaoRealizado(nomeControl.text);
                     // Navigator.pop(context);
                   }


                   
                 }
                },
             ),
 //Campo desativado onde apresenta codigo do produto comprado           
              TextField(
               decoration: InputDecoration(
                 labelText: 'Codigo Produto - Preenchimento automatico'
               ),
               controller: codProdControl,
               enabled: false,

             ),


//Campo para inserir nome produto. Chama pop-up para escolha de produto ou cadastro de novo produto
             TextField(
               decoration: InputDecoration(
                 labelText: 'Produto'
               ),
               controller: produtoControl,
onTap: (){
  if (codProdControl.text == ""){
    return showDialog(
                     context: context,
                     builder: (context) {
                       return AlertDialog(
                         title: Text("Escolher produto clicando "),

                         //Forma lista com cadastros ja realizados para verificar se ja esta salvo
                         content: listaProdutoCadastrado(),
                         actions: [
                           ElevatedButton(
                             child: Text("Cadastrar Produto"),
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
                               Navigator.popAndPushNamed(context, '/cadastroProduto');
                              
                             },
                           )
                         ],
                       );
                     },
                   );
   
  }
},
             ),
 //Campo para inserir cor ou detalhe do produto            
             TextField(
               decoration: InputDecoration(
                 labelText: 'Cor'
               ),
               controller: corControl,

             ),

//Apresenta opçoes para o sexo do produto             
              DropdownButton<String>(
                            value: sexo,
                            items: <String>['Masculino' , 'Feminino', 'Unissex']
                            .map<DropdownMenuItem <String>>((String value){
                              return DropdownMenuItem <String>(
                                value: value,
                                child: Text(
                                  value , style: TextStyle(fontSize: 16),
                                ));
                            } ).toList(), 
                            isExpanded: true,
                                         
                            onChanged: (String newValue){
                              setState(() {
                                sexo = newValue;
                                print(sexo);
                              });
                            }),

 //Campo para inserir valor do produto            
              TextField(
                keyboardType: TextInputType.number,
               decoration: InputDecoration(
                 labelText: 'Valor'
               ),
               controller: valorControl,

             ),
             
 //Link para calendario para escolher data
             TextButton(
           child: data==null?
             Text("Escolha uma Data", 
             style: TextStyle(fontSize: 18,
             fontWeight: FontWeight.bold,
             fontStyle: FontStyle.italic)
             ,):
             Text("Data: $data"),
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
                  // ignore: unnecessary_statements
                  data;
                });
      },
          ),

//Apresenta opçoes para o tipo de pagamento
             DropdownButton<String>(
                            value: tipoPagamento,
                            items: <String>["Selecione forma de Pagamento","Pagamento Alternativo" ,
                            "Cartao Proprio" , "Dinheiro","Transferencia"]
                            .map<DropdownMenuItem <String>>((String value){
                              return DropdownMenuItem <String>(
                                value: value,
                                child: Text(
                                  value , style: TextStyle(fontSize: 16),
                                ));
                            } ).toList(), 
                            isExpanded: true,
                                         
                            onChanged: (String newValue){
                              setState(() {
                                tipoPagamento = newValue;
                                
                              });
                            }),

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
                                   openDrawer();
                                  }
                                },
                              )),
             
//Apresenta seleçao de bancos, caso tipo de pagamento seja = transferencia            
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
             
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
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
                  onPressed: () {
                    
                   // DateFormat formatter = DateFormat('yyyy-MM-dd');

//condicional que verifica se todos os requisitos foram preenchidos
                    if(codClienteControl.text!="" && codProdControl.text != "" && 
                    data!=null && tipoPagamento!="Selecione forma de Pagamento"){

               
                        db.collection('estoque').add({
                      'codCliente' : codClienteControl.text,
                      'codProduto' : codProdControl.text,
                      'corProduto' : corControl.text,
                      'sexoProduto' : sexo,
                      'resCliente' : nomeControl.text,
                      'resProduto' : produtoControl.text,
                      'valor' : valorControl.text,
                      'status' : "1",
                      'data' : data
                    }); 

                      

                      //Deleta documento registrado na Agenda pois estara salvo em estoque
                       if (dados!=null) {
                        
                         dbAgenda.collection('agenda').doc(dados['idAgenda']).delete();
                      } 
                      
                     /*  // ignore: deprecated_member_use
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text("Dados Salvo com Sucesso!!!"),
                        )
                      );*/
int contItemCaixa = 0;

//listaIDCaixa é formado no initState com os dados das transaçoes no banco 
for (final e in listaIdCaixa){
  //Verifica se o ano-mes esta contido no banco
  if(e.id.contains("${data.year}-${data.month}")){
    Map mapDadosCaixa = e.dias[data.day.toString()]; //Coleta o map do dia especifico
    print(mapDadosCaixa);
  // verifica se este map esta vazio
    if(mapDadosCaixa!=null){
      mapDadosCaixa.forEach((key, value) {
         print(key);
 //verifica quantas vezes teve ocorrencia de compra naquele dia
if( key.toString().substring(0 , 5) == "compr"){
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
                      AtualizaCaixa.compra ( data,  pagAlternativo[i + 2], "s" ,
                    "compraItemPA", pagAlternativo[i + 1] ,pagAlternativo[i],produtoControl.text, contItemCaixa);  
                      }
                    }else{
                       AtualizaCaixa.compra ( data,  valorControl.text, "s" ,
                    "compraItem", transBanco ,tipoPagamento,produtoControl.text, contItemCaixa); 
                    }
                     
                      
                      Navigator.pop(context);
                      

                      
                      limpar();

                      
                    
                    } else{
                      return showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text("Falta Informaçoes"),
                            content: Text("Verificar se todas as informaçoes foram preenchidas"),
                            actions: [
                              ElevatedButton(
                                child: Text("ok"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        }
                        
                        
                                              );
                    }
                  },
                 ),

                  ElevatedButton(
                  child: Text("Limpar"),
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
                    limpar();
                  },
                 )
               ],
             )
            ],
          ),

        ),
      ),

    backgroundColor: Colors.brown[100],
drawer: Drawer(
  child: Scaffold(
    appBar: AppBar(
      title: Text("Pagamento Alternativo"),
    ),
    body: Column(
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
                     pag2Ctrl.text = (double.tryParse(valorControl.text) - double.tryParse(pag1Ctrl.text)).toString();
                  
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
                  Navigator.pop(context);

            });
           


          }, child: Text("OK"))
        


      ],
    ),
  ),
),
    );
  }
}