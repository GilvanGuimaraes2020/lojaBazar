import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_cliente.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_popup_cliente.dart';
import 'package:loja_carrinhos/view/shared/validation.dart';
import 'package:toast/toast.dart';

class CadastroClientePage extends StatefulWidget {
  const CadastroClientePage({ Key key });

  @override
  _CadastroClientePageState createState() => _CadastroClientePageState();
}

class _CadastroClientePageState extends State<CadastroClientePage> {
  //variaveis controles e indicaçao
  var nomeControl = TextEditingController();
  
  var enderecoControl = TextEditingController();
  var telefoneControl = TextEditingController();
  var bairroControl = TextEditingController();
  Color cor = Colors.blue;
  var globalKey = GlobalKey<FormState>();

  //variaveis  carregar dados
  String rotuloBotao = "Salvar";
  String id = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cadastro de Clientes"),),

      body: SingleChildScrollView(
        child: Container(

          child: Form(
            key: globalKey,
            child: Column(
              children: [
                //Campo nome
                WcampoTexto(rotulo: "Nome", senha: false,
                variavel: nomeControl,
                validator: (String value){
                  print(value);
                 return Validation().campoTexto(value);
                },
                icon: IconButton(
                  onPressed: ()async{
                    
                    final result = await showDialog(
                         context: context,
                         builder: (context) {
                           return WpopupCliente(name: nomeControl.text);
                         },
                       );
                       print(result);
                      if(result!= null){
                        if( result[0] is String){

                          Toast.show(result[0], context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                          Navigator.pop(context);
                        }else if(result[0] is Map){
                           setState(() {
                         cor = Colors.green;
                         rotuloBotao = "Alterar Cadastro";
                         nomeControl.text = result[0]["nome"];
                         enderecoControl.text = result[0]["endereco"];
                         bairroControl.text = result[0]["bairro"];
                         telefoneControl.text = result[0]["telefone"];
                         id = result[0]['id'];
                       }); 
                        }
                       
                      }
                      
                  },
                  icon: Icon(Icons.search),),),
          
                //campo telefone
                WcampoTexto(rotulo: "Telefone", senha: false,
                variavel: telefoneControl,
                validator: (String value){
                 return Validation().campoTelefone(value);
                },),
          
                //Campo endereco
                WcampoTexto(rotulo: "Endereço", senha: false,
                variavel: enderecoControl,
                validator: (String value){
                 return Validation().campoTexto(value);
                },),
          
                //Campo bairro
                WcampoTexto(rotulo: "bairro", senha: false,
                variavel: bairroControl,
                validator: (String value){
                 return Validation().campoTexto(value);
                },),
                
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        GestureDetector(
          onTap: (){
            if(globalKey.currentState.validate()){
              String retorno;
              Map<String , dynamic> map = {
                "nome" : nomeControl.text,
                "endereco" : enderecoControl.text,
                "bairro" : bairroControl.text,
                "telefone" : telefoneControl.text
              };

              if (id!=""){                
                retorno = WriteCliente().atualizaCliente(id , map);
                print("ID $id,  $retorno");
              }else{
                retorno = WriteCliente().salvaCliente(map);
                Toast.show(retorno , context, duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM, backgroundColor: Colors.green);
                print(" $retorno");
              }
              
               Navigator.pop(context);

              
            }            
           
          },
          child: WBotao(rotulo: rotuloBotao,
          cor: cor,
          ),
        )
      ],
    );
  }
}