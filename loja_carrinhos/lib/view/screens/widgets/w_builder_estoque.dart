
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/m_clientes.dart';
import 'package:loja_carrinhos/view/screens/models/m_estoque.dart';
import 'package:loja_carrinhos/view/shared/colors/colors_widgets.dart';



class BuilderEstoque extends StatefulWidget {
  final List<Estoque> estoque; 
  BuilderEstoque({ Key key, this.estoque});

  @override
  _BuilderEstoqueState createState() => _BuilderEstoqueState();
}

class _BuilderEstoqueState extends State<BuilderEstoque> {

 
 var db = FirebaseFirestore.instance;
 
  @override
  Widget build(BuildContext context) {
  
   return Container(
     child: ListView.builder(
          itemCount: widget.estoque.length,
          itemBuilder: (context , index){
            return Container(
              decoration: BoxDecoration(

                color: ColorsWidget().colorwidget(widget.estoque[index].resProduto)

              ),
              child: ListTile(
                title: Text("${widget.estoque[index].resProduto}, ${widget.estoque[index].resCliente}"
                , style: TextStyle(fontSize: 20),),
                subtitle: Text("R\$ ${widget.estoque[index].valor}",style: TextStyle(fontSize: 16),),
                
                onTap: ()async{
                  
                  var detCliente ;
                 
                  await db.collection('clientes').
                  doc(widget.estoque[index].codCliente).get().then((doc){
                    detCliente = MClientes.fromMap(doc.data(), doc.id);                   
                  });
                  return showDialog(
                    context: context,
                    builder: (context){
                      return AlertDialog(
                        backgroundColor: Colors.blue[200],
                        title: Text("Detalhes da Compra"),
                        content: Column(
                          children: [
                            Text('Nome : ${detCliente.nome }'),
                            Text('Telefone : ${detCliente.telefone }'),
                            Text('Endereco : ${detCliente.endereco }'),
                            Text('Bairro : ${detCliente.bairro }'),
                            Text('Cor: ${widget.estoque[index].cor }'),
                            Text('Data: ${widget.estoque[index].data.toDate()}')
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
          },),    
       
   );
  }
}