//import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/MostraDetalheContas.dart';
import 'package:loja_carrinhos/TratarDadosBanco.dart';

import 'AtualizaCaixa.dart';
import 'Models.dart';


class Caixa extends StatefulWidget {
  @override
  _CaixaState createState() => _CaixaState();
}

class _CaixaState extends State<Caixa> {
  String tipoConta = "combustivel";
  String contaTransferencia = "Selecione";
  String destino = "Destino";
  String somaValor = "Selecione";
  var detalheCtrl = TextEditingController();
  var valorCtrl = TextEditingController();
  var retornoCis = TextEditingController();
  var retornoGil = TextEditingController();
  var retornoCaixa = TextEditingController();
  var retornoSum = TextEditingController();
  var retornoSantander = TextEditingController();
  var retornoNubank = TextEditingController();
  bool entradaCaixa = false;
  bool saidaCaixa = false;
  bool mostraDetalhe = true;
  var db = FirebaseFirestore.instance;
  String tipoPag = "Selecione";
  //List<String> lista = [];
 List<ControleGastos> dados = [];
 

 List<TratarDados> filtroGastos = [];
 double somaEntrada = 0;
 double somaSaida = 0;
 
 DateTime data;

 var globalKey = GlobalKey<ScaffoldState>();
  
  String teste;

 CollectionReference diario = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas');

  DocumentReference caixa = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('ControleContas');


  @override
  void initState(){
    super.initState();
   
   

    diario.snapshots().listen((res) {
   
   dados = res.docs.map((e) =>ControleGastos.fromMap(e.data(), e.id) ).toList();
 });
  }

  limpar(){
      tipoConta = "combustivel";
   contaTransferencia = "Selecione";
   detalheCtrl.text = "";
   valorCtrl.text = "";
   entradaCaixa = false;
   saidaCaixa = false;
  }

  void openDrawer(){
globalKey.currentState.openDrawer();
  }
Widget listaDiaria(List<TratarDados> dado){

return SingleChildScrollView(
  child:   Container(
  
          color: Colors.blue[100],
  
        width: 300,
  
        height: 300,
  
          child: ListView.builder(
  
            shrinkWrap: true,
  
          itemCount: dado.length,
  
          itemBuilder: (context , index){
  
            return ListTile(
  
              title: dado[index].detalhe.substring(dado[index].detalhe.indexOf("-")+1)=="e"?
  
               Text("Entrada: ${dado[index].tipoTransacao}"):
  
              Text("Saida: ${dado[index].tipoTransacao}"),
  
               
  
               //teste[index].detalhe.substring(teste[index].detalhe.indexOf("-"))=="e"?
  
               ///Text("Entrada:"):
  
               subtitle:Text("${dado[index].valor} , ${dado[index].detalhe}"),
  
            );
  
          },
  
        ),
  
      ),
);

}
   

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar Gastos'),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.keyboard_backspace),
        ),

      ),
      key: globalKey,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            children: [

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                   
                    width: 150,
                    child: CheckboxListTile(
                     title:Text("Entrada Caixa", style: TextStyle(fontSize: 12),),
                      value: entradaCaixa,
                      onChanged: (bool value){
                        setState(() {
                          entradaCaixa = value;
                           print(value);
                        });
                       
                      },
                    ),
                  ),
                   Container(
                     
                    width: 150,
                     child: CheckboxListTile(
                       title:Text("Saida Caixa", style: TextStyle(fontSize: 12),),
                     
                      value: saidaCaixa,
                      onChanged: (bool value){
                        
                        setState(() {
                          saidaCaixa = value;
                           print(value);
                        });
                       
                      },
                  ),
                   ),
                ],
              ),
              
              DropdownButton(
                value: tipoConta,
                isExpanded: true,
                items:<String> ["combustivel" , "padaria", "mercado","saude" , "recarga","servicos", "estudo", "lazer", 
                "reserva", "doacao","pet", "emergencia","emprestimo", "contas", "beleza", "utilidades", "veiculos"
                ].map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(
                    
                    value:value ,
                    child: Text(value),
                   );
                   
                }).toList(),
                onChanged: (String newValue){
                  setState(() {
                    tipoConta = newValue;
                    if(tipoConta=="emergencia" || tipoConta=="reserva"){
                      mostraDetalhe = false;
                    } else{
                      mostraDetalhe = true;
                    }
                  });
                },
              ),
              Visibility(
                visible: mostraDetalhe ,
                              child: TextField(
                  decoration: InputDecoration(
                    labelText:
                    'detalhe',
                  ),
                  controller: detalheCtrl ,

                ),
              ),
              Visibility(
                visible: tipoConta=="emergencia",
                child: Container(
                  child: Column(
                    children: [
                       DropdownButton<String>(
                  value: destino,
                  isExpanded: true,
                  items: <String> ["Destino","Carteira Gil", "Carteira Cis"].map<DropdownMenuItem<String>>((value)
                   { return DropdownMenuItem
                   (child: Text(value , style: TextStyle(fontSize: 12),) ,
                   value: value, );
                  } ).toList(),
                  onChanged: (String newValue){
                    setState(() {
                      destino = newValue;
                      detalheCtrl.text = destino;
                    });
                  },
                ),
                Text("O valor sera acrescentado ao que ja tem na Carteira?"),

                 DropdownButton(
                value: somaValor,
                isExpanded: true,
                items:<String> ["Selecione" , "Sim", "Nao"
                ].map<DropdownMenuItem<String>>((value){
                  return DropdownMenuItem(
                    
                    value:value ,
                    child: Text(value),
                   );
                   
                }).toList(),
                onChanged: (String newValue){
                  setState(() {
                    somaValor = newValue;
                  });
                },
              ),
                    ],
                  ),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                  labelText:'Entre com Valor',
                ),
                keyboardType: TextInputType.number,
               
                controller: valorCtrl ,

              ),
              Visibility(
                visible: tipoConta!="emergencia" ,
                              child: DropdownButton<String>(
                  value: tipoPag,
                  isExpanded: true,
                  items: <String> ["Selecione","cartaoProprio", "Dinheiro", 
                  "Transferencia","Carteira Gil", "Carteira Cis", "Vale Alimentacao"].map<DropdownMenuItem<String>>((value)
                   { return DropdownMenuItem
                   (child: Text(value , style: TextStyle(fontSize: 12),) ,
                   value: value, );
                  } ).toList(),
                  onChanged: (String newValue){
                    setState(() {
                      tipoPag = newValue;
                    });
                  },
                ),
              ),
              Visibility(
                visible: tipoPag=="Transferencia" ,
                child:DropdownButton<String>(
                value: contaTransferencia,
                isExpanded: true,
                items: <String> ["Selecione","Nubank", "Bradesco",
                "Caixa", "Santander"].map<DropdownMenuItem<String>>((value)
                 { return DropdownMenuItem
                 (child: Text(value , style: TextStyle(fontSize: 12),) ,
                 value: value, );
                } ).toList(),
                onChanged: (String newValue){
                  setState(() {
                    contaTransferencia = newValue;
                  });
                },
              ),
              ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                 children: [
                   data==null?
                   Text("Escolha uma Data"):
                   Text("Data: $data"),
                   IconButton(
                    icon: Icon(Icons.today),
                    iconSize: 40,            
                    onPressed: ()async{
              
                     data = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2019),
                        lastDate: DateTime(2023),
                        
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


                 ],
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
                child: Text("Salvar"),
                onPressed: ()async{ 
if(tipoPag == "Selecione"){
return showDialog(
  context: context,
   builder: (context){
     return AlertDialog(
       content: Text("Inserir dados faltante!!!"),
       title: Text("Dados incompletos"),
       actions: [
         ElevatedButton(
           onPressed: (){
             Navigator.of(context).pop();
           }, 
           child: Text("Ok"))
       ],
     );
   });
}
                  if(tipoConta=="emergencia" ){
                    
                    tipoPag = "Dinheiro";
                    
                  }
                  if(tipoConta == "reserva"){
                    tipoPag = "Dinheiro";
                    detalheCtrl.text = "Reservado";
                  }
                 
int contItem = 0;
 /****Faz Verificaçao se ja conem  o mes para lançamentos */
for (final e in dados){
  if(e.id.contains("${data.year}-${data.month}")){
    Map mapDadosCaixa = e.dias[data.day.toString()];
    print(mapDadosCaixa);
    if(mapDadosCaixa!=null){
      mapDadosCaixa.forEach((key, value) {
         print(key);
if( key.toString().substring(0 , 5) == tipoConta.substring(0,5)){
  contItem++;
  print( contItem);
}
        });
        break;
    }
}
}
 String op;
                 if(entradaCaixa)  op = "e";
                 else if(saidaCaixa) op = "s";

 AtualizaCaixa.caixa ( data,  valorCtrl.text, op ,tipoConta,
  contaTransferencia,tipoPag, detalheCtrl.text, contItem, somaValor);

         limpar();    

         Navigator.pop(context);   

       }
  
              )
            ],

          ),
        ),
      ),


/***Inicia modos de visualizaçao do caixa */
      drawer: Drawer(

        child: Scaffold(
          appBar: AppBar(
            title: Text("Relaçao do caixa"),

          ),
          body: Container(
            padding: EdgeInsets.all(5),
            decoration: ShapeDecoration(
              shape: Border.all(),
        color: Colors.blue[100]
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
Container(
  child: TextField(
    controller: retornoCis,
    decoration: InputDecoration(
      labelText: 'Carteira Cis',
      counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    ),

  ),
),
Container(
  child:  TextField(
    controller: retornoGil,
    decoration: InputDecoration(
      labelText: 'Carteira Gil',
      counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    ),

  ),
),
Container(
  child: TextField(
    controller: retornoCaixa,
    decoration: InputDecoration(
      labelText: 'Caixa',
      counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    ),

  ),
),
Container(
  child:   Column(
    children: [
      Center(
        child: Text("Bancos"),
      ),
      Divider (
          color: Colors.blue,
          thickness: 2,
      
      ),
    ],
  ),
),
Container(
  child: TextField(
    controller: retornoSum,
    decoration: InputDecoration(
      labelText: 'Sumup',
      counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    ),

  ),
),
Container(
  child: TextField(
    controller: retornoSantander,
    decoration: InputDecoration(
      labelText: 'Santander',
      counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    ),

  ),
),
Container(
  child: TextField(
    controller: retornoNubank,
    decoration: InputDecoration(
      labelText: 'Nubank',
      counterStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
    ),

  ),
),

Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
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
      child: Text("Dia"),
      onPressed: ()async{
          var saidactrl = TextEditingController();
          var entradactrl = TextEditingController();
          var difctrl = TextEditingController();
          double somaEntradaMes = 0;
          double somaSaidaMes = 0;
           
            somaEntrada =0;
            somaSaida =0;

         DateTime   data = await showDatePicker(
              firstDate: DateTime(2018),
              initialDate: DateTime.now(),
              lastDate: DateTime(2025),
              context: context,
              builder: (context , child){
                return Theme(
                  child: child,
                  data: ThemeData.dark(),
                );
              }

            );
            String mes = "${data.year}-${data.month}";
            String dia = "${data.day}";

            List<TratarDados> gastos = [];
            List<TratarDados> gastosMes = [];
            

            await diario.doc(mes).get().then((value) {

    value.data().keys.forEach((element) {
          Map extrairDadosMes = Map();
          extrairDadosMes = value.data()[element];
          extrairDadosMes.forEach((key, value) {
            gastosMes.add(TratarDados.banco(value , key, element));
          });
          

      if(element == dia){
        Map extrairDados = Map();
        extrairDados =  value.data()[dia];

        extrairDados.forEach((key, value) {
          gastos.add(TratarDados.banco(value , key, element)); 
        });

        
      }
      

     });
  });

   gastos.forEach((element) {
     if(element.detalhe.substring(element.detalhe.indexOf("-")+1)=="s"){
         somaSaida = somaSaida + double.tryParse(element.valor);
     } else if(element.detalhe.substring(element.detalhe.indexOf("-")+1)=="e"){
         somaEntrada = somaEntrada + double.tryParse(element.valor);
     }
     
  });

  gastosMes.forEach((element) {
     if(element.detalhe.substring(element.detalhe.indexOf("-")+1)=="s"){
         somaSaidaMes = somaSaidaMes + double.tryParse(element.valor);
     } else if(element.detalhe.substring(element.detalhe.indexOf("-")+1)=="e"){
         somaEntradaMes = somaEntradaMes + double.tryParse(element.valor);
     }
     
  });
           print(somaSaida.toString());
           print(somaEntrada.toString());
saidactrl.text = "R\$ ${somaSaida.toString()}";
entradactrl.text  = "R\$ ${somaEntrada.toString()}";
difctrl.text = "R\$ ${(somaEntrada - somaSaida).toString()}";

        return showDialog(
          context: context,
          builder: (context)  {

            
           
            return AlertDialog(
              title: Text("Relatorio ${DateFormat("d 'de' MMMM 'de' y").format(data)}"),
              content: SingleChildScrollView(
                              child: Column(
children: [
 


  listaDiaria(gastos),
 

  TextField(
    decoration: 
    InputDecoration(
       enabled: false,
       labelText: 'Entrada',
       counterStyle: TextStyle(fontSize: 14)

    ),
    
    controller: entradactrl ,

    ),
     TextField(
    decoration: 
    InputDecoration(
       enabled: false,
       labelText: 'Saida',
      counterStyle: TextStyle(fontSize: 14)
    ),
    controller: saidactrl ,

    ),
     TextField(
    decoration: 
    InputDecoration(
       enabled: false,
       labelText: 'Diferença',
       counterStyle: TextStyle(fontSize: 14)
    ),
    controller: difctrl ,

    )


],
                ),
              ),
              actions: [
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
                  child: Text("Ok"),
                  onPressed: (){
                    var entradaMes = TextEditingController();
                    var saidaMes = TextEditingController();
                    var difMes = TextEditingController();
                    
                    
                      entradaMes.text = "${somaEntradaMes.toStringAsFixed(2)}";
                      saidaMes.text = "${somaSaidaMes.toStringAsFixed(2)}";
                      difMes.text = "${(somaEntradaMes - somaSaidaMes).toStringAsFixed(2)}";
                   setState(() {
                      somaSaidaMes = 0;
                    somaEntradaMes =0;
                   });
                    somaSaida = 0;
                   somaEntrada = 0;
                  // Navigator.pop(context);
                   return showDialog(
                     context: context,
                     builder: (context) {
                       return AlertDialog(
                         title: Text("Relatorio Mensal"),
                         content: SingleChildScrollView(
                           child: Column(
                             children: [
                               TextField(
                                 decoration: InputDecoration(
                                   labelText: 'Entrada mês'
                                 ),
                                  controller: entradaMes,
                               ),
                               TextField(
                                 decoration: InputDecoration(
                                   labelText: 'Saida mês'
                                 ),
                                  controller: saidaMes,
                               ),
                               TextField(
                                 decoration: InputDecoration(
                                   labelText: 'Diferença mês'
                                 ),
                                  controller: difMes,
                               ),
                             ],
                           ),
                         ),
                         actions: [
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
                             child: Text("Ok"),
                             onPressed: (){
                               Navigator.popUntil(context, ModalRoute.withName('/caixa'));
                             },
                           )
                         ],
                         
                        );

                     },
                   );
                  },
                )
              ],
            );
          },
        );
      },
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
      child: Text("Valores"),
    
      onPressed: ()async{
    
       
    
        var cis;
    
        var gil;
    
        var caixaValor;

        var contaSum;

        var contaNu;
        
        var contaSant;
    
    
    
        await caixa.get().then((value) {
    
           cis = value.data()['Carteira Cis'];
    
           gil = value.data()['Carteira Gil'] ;
    
           caixaValor = value.data()['caixaDinheiro'];

           contaSum = value.data()['contaSum']; 

           contaNu = value.data()['Nubank'];

           contaSant = value.data()['Santander'];
    
         }
    
              );
    
      
    
      setState(() { 
        
    
        retornoCis.text = cis.toStringAsFixed(2);
    
        retornoGil.text = gil.toStringAsFixed(2);
    
        retornoCaixa.text = caixaValor.toStringAsFixed(2);

        retornoSum.text = contaSum['total-2021'].toStringAsFixed(2);

        retornoSantander.text = contaSant['total-2021'].toStringAsFixed(2);

        retornoNubank.text = contaNu['total-2021'].toStringAsFixed(2);

      });
    
      },
    
    ),
    ElevatedButton(
      child: Text("Categoria"),
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
        Navigator.push(context , MaterialPageRoute(builder: (context) => MostraDetalheMes(),));
      },
      )
  ],
)
              ],
            ),
          ),
        ),
      ),

      
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        onPressed:(){
          openDrawer();
        } ,),
    );
  }
}