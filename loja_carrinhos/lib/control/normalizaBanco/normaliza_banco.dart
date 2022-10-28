import 'package:flutter/material.dart';
import 'package:loja_carrinhos/control/normalizaCliente/busca_cliente_estoque.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_datetime.dart';

import '../../view/screens/models/m_estoque.dart';

class NormalizaBanco extends StatefulWidget {
  const NormalizaBanco({ Key key }) ;

  @override
  _NormalizaBancoState createState() => _NormalizaBancoState();
}

class _NormalizaBancoState extends State<NormalizaBanco> {
  WDatetime datetime = new WDatetime();
  var antigoControl = TextEditingController();
  var novoControl = TextEditingController();
  List<Estoque> listEstoque;
  List<Estoque> reducedList;
  List<Map<String , dynamic>> clientes = [];
 

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normaliza Banco"),
      ),
      
      body: Container(
        child: Column(
          children: [
            datetime,
            Container(
              child: TextField(
                
                controller: antigoControl,
              ),
            ),
            Container(
              child: TextField(
                
                controller: novoControl,
              ),
            ),
            GestureDetector(
              onTap: ()async{
                //TrataDados().dadosAntigo(datetime.data);
              listEstoque = await  BuscaClienteEstoque().listaCliente();
              
              for (var item in listEstoque){

                print("${item.id}, ${item.codCliente} ");
              }             
              print(listEstoque.length);
              print("####################");

             reducedList = tratarDuplicados(listEstoque);
               },
              child: WBotao(rotulo: "Buscar Estoque",),
            ),
            
            GestureDetector(
              onTap: ()async{                               
              for (var item in reducedList){
                if (item.codCliente.length < 5){

                  clientes.add({
                    'idCliente' : await BuscaCliente().buscaCliente(item.codCliente),
                    'codCliente' : item.codCliente,
                    'idEstoque' : item.id
                  });
               
              } else{
                 clientes.add({
                    'idCliente' : item.codCliente,
                    'codCliente' : item.codCliente,
                    'idEstoque' : item.id
                  });
              }
              }
              
                for (var item in clientes){
                  print("${item['idCliente']}, ${item['codCliente']} , ${item['idEstoque']}");
              } 
              }
              ,
              child: WBotao(rotulo: "Buscar Cliente",),
            ),
           
            GestureDetector(
              onTap: ()async{
               
                for (var cliente in clientes) {

                    await UpDateClient().buscaId(cliente['idEstoque'], cliente['idCliente']);

                }

                for (var cliente in clientes) {

                    print("${cliente['idCliente']}, ${cliente['idEstoque']}");

                }
               },
              child: WBotao(rotulo: "Atualiza Estoque",),
            ),

            GestureDetector(
              onTap: ()async{                
                
                
                for (var cliente in clientes) {
                    DeletaCodigo().deletaCodigoCliente(cliente['idCliente']);
                  
                    print("${cliente['idEstoque']} , ${cliente['idCliente']} ");
                }
               },
              child: WBotao(rotulo: "Deleta codigo",),
            ),
          ],
        ),
      ),
    );
  }
  List<Estoque> tratarDuplicados(List<Estoque> lista){
    
    List<int> toRemove = [];
    List<String> aux = [];
    int cont = 0;

      lista.forEach((e) {
        if(e.codCliente != null){
          if (aux.contains(e.codCliente) ||
          e.codCliente.length > 5){
          toRemove.add(cont);
        } 
        aux.add(e.codCliente);
          
        }
        cont ++;
      });
int cont2 = 0;
    toRemove.forEach((e) {
      lista.removeAt(e - cont2);    
      cont2 ++;
    });
      print("############################");
       for (var item in lista){

                print("${item.id}, ${item.codCliente} ");
              }
      print(cont);
      print(lista.length);
    return lista;
  }
}