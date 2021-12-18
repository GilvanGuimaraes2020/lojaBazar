import 'package:flutter/material.dart';


import 'package:loja_carrinhos/data/service/user_auth_service.dart';
import 'package:loja_carrinhos/view/screens/home_page.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_campo_texto.dart';
import 'package:toast/toast.dart';

class CadastroUsuaruio extends StatefulWidget {
  const CadastroUsuaruio({ Key key, this.title });
  final String title;

  @override
  _CadastroUsuaruioState createState() => _CadastroUsuaruioState();
}

class _CadastroUsuaruioState extends State<CadastroUsuaruio> {
 
  var ctrlNome = TextEditingController();
  var ctrlEmail = TextEditingController();
  var ctrlSenha = TextEditingController();
  var ctrlValSenha = TextEditingController();
  var formState = GlobalKey<FormState>();
  userAuthService userAuth = new userAuthService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Cadastro Usuario")
        ,

      ),
      body: Container(
        child: Form(

          key: formState,
          child: Column(
            children:[
              WcampoTexto(variavel: ctrlNome,
              rotulo: "Nome", senha: false, validator: (value){
                if(value.length == 0){
                  return 'Preencher Campo';
                } else{
                  return null;
                }
              },),
               WcampoTexto(variavel: ctrlEmail,
              rotulo: "Email", senha: false, validator: (value){
                String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp valor = new RegExp(pattern);
                
                if(value.length >= 0 && valor.hasMatch(value)){
                  return null;
                } else{
                  
                  return 'Preencher Campo';
                }
              },),
               WcampoTexto(variavel: ctrlSenha,
              rotulo: "Senha", senha: true, validator: (value){
                if(value.length == 0){
                  return 'Preencher Campo';
                } else{
                  return null;
                }
              },),
               WcampoTexto(variavel: ctrlValSenha,
              rotulo: "Valida Senha", senha: true, validator: (value){
                if(value.length == 0){
                  return 'Preencher Campo';
                } else{
                  return null;
                }
              },),
              GestureDetector(
                onTap: (){
                  cadastro();
                },
                child:  WBotao(
                rotulo: "Cadastrar",
              ),
              )
             
            ]
          )),
      ),
    );
  }
  Future<void> cadastro() async {
    if (formState.currentState.validate()){
      String result = await userAuth.cadastro(ctrlEmail.text, ctrlSenha.text);
      print(result);
      if (result == 'usuario cadastrado com sucesso'){
        Toast.show(result, context, 
        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM,backgroundColor: Colors.green);
        Navigator.push(
          context, 
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 100),
            pageBuilder: (_ , __ , ___) => HomePage()));
      } else {
        formState.currentState.reset();
        Toast.show(result, context, 
        duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM,backgroundColor: Colors.red);
      } 
    } else{
      print("Preencher formulario");
    }
  }
}