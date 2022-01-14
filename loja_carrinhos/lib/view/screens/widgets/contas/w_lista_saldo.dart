import 'package:flutter/material.dart';

import '../../models/modelsOfDB/m_DB_listCash.dart';

class WListaSaldo extends StatefulWidget {
  final ListCashDB viewContas;
  const WListaSaldo({ Key key , this.viewContas });

  @override
  _WListaSaldoState createState() => _WListaSaldoState();
}

class _WListaSaldoState extends State<WListaSaldo> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.blue)),
        color: Colors.blue[100]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
        Text("${widget.viewContas.title}",),
        Text("${widget.viewContas.atual}",),
        Text("${widget.viewContas.total}",),
        ],
      ),
    );
  }
}