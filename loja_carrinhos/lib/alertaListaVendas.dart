import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/TelaMenu.dart';
import 'Models.dart';

class AlertaListaTela extends StatefulWidget {
  
  @override
  _AlertaListaTelaState createState() => _AlertaListaTelaState();
}

class _AlertaListaTelaState extends State<AlertaListaTela> {
  DateFormat formatter = new DateFormat("yyyy/MM/dd");
  List<AlertaLista> listaAlerta = [];
  var salvaAlerta = FirebaseFirestore.instance.collection("alertas");
  var clientes = FirebaseFirestore.instance.collection("clientes");
  
  @override
   void initState() {
   super.initState();

  salvaAlerta.where('status' ,isEqualTo: true).get().then((value) {
    setState(() {
      listaAlerta = value.docs.map((e) => AlertaLista.fromMap(e.id, e.data())).toList();
    });
   
  });

   
}
Future<String> retornaMae(int codigo) async {
  print("Entrou funçao");
  String dado;
await  clientes.where('codigo', isEqualTo: codigo.toString())
                .get().then((value) => value.docs.forEach((element) {
                  
                 dado = element.data()['nome'];
                 })
                );
                 return Future.value(dado);
} 

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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

                      ElevatedButton(
                        onPressed: (){
                          return showDialog(
                            
                            context: context, 
                            builder: (context){
                              return AlertDialog(
                                backgroundColor: Colors.black,
                                title: Text("Realizar açao",style: TextStyle(color: Colors.white),),
                                content: Text("Escolher abaixo açao a ser executada"
                                ,style: TextStyle(color: Colors.white),),
                                actions: [
                                  ElevatedButton(
                                    onPressed: (){
                                      salvaAlerta.doc(listaAlerta[index].id).update({
                                        'status': false
                                      });

                                       Navigator.pushAndRemoveUntil(context, 
                                      MaterialPageRoute(builder: (context) => Menu()), 
                                      ModalRoute.withName('/'));
                                    }, 
                                    child: Icon(Icons.delete)),
                                    ElevatedButton(
                                    onPressed: ()async{
                                      DateTime data = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(), 
                                        firstDate: DateTime(2018), 
                                        lastDate: DateTime(2030),
                                        builder: (context, child){
                                          return Theme(
                                          data: ThemeData.dark(),
                                          child: child );
                                        } ,

                                        );

                                      salvaAlerta.doc(listaAlerta[index].id).update({
                                        'dataPrevista' : data
                                      });

                                      Navigator.pushAndRemoveUntil(context, 
                                      MaterialPageRoute(builder: (context) => Menu()), 
                                      ModalRoute.withName('/'));
                                    }, 
                                    child: Icon(Icons.compare_arrows)),
                                     
                                ],
                              );
                            });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Executar açoes neste registro"),
                            Icon(Icons.double_arrow)
                          ],
                        ),
                      ),

                      Divider()
                   
                  ],
                ),
              );
            } 
          ),
        
      
      backgroundColor: Colors.blue[100],
    );
  }
}