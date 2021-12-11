import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ParametroContas extends StatefulWidget {
  @override
  _ParametroContasState createState() => _ParametroContasState();
}

class _ParametroContasState extends State<ParametroContas> {
  var bradescoCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Setar Contas"),
      ),
      body: Container(
        child: Row(
          children: [
            Container(
              child: Column(
                children: [
                  Center(
                    child: Text('Valor Anterior'),

                  ),
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Bradesco'
                    ),
                    controller: bradescoCtrl,
                  )
                ],
              ),
            ),
            Container(

            )
          ],
        ),
      ),
    );
  }
}