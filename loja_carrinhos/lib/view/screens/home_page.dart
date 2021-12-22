import 'package:flutter/material.dart';


import 'package:loja_carrinhos/TelaMenu.dart';
import 'package:loja_carrinhos/data/service/user_auth_service.dart';
import 'package:loja_carrinhos/view/screens/cadastro_usuario.dart';
import 'package:loja_carrinhos/view/screens/menu_page.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_campo_texto.dart';
import 'package:toast/toast.dart';


class HomePage extends StatefulWidget {
  const HomePage({ Key key, this.title }) : super(key: key);
  final String title;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var ctrlLogin = TextEditingController();
  var ctrlSenha = TextEditingController();
  var formState = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> globalState = new GlobalKey<ScaffoldState>();
  UserAuthService userAuth = new UserAuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalState,
      appBar: AppBar(
        title: Text("efetuar login"),

      ),
      body: Container(
        padding: EdgeInsets.all(30),
        child: Form(
          key: formState,
          child: Column(
            children: [
              WcampoTexto(variavel: ctrlLogin, rotulo: "Login",senha: false,validator: (value){
                if(value.length == 0){
                  return "Entre com um email valido";
                } else{
                  return null;
                }
              },), 
              WcampoTexto(variavel: ctrlSenha, rotulo: "Senha",senha: true,validator: (value){
                if(value.length == 0){
                  return "Entre com um email valido";
                } else{
                  return null;
                }
              },),
              GestureDetector(
                child: WBotao(rotulo: "Entrar"),
                onTap: (){
              login();
              },
              ) ,
              SizedBox(
                height: 20,
              ),
              
              GestureDetector(
                child: WBotao(rotulo: "Cadastrar"),

                onTap: (){
              cadastro();
                 },
              )
              
            ],
            
          ),
        ),
      ),
    );
  }

  Future<void> login() async {
  if(formState.currentState.validate()){
    String result = await userAuth.login(ctrlLogin.text, ctrlSenha.text);
    if(result == "login efetuado com sucesso"){
      formState.currentState.reset();
      
      Toast.show(result, context, duration: Toast.LENGTH_LONG,
       gravity: Toast.BOTTOM, backgroundColor: Colors.green);
      Navigator.push(
        context, 
        PageRouteBuilder(
          transitionDuration: Duration(milliseconds: 100),
          pageBuilder: (_ , __ , ___) => MenuPage()));
    }else{
      formState.currentState.reset();

      Toast.show(result, context, duration: Toast.LENGTH_SHORT,
       gravity: Toast.BOTTOM, backgroundColor: Colors.red);
    }
  } else{
    //para testes sem exigir login
   /*  Navigator.push(context,
     PageRouteBuilder(
       transitionDuration: Duration(milliseconds: 100),
       pageBuilder: (_ , __, ___) => MenuPage()));
     */
    print("Preencher formulario");
  }
}

Future<void> cadastro() async {
   Navigator.push(
                    context, PageRouteBuilder(
                      transitionDuration: Duration(milliseconds: 100),
                      pageBuilder: (_ , __ , ___) => CadastroUsuaruio() ));
                  
}
}

