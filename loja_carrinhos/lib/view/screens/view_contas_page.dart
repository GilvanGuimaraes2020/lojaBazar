import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/models/modelsOfDB/m_DB_listCash.dart';
import 'package:loja_carrinhos/view/screens/widgets/contas/w_lista_saldo.dart';

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
          children: [
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.all(6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text("Alocado"),
                  Text("Saldo Mes"),
                  Text("Total")
                ],
              ),
            ),
            Divider(),
            Column(
              children: List.generate(
                widget.viewContas.length, (index) {
                  return WListaSaldo(viewContas: widget.viewContas[index],);
                }),
            ),
          ],
        ),
      ) ,
      
    );
  }
}