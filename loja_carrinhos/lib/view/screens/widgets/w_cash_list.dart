import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_cash.dart';

import '../models/modelsOfDB/m_DB_listCash.dart';

class WcashList extends StatelessWidget {
  final List<ListCashDB> listCash;

  const WcashList({Key key, this.listCash});

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
        status: listCash[i].status,
        input: listCash[i].inputValue,
        output: listCash[i].outputValue);
      }),
         )
      
    );
  }
}