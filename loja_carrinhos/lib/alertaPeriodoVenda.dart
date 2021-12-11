



import 'package:cloud_firestore/cloud_firestore.dart';
 
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/Models.dart';

import 'package:multi_select_flutter/multi_select_flutter.dart';


class VendaFutura extends StatefulWidget {

  
  @override
  _VendaFuturaState createState() => _VendaFuturaState();
}

class _VendaFuturaState extends State<VendaFutura> {
 Map<String , String> produtosConvert = Map();
  String sexo = "Sexo";
  var clientes = FirebaseFirestore.instance.collection("clientes");
  var produtoCliente = FirebaseFirestore.instance.collection("historicoVenda");
  var salvaAlerta = FirebaseFirestore.instance.collection("alertas");
  var nomectrl = TextEditingController();
  var codigoctrl = TextEditingController();
  var telefonectrl = TextEditingController();
  var datactrl = TextEditingController();
  var produtoctrl = TextEditingController();
  var nomeFilho = TextEditingController();
  List<Map<String , dynamic>> listaClientes = [];
  List<Map<String , dynamic>> produto = [];
  var globalState = GlobalKey<ScaffoldState>();
  List<AlertaLista> listaAlerta = [];
  DateFormat formatter = new DateFormat("yyyy/MM/dd");
  List<Produtos> produtos = [
    Produtos( 1 , "Andador") ,
    Produtos( 2 , "Banheira") ,
    Produtos( 3 , "Bebe Conforto") ,
    Produtos( 4 , "Berço") ,
    Produtos( 5 , "Bug") ,
    Produtos( 6 , "Cadeira Descanso") ,
    Produtos( 7 , "Cadeira Carro") ,
    Produtos( 8 , "Cadeirão") ,
    Produtos( 9 , "Carrinho Passeio") ,
    Produtos( 10 , "Carrinho") ,
    Produtos( 11 , "Chiqueirinho") ,
    Produtos( 12 , "Conjunto") ,
    Produtos( 13 , "Tapete educativo") ,

  ];
  
 List<Produtos> selectProdutos = [];

  DateTime dataPrevista ;
  Widget listagem(List<Map> dados){
    return Container(
      height: 300,
      width: 300,
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: listaClientes.length,
        itemBuilder: (builer , index){
          return ListTile(
            title: Text("${listaClientes[index]['nome']} - Fone:${listaClientes[index]['telefone']} "),
            subtitle: Text("${listaClientes[index]['endereco']}"),
            trailing: IconButton(
              onPressed: () async{
                Map <String , dynamic> dado = Map();
                
                codigoctrl.text = listaClientes[index]['codigo'];
                telefonectrl.text = listaClientes[index]['telefone'];
                nomectrl.text = listaClientes[index]['nome'];

               await  produtoCliente.where("idCliente" , isEqualTo: listaClientes[index]['id'])
               .get().then((value){

                  print(value.docs.last.data()['data'].toDate());
                    print(value.docs.last.data()['nomeProduto']);
                     dado['produto'] = value.docs.last.data()['nomeProduto'];
                    dado['data'] = value.docs.last.data()['data'].toDate();

                          
                });
                produtoctrl.text = dado['produto'].toString();
                datactrl.text = dado['data'].toString();
                Navigator.of(context).pop();
              }, 
              icon: Icon(Icons.file_download)),
          );
        }),
    );
  }

  void criaAlertaLista() async{
   
 await salvaAlerta.where('status' ,isEqualTo: true)
 .where('dataPrevista' , isLessThan: DateTime.now().add(Duration(days: 60)) )
 .get().then((value) {
    setState(() {
      listaAlerta = value.docs.map((e) => AlertaLista.fromMap(e.id, e.data())).toList();
    });
   
  });

   
}

void openDrawer (){
//print(listaClientes[1]['nome']);
criaAlertaLista();
  globalState.currentState.openDrawer();

}

// ignore: missing_return
/* Future<String> retornaMae(int codigo) async {
  print("Entrou funçao");
  String dado;
await  clientes.where('codigo', isEqualTo: codigo.toString())
                .get().then((value) => value.docs.forEach((element) {
                  
                 dado = element.data()['nome'];
                 })
                  );
                  return Future.value(dado);
} */

  @override  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Alertas Futuros"),
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          }, 
          icon: Icon(Icons.arrow_back)),
        actions: [
          IconButton(
            onPressed:(){
              openDrawer();
            }, 
            icon: Icon(Icons.list_alt))
        ],
        ),

        key: globalState,

      body: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                    labelText: "Digite o nome do Cliente e clique em pesquisa" ,
                    fillColor: Colors.white),
                    controller: nomectrl
                  ),
                ),
                IconButton(
                  onPressed: ()async{
                    listaClientes.clear();
                    print(nomectrl.text);
                    
                   await clientes.get().then((value) {
                    value.docs.forEach((element) {
                      if (element.data()['nome'].toString().contains(nomectrl.text) ){
                        Map <String , dynamic> dado = Map();
                      setState(() { 
                        dado['id'] = element.id;
                        dado['nome'] = element.data()['nome'];
                        dado['codigo'] = element.data()['codigo'];
                        dado['telefone'] = element.data()['telefone'];
                        dado['endereco'] = element.data()['endereco'];
                        listaClientes.add(dado);

                      });  
                      }                    
                     
                    });
                     
                   });
                  return showDialog(
                     context: context, 
                     builder: (context){
                       return AlertDialog(
                         title: Text("Escolha o Cliente"),
                         content: listagem(listaClientes),
                       );
                     }) ;
                    
                     
                  }, 
                  icon: Icon(Icons.search) )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      
                    labelText: "codigo" ,
                    ),
                    controller: codigoctrl,
                    enabled: false,
                    
                     
                  )
                ),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      
                    labelText: "Telefone" ,
                    ),
                    enabled: false,
                    controller: telefonectrl,
                    
                     
                  )
                ),

              ],

            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Data ultima compra efetuada',
                
              ),
              
              enabled: false,
              controller: datactrl,
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Produto vendido'
              ),
              enabled: false,
              controller: produtoctrl,
            ),
            Divider(
              color: Colors.black,
            ),
            Row(
              children: [
                
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Entre com nome da criança'
                    ),
                    controller: nomeFilho,
                    
                  ),
                ),
                DropdownButton(
                  iconSize: 18,
                  isExpanded: false,
                  value: sexo,
                  items: <String>["Sexo" , "M" , "F" , "N/A"]
                  .map<DropdownMenuItem<String>>((value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                    }).toList(),
                    onChanged: (String newvalue){
                     setState(() {
                       sexo = newvalue;
                     }); 
                    },
                    )
              ],
            ),
            MultiSelectDialogField(
              items: produtos.map((e) => MultiSelectItem<Produtos>(e, e.nomeItem)).toList(), 
              onConfirm: (res){
                int i =0;
                selectProdutos =res;
                for(Produtos x in selectProdutos){
                  produtosConvert[i.toString()] = x.nomeItem;
                  i = i +1;
                }
                print(produtosConvert);
              },),
          
             
             ElevatedButton(
               style: ButtonStyle(
                 backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                   if(states.contains(MaterialState.pressed))
                     return Colors.green;
                     return Colors.brown[200];
                   
                 } )
               ),
               onPressed: ()async{
                 dataPrevista = await showDatePicker(
                   context: context, 
                   initialDate: DateTime.now(), 
                   firstDate: DateTime(2018), 
                   lastDate: DateTime(2030),
                   builder: (context , child){
                     return Theme(
                       data: ThemeData.dark(),
                      child: child);
                   });
                   setState(() {

                     // ignore: unnecessary_statements
                     dataPrevista;

                   });

             }, child: Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Icon(Icons.calendar_today),
                 dataPrevista != null?
                 Text("${formatter.format(dataPrevista)}"):
                 Text("Escolha data para alerta")
               ],
             )),
             
             
              Center(
                child: ElevatedButton(
                  onPressed: (){
                  if(dataPrevista !=null && produtosConvert !=null){
                    salvaAlerta.add({
                      'dataPrevista' : dataPrevista,
                      'idCliente' : int.tryParse(codigoctrl.text),
                      'nomeFilho' : nomeFilho.text,
                      'nomeMae' : nomectrl.text,
                      'produtos' :produtosConvert,
                      'sexo': sexo,
                      'status' : true,
                      'vendaFeita': false
                    });
                  }  else{
                    showDialog(
                      context: context, 
                      builder: (context){
                        return AlertDialog(
                          title: Text("Faltando informaçao!"),
                          content: Text("Verificar campos sem preenchimento!!!"),
                          actions: [
                            ElevatedButton(
                              onPressed: (){
                                Navigator.of(context).pop();
                              },
                              child: Text("OK"))
                          ],
                        );
                      });
                  }

                  Navigator.pop(context);
                    
                  }, 
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.save),
                      Text("Salvar")
                    ],
                  )),
              )
          ],
        ),
      ),
      drawer: Drawer(
        
        child:  Scaffold(
          appBar: AppBar(
            title: Text("Lista de Alertas"),
          ),
          body:ListView.builder(
            itemCount: listaAlerta.length,
            itemBuilder:(context, index){
             // DateFormat formatter = new DateFormat("");
              return  Container(
                padding: EdgeInsets.all(10),
                color: Colors.pink[index * 100],
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Previsao de venda: ${formatter.format(listaAlerta[index].dataPrevista.toDate())}",
                    style: TextStyle(fontWeight: FontWeight.bold),),
                   
                    Text("${listaAlerta[index].nomeFilho} filho da ${listaAlerta[index].nomeMae}"),
                    Text("Produtos:"),
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: listaAlerta[index].produtos.length,
                      itemBuilder: (context , ind){
                        return Row(
                          children: [
                            SizedBox(width: 20,),
                            Text("${listaAlerta[index].produtos[ind.toString()]}"),
                          ],
                        );
                      }),

                      Divider()
                   
                  ],
                ),
              );
            } 
          ),
        
      
      backgroundColor: Colors.blue[100],
    )
      )
    );
  
  }
}

/*
 ListView.builder(
            itemCount: listaAlerta.length,
            itemBuilder: (context, index){
              var retMae = retornaMae(listaAlerta[index].idCliente);
              String mae;
               retMae.then((value) {
                 mae = value;
               print(mae);
               });
            if(mae == null){
              return Text("Sem Dados");
            } else{
              return ListTile(
                title: Text("${listaAlerta[index].nomeFilho}") ,
                subtitle: Text(mae),
              );
            }             
            
            })
*/
class Produtos{
  int id;
  String nomeItem;

  Produtos(this.id , this.nomeItem);
}