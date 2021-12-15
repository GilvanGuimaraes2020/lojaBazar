import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_campo_texto.dart';
import 'package:loja_carrinhos/view/shared/messages/messages.dart';
import 'Models.dart';

class Comentarios extends StatefulWidget {
  @override
  _ComentariosState createState() => _ComentariosState();
}

class _ComentariosState extends State<Comentarios> {
  var comentarioControl = TextEditingController();
  var dbComentario = FirebaseFirestore.instance;
  StreamSubscription<QuerySnapshot> ouvidor;
  List<Comentario> comentario = [];
   

  @override
  void initState(){
    super.initState();

    ouvidor?.cancel();

    ouvidor = dbComentario.collection('comentarios').where('dataConclusao', isEqualTo: '')
    .orderBy('data').snapshots().listen((res) { 
setState(() {
  comentario = res.docs.map((e) => Comentario.fromMap(e.data() , e.id)).toList();

});
      
    });
  }


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Comentarios de ajustes"),
        
        
      ),

      body: Container(
        child: Column(
          children: [
            WcampoTexto(variavel: comentarioControl,
            rotulo: Messages("informacao").returnMessage(),
            senha: false,

            ),
            
            Container(
              child: Expanded(
                child: ListView.builder(
                  itemCount: comentario.length,
                  itemBuilder: (context , index){
                    return ListTile(
                      title: Text("Pendencia: ${comentario[index].comentario}"),
                      subtitle: Text("Data: ${comentario[index].data} "),
                      onTap: (){
                        return showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Conclusão tarefa!!!"),
                              content: Text("Confirmar conclusão da tarefa."),
                              actions: [
                                ElevatedButton(
            child: Text('Sim'),
            /* shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)
                  ),
                  color: Colors.blue[200], */
                 style: ButtonStyle(
                    
                 ),
            onPressed: (){
              
              DateFormat formatter = DateFormat("yyyy-MM-dd");
               dbComentario.collection('comentarios').doc(comentario[index].id).update({
                'dataConclusao' : formatter.format(DateTime.now())
              });

              Navigator.pop(context);
            },

            
          ),
                              ],
                            );
                          }
                        );
                      },
                    );
                  },
                ),
              ),
            )
            
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: (){
              if(comentarioControl.text != ""){
                DateFormat formatter =  DateFormat('yyyy-MM-dd');
               dbComentario.collection('comentarios').add({
                'comentario': comentarioControl.text,
                'dataConclusao' : "",
                'data' : formatter.format(DateTime.now())
              });
              }

              comentarioControl.text = ""; 


        },
        ),
    );
  }
}