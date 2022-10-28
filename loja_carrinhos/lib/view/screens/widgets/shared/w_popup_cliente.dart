

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_cliente.dart';
import 'package:loja_carrinhos/view/screens/cadastro_cliente_page.dart';
import 'package:loja_carrinhos/view/screens/models/m_clientes.dart';
import 'package:loja_carrinhos/view/screens/routes/routes.dart';


class WpopupCliente extends StatefulWidget {
   String name;   
   String codCliente;
   String telefone;
   String idCliente;
    WpopupCliente({ Key key, this.name, this.codCliente, this.telefone, this.idCliente });

  @override
  _WpopupClienteState createState() => _WpopupClienteState();
}

 
  
class _WpopupClienteState extends State<WpopupCliente> {
  var listaCadastro = FirebaseFirestore.instance.collection("clientes");
  List<MClientes> clientes = [];
  @override
  void initState(){
    super.initState();
    listaCadastro.orderBy("nome").where("nome" , isGreaterThanOrEqualTo: widget.name).where("nome" , isLessThanOrEqualTo: widget.name + "z").get().then((value) {
      setState(() {
        clientes = value.docs.map((e) => MClientes.fromMap(e.data(), e.id)).toList();

      });
    } );
  }
  
  @override
  Widget build(BuildContext context) {
    return  AlertDialog(
                         title: Text("Clicar no nome!!! "),

                         //Forma lista com cadastros ja realizados para verificar se ja esta salvo
                         content: listaClienteCadastrado(clientes),
                         actions: [
                           ElevatedButton(
                             child: Text("Cadastrar Cliente"),
                             onPressed: (){
                               Routes.rota(context, CadastroClientePage());
                               setState(() {
                                 
                               });
                              
                             },
                           )
                         ],
                       );
  }

  listaClienteCadastrado(List<MClientes> nomes){
    return Container(
      height: 300,
      width: 300,
      child: ListView.builder(
        itemCount: nomes.length,
       
        itemBuilder: (context, index){
         
            return ListTile(
            title: Text("Nome: ${nomes[index].nome}, ${nomes[index].endereco} "),
            subtitle: Text("Telefone: ${nomes[index].telefone}"),
            trailing: IconButton(
              onPressed: (){
                String result = WriteCliente().deleteCliente(nomes[index].id);
                //retorno da açao no banco
                Navigator.pop(context , [result]);
              }, 
              icon: Icon(Icons.delete)),
            onTap: (){
              List<Map<String , dynamic>> retorno =[
                {
                //"codigo" : nomes[index].codigo,
                "nome" : nomes[index].nome ,
                "telefone" : nomes[index].telefone,
                "bairro" : nomes[index].bairro,
                "id" : nomes[index].id,
                "endereco" : nomes[index].endereco
                }
              ]; 

              widget.codCliente = nomes[index].id;
              widget.name = nomes[index].nome ;
              widget.telefone= nomes[index].telefone;
              widget.idCliente=nomes[index].id;

              Navigator.pop( context , retorno);
            },
          );          
        },

      ),
    );

  }
}
