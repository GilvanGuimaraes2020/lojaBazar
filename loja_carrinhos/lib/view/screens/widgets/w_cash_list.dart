import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_cash.dart';



class WcashList extends StatelessWidget {
  final List<ListCashDB> listCash;
  final Map<String , dynamic> map;

  const WcashList({Key key, this.listCash, this.map});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      flex: 1,
      child: GridView.count(
        crossAxisCount: 3,
        children: 
         List.generate(
      listCash.length  , (i){
        return Wcash(title: listCash[i].title,        
        total: listCash[i].total,
        );
      }),
         )
      
    );
  }
}