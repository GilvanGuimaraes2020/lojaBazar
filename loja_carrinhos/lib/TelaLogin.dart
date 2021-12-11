
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:projeto_p1_2/TelaListEquip.dart';





class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {


  var usuario = TextEditingController();
  var senhaUser = TextEditingController();
  
  bool userAcess = false;
  String userPass;
  String funcao;
  var dados = Map();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),

      body: SingleChildScrollView(
              child: Container(
          child: Column(
            children: [
              Container(
                
                child: ClipRRect(

                       borderRadius: BorderRadius.circular(10),
  
            child: Image.asset('images/UsuarioX.jpg' , scale: 2,) ,
           
            
   ) ),

              TextField(
                decoration: InputDecoration(
                  labelText: "Usuario",     
                  
                  ),
                  controller: usuario,
               
                ),
                SizedBox(height: 20,),
                TextField(
                  decoration: InputDecoration(
                    labelText: "Senha",

                  ),
                  controller: senhaUser,
                  obscureText: true,
                  onTap: (){
                    setState(() {
                     
                    });
                     
                   if (userAcess == false){
                       showDialog(context: context,
                                         builder: (context){
                                           return AlertDialog(
                                              title: Text("Usuario nao cadastrado"),
                                           );
                                         });
                   }
                   print(userPass + " " + funcao);

                   },
                  
                  
                ),
                SizedBox(height: 20,     ),
               
                Align(
                  alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      ElevatedButton(
                        child: Text("Entrar"),
                        onPressed: (){
                           setState(() {
                            if (userPass == senhaUser.text){
                              print('Senha correta');
                              dados['usuario'] = usuario.text;
                              dados['senha'] = senhaUser.text;
                                                         

                              Navigator.pushNamed(context, '/telaMenu' , arguments: dados);
                            } else{
                              print('senha incorreta');
                            }

                          });
                        },
                      ),
                      
                      ElevatedButton(
                        child: Text("Sair"),
                        onPressed: (){
                          bool controlOut = false;
                         setState(() {
                           showDialog(
                             context: context,
                             builder: (context) {
                               return AlertDialog(
                                 title: Text("Sair do Login"),
                                 content: Text("Tem Certeza que deseja Sair?"),
                                 actions: [
                                   ElevatedButton(
                                     child: Text("Sim"),
                                     onPressed: (){
                                       controlOut = true;
                                     },
                                   ),
                                   ElevatedButton(
                                      child: Text("Não"),
                                     onPressed: (){
                                       controlOut = false;
                                     },
                                   )

                                 ],
                                  
                               );
                             },
                           );
                           
                         });
                        if (controlOut == true){
                          Navigator.of(context).pop();
                        }
                      },
                      )
                    ],
                  ),
                )
            ],
              )
            
          ),
      ),

      
      backgroundColor: Colors.brown[200],
    );
  }
}