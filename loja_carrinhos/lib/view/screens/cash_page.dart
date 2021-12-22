import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_cash_list.dart';

class CashPage extends StatefulWidget {
  const CashPage({ Key key, String title });

  @override
  _CashPageState createState() => _CashPageState();
}

class _CashPageState extends State<CashPage> {
  CollectionReference listDB = FirebaseFirestore.instance.collection("listaCash");
 List<ListCashDB> listCash = [];
 StreamSubscription<QuerySnapshot> ouvidor;
 @override
  void initState(){
    super.initState();
    
    ouvidor?.cancel();

    ouvidor = listDB.snapshots().listen((res) {
     setState(() {
        listCash = res.docs.map((e) => ListCashDB.fromMap(e.id, e.data())).toList();
     });
     
    });
    
  }
 
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Movimento do caixa"),),

      body: Container(
        child: Column(
          children: <Widget> [
            WcashList(listCash: listCash,)
          ],
        )
      ),

    );
  }
}