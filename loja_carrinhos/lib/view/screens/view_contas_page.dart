import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';

class ViewContasPage extends StatefulWidget {
  final List<ListCashDB> viewContas;
  const ViewContasPage({ Key key, this.viewContas }) ;

  @override
  _ViewContasPageState createState() => _ViewContasPageState();
}

class _ViewContasPageState extends State<ViewContasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Consolidado"),
      ),

      body: Container(
        child: Column(
          children: List.generate(
            widget.viewContas.length, (index) {
              return Row(
                children: [
                  Text(widget.viewContas[index].title),
                  Text("${widget.viewContas[index].atual}"),
                  Text("${widget.viewContas[index].total}"),
                ],
              );
            }),
        ),
      ) ,
      
    );
  }
}