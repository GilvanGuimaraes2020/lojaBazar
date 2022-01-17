

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/m_menu.dart';
import 'package:loja_carrinhos/view/screens/routes/routes.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_menu_list.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({ Key key, String title, String login }) ;

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  List<Menu> listMenu = [];

  @override
  void initState(){
    super.initState();

      Menu menu1 = new Menu(name: "cliente" , icon: Icons.person_add );
      listMenu.add(menu1);
       Menu menu2 = new Menu(name: "produto", icon: Icons.child_friendly );
      listMenu.add(menu2);
       Menu menu3 = new Menu(name: "estoque", icon: Icons.storage_outlined );
      listMenu.add(menu3);
       Menu menu4 = new Menu(name: "simular", icon: Icons.calculate );
      listMenu.add(menu4);
       Menu menu5 = new Menu(name: "vender" , icon: Icons.monetization_on );
      listMenu.add(menu5);
       Menu menu6 = new Menu(name: "comprar", icon: Icons.add_shopping_cart  );
      listMenu.add(menu6);
       Menu menu7 = new Menu(name: "relatorio" , icon: Icons.addchart );
      listMenu.add(menu7);
       Menu menu8 = new Menu(name: "comentario", icon: Icons.comment );
      listMenu.add(menu8);
       Menu menu9 = new Menu(name: "caixa", icon: Icons.point_of_sale);
      listMenu.add(menu9);
       Menu menu10 = new Menu(name: "alerta" , icon: Icons.notification_important);
      listMenu.add(menu10);
       Menu menu11 = new Menu(name: "fotos" , icon: Icons.photo_camera);
      listMenu.add(menu11);

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: (){
            return showDialog(context: context, 
            builder: (context){
              return AlertDialog(
                title: Text("Sair do APP"),
                content: Text("Tem certeza que deseja sair ?"),
                actions: [
                  ElevatedButton(onPressed: (){
                    FirebaseAuth.instance.signOut();
                    Routes route = new Routes(route: "logout" , context: context);
                    route.changeRoute();
                  }, 
                  child: Text("Sim")),
                  ElevatedButton(onPressed: (){
                    Navigator.of(context).pop();
                  }, 
                  child: Text("Nao"))

                ],
              );
            });          
          },),
          ),
        body: Container(
          padding: EdgeInsets.all(30),
          child: Column(
            children:        
            
             <Widget>[
            WMenuList(listMenu: listMenu)
          ],
          )
          
        ),
    );
  }
}