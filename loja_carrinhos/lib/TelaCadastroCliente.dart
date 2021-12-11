import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:loja_carrinhos/Models.dart';


class CadastroCliente extends StatefulWidget {
  @override
  _CadastroClienteState createState() => _CadastroClienteState();
}

 


class _CadastroClienteState extends State<CadastroCliente> {


  var codigo = TextEditingController();
  var nome = TextEditingController();
  var endereco = TextEditingController();
  var bairro = TextEditingController();
  List<Clientes> teste1 = [];
  String identificacao;

  
  var telefone = TextEditingController();
  List<Clientes> clientes =[];
  int x =0;
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

  var db = FirebaseFirestore.instance;

  StreamSubscription<QuerySnapshot> ouvidor;

  @override
  void initState(){
    super.initState();

    ouvidor?.cancel();

    ouvidor = db.collection('clientes').orderBy('nome').snapshots().listen((res) { 
        setState(() {
          
          clientes = res.docs.map((e) => Clientes.fromMap(e.data(), e.id)).toList();

                
    for (int i = 0; i<clientes.length; i++){

      if(int.parse(clientes[i].codigo) > x){
        x = int.parse(clientes[i].codigo);
        
      }
    }

        });


    });

    

  }

  void limpar(){
    setState(() {
      
       codigo.text = '';
                      nome.text = '';
                      telefone.text = '';
                      bairro.text = '';
                      endereco.text = '';
    });
  }
Widget setupAlertDialoadContainer(List<Map> dados) {
  return Container(
    height: 300.0, // Change as per your requirement
    width: 300.0, // Change as per your requirement
    child: ListView.builder(
      shrinkWrap: true,
      itemCount: dados.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          title: Text('Nome: ${dados[index]['nome']} , ${dados[index]['bairro']}'),
          subtitle: Text('Telefone: ${dados[index]['telefone']}'),
          onTap: (){

                      identificacao = dados[index]['identificacao'];
                      codigo.text = dados[index]['codigo'];
                      nome.text = dados[index]['nome'];
                      telefone.text = dados[index]['telefone'];
                      bairro.text = dados[index]['bairro'];
                      endereco.text = dados[index]['endereco'];

                      Navigator.pop(context);
          },
          trailing: IconButton(
            icon: Icon(Icons.delete,),

            onPressed: ()async{
            await  db.collection('clientes').doc(dados[index]['id']).delete();
              Navigator.pop(context);
            }, ),
        );
      },
    ),
  );
}

Future<List<Clientes>> checarCadastro(String nome , String fone)async{
  List<Clientes> checkCliente = []; 


await db.collection('clientes').where('nome' , isEqualTo: nome).where('telefone' , isEqualTo: fone).get().
then((doc) {
  
     checkCliente = doc.docs.map((e) => Clientes.fromMap(e.data(), e.id)).toList();
  
  
  
});

if(checkCliente.length>0){
  print("Cadastro existente");
}
return Future.value(checkCliente);
}

  @override
  Widget build(BuildContext context) {

    Map cliente = ModalRoute.of(context).settings.arguments;
    if(cliente !=null){
                      nome.text = cliente['nome'];
                      bairro.text = cliente['bairro'];
                      telefone.text = cliente['telefone'];
                      endereco.text = cliente['endereco'];
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Clientes"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              
              List<Map> dados = [];
              for(int i =0 ; i<clientes.length; i++){
                if(clientes[i].nome.contains(nome.text)  ){
                  
                  print (clientes[i].id);
                 
                  dados.add({'nome' : clientes[i].nome , 'telefone' : clientes[i].telefone,
                  'id' : clientes[i].id , 'bairro' : clientes[i].bairro, 'codigo' : clientes[i].codigo,
                  'endereco' : clientes[i].endereco, 'identificacao' : clientes[i].id});
                  }
              }

              if (dados.length>0){
                
                return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Lista Cadastrados'),
                      content: setupAlertDialoadContainer(dados),
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
              } else{
                 return showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Cadastro nao encontrado!!!'),
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
        ],

      ),

      key: _scaffoldKey,
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextField(
                decoration: InputDecoration(
                  labelText: 'codigo - preenchimento automatico'
                ),
                controller: codigo,
                enabled: false,
              ),
               TextField(
                decoration: InputDecoration(
                  labelText: 'nome'
                ),
                controller: nome,
              ),
               TextField(
                decoration: InputDecoration(
                  labelText: 'telefone'
                ),
                keyboardType: TextInputType.number,
                controller: telefone,
              ),
               TextField(
                decoration: InputDecoration(
                  labelText: 'endereco'
                ),
                controller: endereco,
                onTap: (){
                  codigo.text = (x + 1).toString();
                },
                
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: 'Bairro'
                ),
                controller: bairro,
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
                    onPressed: ()async {
                     
                        Future< List<Clientes>> teste = 
                      checarCadastro(nome.text , telefone.text);                     

                 await   teste.then((doc)  {
                      
                         teste1 =  doc;
                     });

                      if((nome.text == "" || telefone.text=="" || endereco.text=='' || bairro.text=='')){
                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Erro!"),
                              content: Text("Preencher todos os campos ativos."),
                            );
                          }
                        );
                      }else if(codigo.text != "" && identificacao !=null){
                        return showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Atualizar Cliente!!!"),
                              content: Text("Deseja Atualizar os dados do Cliente?"),
                              actions: [
                                ElevatedButton(
                                  child: Text("Ok"),
                                  onPressed: (){
                                    db.collection('clientes').doc(identificacao).update({
                          'nome' : nome.text,
                          'telefone' : telefone.text,
                          'endereco' : endereco.text,
                          'bairro' : bairro.text
                        });
                         Navigator.of(context).pop();
                                  },
                                ),
                                ElevatedButton(
                                  child: Text("Não"),
                                  onPressed: (){
                                     Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }
                        );
                        
                      } else if(teste1.length>0){

                        return showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Cliente ja cadastrado!!!'),
                              content: Text('Clique em SIM para Sair' ),
                             actions: [
                               ElevatedButton(
                                 child: Text('SIM'),
                                 onPressed: (){
                                   limpar();
                                   Navigator.of(context).pop();
                                 },
                               )
                             ],
                            );
                          },
                        );

                      }            
                      else{
                        print("Salvando...");
                         db.collection('clientes').add(
                       {
                         'codigo' : (x+1).toString(),
                         'endereco' : endereco.text,
                         'bairro' : bairro.text,
                         'nome' : nome.text,                       
                         'telefone' : telefone.text

                       }
                     ); 

                      // ignore: deprecated_member_use
                      _scaffoldKey.currentState.showSnackBar(
                            SnackBar(content: Text('Cadastrado com Sucesso!!!'))
                          );

                      }
                      limpar();
                      Navigator.of(context).pop();
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
                  ),
                 
                ],
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.grey[400],
    );
  }
}