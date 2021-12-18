import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'Models.dart';

class CadastroProduto extends StatefulWidget {
  @override
  _CadastroProdutoState createState() => _CadastroProdutoState();
}

class _CadastroProdutoState extends State<CadastroProduto> {
  var codigoControl = TextEditingController();

  //CadastroProduto();
 
  var modeloControl = TextEditingController();
  String tipoProduto = 'Selecione';
  String marca = 'Burigotto';
  List<Produtos> produto = [];
  
  int x = 0;

  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> ouvidor;
  
  @override
  void initState(){
    super.initState();
    produto.clear();
    ouvidor?.cancel();

    ouvidor = db.collection('produtos').orderBy('tipoProduto').snapshots().listen((res) {
      
        produto = res.docs.map((e) => Produtos.fromMap(e.data(), e.id)).toList();

      

       for (int i = 0; i<produto.length; i++){

      if(int.parse(produto[i].codigo) > x){
        x = int.parse(produto[i].codigo);
        
      }
    }
     });

  }

var _scaffoldKey  = new GlobalKey<ScaffoldState>(); 

limpar(){

  
    codigoControl.text = "";
    modeloControl.text = "";
    
  
  
}
  



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text("Cadastro de Produto"),
        actions: [
          IconButton(
icon: Icon(Icons.delete) ,
onPressed: (){
 
  return showDialog(
    context: context,
    builder: (context){
      return AlertDialog(
        title: Text("Selecione tipo Arquivo para Deletar"),
        content:SingleChildScrollView(
          child: Container(
              height: 300,
              width: double.maxFinite,
              child: ListView.builder(
                
                itemCount: produto.length,
                itemBuilder: (context , index){
                  return ListTile(
                    title: Text("${produto[index].tipoProduto} , ${produto[index].marca}") ,
                    subtitle: Text("${produto[index].modelo}"),
                    trailing: IconButton(
                      icon:Icon(Icons.delete) ,
                      onPressed: ()async{
                        print(produto[index].id);
                         db.collection('produtos').doc(produto[index].id).delete();
                        Navigator.pop(context);

                      },
                    ) ,
                    );
                },
               ),
            ),
        ) ,
        
         
         actions: [
           ElevatedButton(
             child: Text("Pesquisar"),
             onPressed: (){
               setState(() {
                             
                              });
             },
           ),
         ],
      );
    }
  );
},
          )
        ],
      ),
key: _scaffoldKey,
      body: SingleChildScrollView(
              child: Container(
            padding: EdgeInsets.fromLTRB(20,0,20,30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'codigo do produto - preenchimento automatico'
          ),
          controller: codigoControl,
          enabled: false,
        ),
               
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             Container(child: Column(
               children: [
                 Text("Tipo Produto",
                 style: TextStyle(fontSize: 18),),
                 DropdownButton<String>(
                        value: tipoProduto,
                        items: <String>['Carrinho' , 'Banheira','Eletronico', 'Andador', 'Berço','Chiqueirinho'
                        ,'Conjunto','Bebe Conf c base','Bebe Conf s base' ,'Cadeira p auto', 'Cadeirinha',
                        'Cadeirão','Selecione','tapete educ','Triciclo','Kit Berço','Kit Higiene', 'Lote Roupas','Colchão',
                        'Cobertor', 'Almofada', 'Carrinho Bug' ]
                        .map<DropdownMenuItem <String>>((String value){
                          return DropdownMenuItem <String>(
                            value: value,
                            child: Text(
                              value , style: TextStyle(fontSize: 16),
                            ));
                        } ).toList(), 
                                 
                        onChanged: (String newValue){
                          setState(() {
                            tipoProduto = newValue;
                            print(tipoProduto);
                          });
                        }),
               ],
             )),
             Container(child: Column(
               children: [
                 Text("Marca" , 
                 style: TextStyle(fontSize: 18),),
                  DropdownButton<String>(
                    value: marca,
                    items: <String>['Galzerano' , 'Burigotto', 'BabyStyle' ,'Fischer Price', 'Tutti', 'Infanti', 'Chicco',
                    'Cosco', 'Voyage','Gracco', 'Safety', 'Peg-Perego' ,'Outros']
                    .map<DropdownMenuItem <String>>((String value){
                      return DropdownMenuItem <String>(
                        value: value,
                        child: Text(
                          value , style: TextStyle(fontSize: 16),
                        ));
                    } ).toList(), 
                                 
                    onChanged: (String newValue){
                      setState(() {
                        marca = newValue;
                        print(marca);
                      });
                    }),
               ],
             )),
            
           ],
         ),
        

         Divider(
           height: 2,
           color: Colors.brown,
         ),
         
         TextField(
          decoration: InputDecoration(
            labelText: 'modelo'
          ),
          controller: modeloControl,
          onTap: (){
            setState(() {
              codigoControl.text = (x + 1).toString();
            });
            
          },
        ),
        
        
        

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
              child: Text('Cadastrar'),
               style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
              onPressed: ()async{
                if(modeloControl.text == ""){
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Falta informaçao!!!"),
                        content: Text("Inserir Modelo do produto"),
                      );
                    },
                  );
                } else{
                  await db.collection('produtos').add({
                  'codigo' : (x + 1).toString(),
                  'tipoProduto' : tipoProduto,
                  'marca' : marca,
                  
                  'modelo' : modeloControl.text,
                 
                });
                Navigator.pop(context);
                limpar();

                // ignore: deprecated_member_use
                _scaffoldKey.currentState.showSnackBar(
                  SnackBar(content: Text('Salvo com Sucesso!!!'),)
                );
                }
                

                
              },

              
            ),

             ElevatedButton(
              child: Text('Limpar'),
style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),              onPressed: (){

                setState(() {
                  modeloControl.text = "";
                  
                  
                 
                  codigoControl.text = "";
                });
              },

              
            ),
          ],
        ),
              ],
            ),
          ),
      ),
      
    );
  }
}