import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/m_menu.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_menu.dart';

class WMenuList extends StatelessWidget {
  final List<Menu> listMenu;
  const WMenuList({ Key key , this.listMenu });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GridView.count(
        crossAxisCount: 3,
        children: List.generate(listMenu.length, (i) {
         return Wmenu(menu: listMenu[i]);
        } ),),
      
    );
  }
}