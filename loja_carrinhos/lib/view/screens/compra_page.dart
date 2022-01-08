
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_estoque.dart';
import 'package:loja_carrinhos/view/screens/widgets/compra/page_pgto_alt.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_popup_cliente.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_datetime.dart';
import 'package:loja_carrinhos/view/screens/widgets/compra/w_popup_cadastro.dart';

class CompraPage extends StatefulWidget {
  @override
  _CompraPageState createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {
 
  var nomeControl = TextEditingController();
  var produtoControl = TextEditingController();
  Icon icon = Icon(Icons.search);
  Icon iconProd = Icon(Icons.search );
  var valorControl = TextEditingController();
  String codCliente ;
  String codProd ;
  var corControl = TextEditingController();
   var dropPag = WDropDown(selectedItem: "nenhum", selectList: "pagamento",);
   var dropBanco = WDropDown(selectedItem: "nenhum", selectList: "banco");
   var dropSexo = WDropDown(selectedItem: "nenhum",selectList: "sexo");
   var dataTime = WDatetime();
 

  @override
  Widget build(BuildContext context) {
 
//******************Inicio do retorno de builder******************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Compra"),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)
        ),
         
      ),
      
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                       return WpopupCadastro();
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
            
 //Campo para inserir cor ou detalhe do produto            
            WcampoTexto(rotulo: "cor ", senha: false,
            variavel: corControl,),

 //Campo para inserir valor do produto            
              WcampoTexto(rotulo: "valor", senha: false,
              variavel: valorControl,),
             
//Apresenta opçoes para o sexo do produto             
             dropSexo,
             
//Apresenta opçoes para o tipo de pagamento
              Builder(
                builder: (context) {
                  return dropPag;
                }
              ),
                
//Apresenta local para movimento monetario
              dropBanco,
//Opçao quando pagamento for alternativo
              
//calendario para escolher data
              dataTime,
             
//Apresenta seleçao de bancos, caso tipo de pagamento seja = transferencia            
             
             GestureDetector(
               onTap: ()async{
                 List caixa = [];
                   Map<String, dynamic> mapEstoque = {
                     "resCliente" :nomeControl.text,
                    "codCliente" :codCliente,
                     "resProduto" : produtoControl.text,
                     "codProduto" : codProd,
                     "valor" : valorControl.text ,
                     "status" : "1",
                     "data" : dataTime.data,
                     "cor" : corControl.text,
                     "sexo" : dropSexo.selectedItem,
                     
                   };

                 if (dropPag.selectedItem == "pagamento alternativo"){
                 print(produtoControl.text);
                   final result = await Navigator.push(
                     context, 
                     PageRouteBuilder(
                       transitionDuration: Duration(milliseconds: 100),
                       pageBuilder: (_ , __ , ___)=>PagePgtoAlt(totalCompra: double.tryParse(valorControl.text) ,)));
                        print(result);
                         for (var item in result) {
                            caixa.add(
                       {                                                
                         "banco" :item['banco'],
                         "operacao" :item['operacao'],
                         "valor":item['valor'],
                         "status" : "Saida"
                                             
                      });
                         }                         
                        
                 } else{
                  
                    caixa = [
                       {    
                                             
                         "banco" :dropBanco.selectedItem,
                         "operacao" :dropPag.selectedItem,
                         "valor":valorControl.text,
                         "status" : "Saida"
                      }
                     ]; 
                
                 }
                    String saved = await  WriteEstoque().writeEstoque(mapEstoque , caixa, dataTime.data);           
                 
               },
               child: WBotao(
                 rotulo: "Salvar",
               ))
            ],
          ),

        ),
      ),

    backgroundColor: Colors.brown[100],
    );
  }
}

