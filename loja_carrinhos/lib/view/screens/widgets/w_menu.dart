import 'package:flutter/material.dart';
/* import 'package:loja_carrinhos/TelaCadastroCliente.dart';
import 'package:loja_carrinhos/comentarios.dart';
import 'package:loja_carrinhos/data/creditSimulation/TelaSimulacaoVenda.dart';
*/
import 'package:loja_carrinhos/view/screens/models/m_menu.dart';
import 'package:loja_carrinhos/view/screens/routes/routes.dart';
 
class Wmenu extends StatelessWidget {
  final Menu menu;
  const Wmenu({ Key key , this.menu }) ;
  

  @override
  Widget build(BuildContext context) {
    
    return InkWell(
      focusColor: Colors.green[300],
      onTap: (){
        
       Routes route = 
       new Routes(route: menu.name , context: context) ;      
       route.changeRoute();
      
      },
      child: Hero(tag: menu.name, 
      child: Container(
        margin: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height/4,
        width: MediaQuery.of(context).size.width / 3,
        decoration: BoxDecoration(
          color: Colors.green[200],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow:[
            BoxShadow(
              color: Colors.black,
              blurRadius: 4,
              offset: Offset(2 , 4)
          )
          ] 
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(menu.icon, size: MediaQuery.of(context).size.height / 15, ), 
            Container(
              child: Text(menu.name,
              style: TextStyle(
                color: Colors.black,
                fontSize: MediaQuery.of(context).size.height / 60),),
            )

          ],),
      )),
    );
  }
}