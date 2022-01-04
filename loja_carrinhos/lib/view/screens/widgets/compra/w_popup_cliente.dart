

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/TelaCadastroCliente.dart';
import 'package:loja_carrinhos/view/screens/models/m_clientes.dart';

class WpopupCliente extends StatefulWidget {
   String name;
   
   String codCliente;
   WpopupCliente({ Key key, this.name });

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
                               Navigator.push(context, 
                               PageRouteBuilder(
                                 transitionDuration: Duration(milliseconds: 100),
                                 pageBuilder: (_ , __ , ___) => CadastroCliente()));
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
            onTap: (){
              widget.codCliente = nomes[index].codigo;
              widget.name = nomes[index].nome ;
              
              Navigator.of(context).pop();
            },
          );          
        },

      ),
    );

  }
}

/* cadastroNaoRealizado(String nome){
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
    } */