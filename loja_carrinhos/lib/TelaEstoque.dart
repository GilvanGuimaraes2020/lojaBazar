
import 'dart:async';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Models.dart';

class TelaEstoque extends StatefulWidget {
  @override
  _TelaEstoqueState createState() => _TelaEstoqueState();
}



class _TelaEstoqueState extends State<TelaEstoque> {
var db = FirebaseFirestore.instance;
var dbCliente = FirebaseFirestore.instance;
List<Estoque> estoque = [];
List<Estoque> estoqueFilter = [];
List<Estoque> estoqueData = [];
DateTime dataPesquisa;
var _scaffoldKey = GlobalKey<ScaffoldState>();
DateFormat formatter = DateFormat('yyyy-MM-dd');
var selectDateSearch = 1;

StreamSubscription<QuerySnapshot> ouvidor;

@override
void initState(){
 super.initState();

 ouvidor?.cancel();

ouvidor = db.collection('estoque').where('status',isEqualTo: "1")
.orderBy('resProduto').snapshots().listen((res) {
  setState(() {
    
    estoque = res.docs.map((e) => Estoque.fromMap(e.data(), e.id)).toList();
  });

});
 

}



  @override
  Widget build(BuildContext context) {
    Map item = ModalRoute.of(context).settings.arguments;

    if(item != null){
      for (int i = 0; i<estoque.length; i++){
        if(estoque[i].resProduto.contains(item['tipoProduto'])){
          estoqueFilter.add(estoque[i]);
        }
    }
    }
   else{
      estoqueFilter = estoque;
    }

     void openDrawer(String data){

       estoqueData.clear();
       
       for(int i = 0 ; i < estoque.length; i++){
         if (estoque[i].data.toString() == data){
          
           estoqueData.add(estoque[i]);
           print(estoque[i].id);
         }
         
       }

       _scaffoldKey.currentState.openDrawer();

     }


     Widget geraLista(){
            
       
   
   return StreamBuilder<QuerySnapshot>(
       stream: db.collection('estoque').snapshots(),
       builder: (context , snapshots){
    switch(snapshots.connectionState){
      case (ConnectionState.none):
      return Center(child: Text("Erro ao conectar"),);
      case(ConnectionState.waiting) :
      return Center(child: CircularProgressIndicator());
      default : return ListView.builder(
        itemCount: estoqueFilter.length,
        itemBuilder: (context , index){
          return Container(
            decoration: BoxDecoration(
              color: estoqueFilter[index].resProduto.contains('Andador')?
              Colors.green[900]:
              estoqueFilter[index].resProduto.contains('Carrinho')?
              Colors.blue[200]:
              estoqueFilter[index].resProduto.contains('Cadeirão')?
              Colors.red[700]:
               estoqueFilter[index].resProduto.contains('Banheira')?
              Colors.yellow[200]:
               estoqueFilter[index].resProduto.contains('Berço')?
              Colors.pink[200]:
               estoqueFilter[index].resProduto.contains('Cadeira')?
              Colors.brown:
               estoqueFilter[index].resProduto.contains('Cadeirinha')?
              Colors.yellow[600]:
               estoqueFilter[index].resProduto.contains('Bebe')?
              Colors.purple[700]:
              estoqueFilter[index].resProduto.contains('Lote')?
              Colors.green[200]:
              Colors.transparent

            ),
            child: ListTile(
              title: Text("${estoqueFilter[index].resProduto}, ${estoqueFilter[index].resCliente}"
              , style: TextStyle(fontSize: 20),),
              subtitle: Text("R\$ ${estoqueFilter[index].valor}",style: TextStyle(fontSize: 16),),
              
              trailing: IconButton(
                icon: Icon(Icons.arrow_circle_down),
                onPressed: (){
                  if(item==null){
                    return showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Redirecionamento para Venda"),
                          content: Text("Gostaria de realizar venda do item selecionado?"),
                          actions: [
                             ElevatedButton(
              child: Text('Sim'),
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
                 Map selectEstoque = Map();
                 selectEstoque['idEstoque'] = estoqueFilter[index].id;
                 selectEstoque['adressRoute'] = ModalRoute.of(context).settings.name;
                 selectEstoque['nomeProduto'] = estoqueFilter[index].resProduto;
                 selectEstoque['valorCompra'] = estoqueFilter[index].valor;
                 selectEstoque['codProdEst'] = estoqueFilter[index].codProduto;
                 selectEstoque['dataCompra'] = estoqueFilter[index].data;


                 Navigator.pushNamed(context, '/telaEstoque', arguments: selectEstoque);
                });
              },

              
            ),
                          ],
                        );
                      },
                    );
                    

                  } else if(item['adressRoute'] == "/agenda"){

                   
                  } else if(item['adressRoute'] == "/agendamento"){
                   
                    Map dadosRetorno = Map();
                    
                    dadosRetorno['idProduto'] = estoqueFilter[index].id;
                    dadosRetorno['detalhe'] = estoqueFilter[index].resProduto;

                    

                    Navigator.pushNamed( context,"/agendamento", arguments: dadosRetorno );
                  }
                },
              ),

              onTap: ()async{
                List<Clientes> detCliente = [];
                DateFormat dataCompra = DateFormat("yyyy-MM-dd");
                await dbCliente.collection('clientes').
                where('codigo' , isEqualTo: estoqueFilter[index].codCliente).get().then((doc){
                  detCliente = doc.docs.map((e) => Clientes.fromMap(e.data(), e.id)).toList();
                });
                return showDialog(
                  context: context,
                  builder: (context){
                    return AlertDialog(
                      title: Text("Detalhes do Compra"),
                      content: Column(
                        children: [
                          Text('Telefone : ${detCliente[0].telefone }'),
                          Text('Endereco : ${detCliente[0].endereco }'),
                          Text('Cor do item: ${estoqueFilter[index].cor }'),
                          Text('Data: ${dataCompra.format(estoqueFilter[index].data.toDate())}')
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                          child:  Text("OK"),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                        )
                      ],
                    );
                  }
                );
              }, 
              
            ),
          );
        },
      );
    }
       },
     );
} 



    return Scaffold(
      appBar: AppBar(
        title: Text("Estoque") ,
        leading: IconButton(
          icon: Icon(Icons.keyboard_backspace),
          onPressed: (){
            Navigator.of(context).pop();
          },),
        actions: [
          DropdownButton(
            value: selectDateSearch,
            items: <int>[1 , 2 , 3 , 4 , 5, 6 , 7 , 8 , 9 , 10 , 11 , 12].map<DropdownMenuItem<int>>(
              (value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text("$value"),
                );
              }).toList(),
              onChanged: (newValue){
                setState(() {
                  selectDateSearch = newValue;
                });
              },
              ),
          IconButton(
            icon: Icon(Icons.search),
            onPressed: ()async{
              
              dataPesquisa = await showDatePicker(
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

                if(dataPesquisa!=null){
        openDrawer(formatter.format(dataPesquisa));
    }
          
              });
              
            },
          )

        ],),

        key: _scaffoldKey,

        body: geraLista(),
        

        drawer: Drawer(
          child: Scaffold(
            appBar: AppBar(
              title: Text("Produtos comprados em $dataPesquisa"),
            ),
            body: ListView.builder(
             itemCount: estoqueData.length,
             itemBuilder: (context, index){
               return ListTile(
                 title: Text("${estoqueData[index].resProduto}, ${estoqueData[index].resCliente}"
            , style: TextStyle(fontSize: 14),),
            subtitle: Text("R\$ ${estoqueData[index].valor}",style: TextStyle(fontSize: 12),),
               );
             },

               ),
          ),
        
        ),

        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.plagiarism),
          onPressed: (){
            List<String> produtos = ['Carrinho' , 'Banheira', 'Andador', 'Berço','Chiqueirinho'
                        ,'Conjunto','Bebe Conf c base','Bebe Conf s base' ,'Cadeira p auto', 'Cadeirinha',
                        'Cadeirão','tapete educ', 'Lote Roupas'];

 // List<String> lista = List();

  Map<String , int> dados = Map();
  
  if (estoqueFilter.length > 0){

    produtos.forEach((e) {
     estoqueFilter.forEach((element)  {
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
    /* print(listaKeys);
    print(dados); */


            return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text("${estoqueFilter.length} itens no estoque"),
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
          }
        ),
        );
        
    
  }
}