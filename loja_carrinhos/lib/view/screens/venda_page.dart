import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:loja_carrinhos/AtualizaCaixa.dart';

import 'package:loja_carrinhos/Models.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_numero.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_datetime.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_popup_cliente.dart';
import 'package:loja_carrinhos/view/screens/widgets/venda/w_pop_produtos.dart';

class PageVenda extends StatefulWidget {
  @override
  _PageVendaState createState() => _PageVendaState();
}

class _PageVendaState extends State<PageVenda> {
//Variaveis para carregar dados dos bancos cliente e estoque  
   String idProduto;
   String idCliente;
   String dataCompra; 
   String codCliente ;
   String codProd;
   String telefone;
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
                
                  codCliente = popCliente.codCliente; //Atribui cod do cliente para variavel
                  nomeControl.text = popCliente.name;//Atribui para o campo, nome de acordo banco
                  icon = codCliente == null ? Icon(Icons.thumb_down , color: Colors.red,):
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
                     if (result !=null){
                       produtoControl.text = result[1];
                       codProd = result[0];
                       iconProd = Icon(Icons.thumb_up , color: Colors.green,);
                     } else{
                       iconProd = Icon(Icons.thumb_down , color: Colors.red,);
                     }                    
                     
                   });
               }, 
               icon: iconProd),),

            WcampoTexto(rotulo: "Valor venda", variavel: valorCtrl,
            enable: true, senha: false,),

            WCampoNumero(rotulo: "parcelas",variavel: parcelasControl,),

            dropPag,

            dropBanco,
            
         datetime,
              
               //Opçao quando pagamento for alternativo
          GestureDetector(
            onTap: (){

            },
            child:WBotao(rotulo: "Salvar",) ,
          )
              
            ],
          ),
        ),
      ),

    );
  }
}