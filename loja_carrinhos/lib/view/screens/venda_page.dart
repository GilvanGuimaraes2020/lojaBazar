import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_venda.dart';
import 'package:loja_carrinhos/view/screens/widgets/compra/page_pgto_alt.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_numero.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_datetime.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_popup_cliente.dart';
import 'package:loja_carrinhos/view/screens/widgets/venda/w_pop_produtos.dart';
import 'package:loja_carrinhos/view/shared/validation.dart';
import 'package:toast/toast.dart';

import '../shared/messages/retornoEventos.dart';

class PageVenda extends StatefulWidget {
  @override
  _PageVendaState createState() => _PageVendaState();
}

class _PageVendaState extends State<PageVenda> {
//Variaveis de estado
  var globalKey = GlobalKey<FormState>();
  Map<String , bool> valIcon ; //Validar widgets fora do form
//Variaveis para carregar dados dos bancos cliente e estoque  
   String idCliente;
   String codCliente ;
   String telefone;
   Map retEstoque;
//Variaveis de controle e indicaçao
   Icon icon = Icon(Icons.search);
   Icon iconProd = Icon(Icons.search);
   var nomeControl = TextEditingController();
   var produtoControl = TextEditingController();
   var valorCtrl = TextEditingController();
   var parcelasControl = TextEditingController();
//instaciamento de widgets 
   var datetime = WDatetime ();
   var dropBanco = WDropDown(selectList: "banco", selectedItem: "nenhum",);
   var dropPag = WDropDown(selectList: "pagamento", selectedItem: 'nenhum',);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Venda"),        
      ),

      body: SingleChildScrollView(
          child: Container(
          padding: EdgeInsets.all(10),
          child: Form(
            key: globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
          
                //Campo para inserir nome do cliente 
                WcampoTexto(rotulo: "Nome Cliente", 
               senha: false, variavel: nomeControl,
               
               icon: IconButton(onPressed: ()async{
                 //popup para escolher cliente cadastrado
                 var popCliente = WpopupCliente(name: nomeControl.text);
                 
                await showDialog(
                       context: context,
                       builder: (context) {
                         return popCliente;
                       },
                     );

                     
                setState(() {
                  
                    idCliente = popCliente.idCliente;
                    telefone = popCliente.telefone;
                    nomeControl.text = popCliente.name;//Atribui para o campo, nome de acordo banco
                   /*  if (idCliente == null){
                      icon = Icon(Icons.thumb_down , color: Colors.red,);
                      valIcon['nome'] = false;
                    }else{
                      Icon(Icons.thumb_up_alt,color: Colors.green,);
                      valIcon['nome'] = true;
                    } */
                     icon = idCliente == null ? Icon(Icons.thumb_down , color: Colors.red,):
                                                Icon(Icons.thumb_up_alt,color: Colors.green,);
                  
                                                
                  
                });
          
               }, icon: icon), 
               ), 
          
               //Campo para inserir nome produto. Chama pop-up para escolha de produto ou cadastro de novo produto
               WcampoTexto(rotulo: 'Produto' ,
               variavel: produtoControl, senha: false,
               icon: IconButton(
                 onPressed: ()async{
                  
                   final result = await showDialog(
                       context: context,
                       builder: (context) {
                         return WpopupProduto(produto: produtoControl.text,);
                       },
                     );
                     print(result);

                    setState(() {
                       
                         retEstoque = result;
                          if (retEstoque !=null){
                         produtoControl.text = retEstoque['resProduto'];
                         iconProd = Icon(Icons.thumb_up , color: Colors.green);
                          
                          } else{
                            iconProd = Icon(Icons.thumb_down , color: Colors.red);
                          }           
                       
                     });
                 }, 
                 icon: iconProd),),
          
              WcampoTexto(rotulo: "Valor venda", variavel: valorCtrl,
              validator: (value){
                Validation().campoTexto(value);} ,
              enable: true, senha: false,),
          
              WCampoNumero(rotulo: "parcelas",variavel: parcelasControl,
              validator: (value){
                Validation().campoNumero(value);
              },),
          
              dropPag,
          
              dropBanco,
              
              datetime,
                
                 //Opçao quando pagamento for alternativo
            GestureDetector(
              onTap: ()async{


                if(globalKey.currentState.validate()){
                
                List caixa= [];
                Map<String, dynamic> toSalve = {
                  "data" : datetime.data,
                  "dataCompra" : retEstoque['dataCompra'],
                  "detTransacao":parcelasControl.text,
                  "idCliente": idCliente,
                  "idProduto":retEstoque['idProduto'],
                  "nomeCliente":nomeControl.text,
                  "nomeProduto":retEstoque['resProduto'],
                  "telefone": telefone,
                  "transacao":dropPag.selectedItem,
                  "valor":valorCtrl.text,
                  "valorCompra":retEstoque['valor']
          
                };
                if(dropPag.selectedItem == "pagamento alternativo"){
                   print(produtoControl.text);
                     final result = await Navigator.push(
                       context, 
                       PageRouteBuilder(
                         transitionDuration: Duration(milliseconds: 100),
                         pageBuilder: (_ , __ , ___)=>PagePgtoAlt(totalCompra: double.tryParse(valorCtrl.text) ,)));
                          print(result);
                           for (var item in result) {
                              caixa.add(
                         {                                                
                           "banco" :item['banco'],
                           "operacao" :item['operacao'],
                           "valor":item['valor'],
                           "status" : "Entrada"
                                               
                        });
                           }
                } else{
                caixa = [{
                  "banco" : dropBanco.selectedItem,
                  "operacao" :dropPag.selectedItem,
                  "valor" : valorCtrl.text,
                  "status":"Entrada"
                }];
                }            
          
                String saved = await WriteVenda().writeVenda(toSalve, caixa , datetime.data, retEstoque['idProduto']);
          
                if(saved == RetornoEventos().salvo){
                        Toast.show(saved, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.green);
                        }else{
                        Toast.show(saved, context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.red);
                     }
                     Navigator.pop(context);
          }
              },
              child:WBotao(rotulo: "Salvar",) ,
            )
                
              ],
            ),
          ),
        ),
      ),

    );
  }
}