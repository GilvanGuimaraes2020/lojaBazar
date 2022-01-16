import 'package:flutter/material.dart';
import 'package:loja_carrinhos/control/normalizaBanco/trata_dados.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_datetime.dart';

class NormalizaBanco extends StatefulWidget {
  const NormalizaBanco({ Key key }) ;

  @override
  _NormalizaBancoState createState() => _NormalizaBancoState();
}

class _NormalizaBancoState extends State<NormalizaBanco> {
  WDatetime datetime = new WDatetime();
  var antigoControl = TextEditingController();
  var novoControl = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Normaliza Banco"),
      ),
      
      body: Container(
        child: Column(
          children: [
            datetime,
            Container(
              child: TextField(
                
                controller: antigoControl,
              ),
            ),
            Container(
              child: TextField(
                
                controller: novoControl,
              ),
            ),
            GestureDetector(
              onTap: (){
                TrataDados().dadosAntigo(datetime.data);
              },
              child: WBotao(rotulo: "Buscar",),
            )
          ],
        ),
      ),
    );
  }
}