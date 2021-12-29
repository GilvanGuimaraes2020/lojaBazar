import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_numero.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_datetime.dart';


class FormCash extends StatefulWidget {
  final String title;
  final String inOrOut;
  const FormCash({ Key key , this.title, this.inOrOut  }) ;

  @override
  State<FormCash> createState() => _FormCashState();
}

//classe interna para setar a data vinda do widget wdatetime.dart
class  DataRadio {
  DateTime data; 
  int selectRadio;
}

class _FormCashState extends State<FormCash> {
  var formKey = GlobalKey<FormState>();
  
  var ctrlDetalhe = TextEditingController();
  var crtlValor = TextEditingController();  
  
  //construtor da classe data e selectRadio
  DataRadio dia_radio = new DataRadio();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("${widget.inOrOut}: ${widget.title} "),),
       body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          
          decoration: BoxDecoration(
            color: Colors.blue[100]
          ),
          child: Flexible(
            flex: 1,
            child: Column(
              children:<Widget> [
                widget.inOrOut == "Entrada" ? 
                  Icon(Icons.arrow_upward_outlined, color: Colors.green, size: MediaQuery.of(context).size.width / 7):
                  Icon(Icons.arrow_downward_outlined, color: Colors.red, size: MediaQuery.of(context).size.width / 7),
                 
                 WDatetime( data_radio: dia_radio, ),
                 Spacer(),
                 Container(
                   height: MediaQuery.of(context).size.height / 2,
                   margin: EdgeInsets.symmetric(horizontal: 10),
                   decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    color: Colors.grey[200]
                   ),
                   child: Form(
                     key: formKey,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [
                         Center(child: Text("Detalhar Movimento",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.black87
                         ),
                         ),),
                          WcampoTexto(rotulo: "Detalhe",senha: false,variavel: ctrlDetalhe,validator: (value){
                            if(value.length ==0){
                              return "Preencher campo";
                            } else{
                              return null;
                            }
                          },),
                           WCampoNumero(rotulo: "Valor", variavel: crtlValor, validator: (value) {
                             if(value.length != 0){
                               return null;
                             } else{
                               return "Preencher Campo";
                             }
                           },),
                           WDropDown()
                       ],
                     )
                     ),
                 ),
                Spacer(),
                 GestureDetector(
                   onTap: (){

                     DocumentReference docReference = FirebaseFirestore.instance.collection("MovimentoCaixa").doc("entradas").collection("2022-1").doc("combustivel");
                     
                     List data = [
                         {
                           'valor' : 400,
                           'detalhe':'Teste Salvamento 3',
                           'operacao':'teste operacao 3',
                           'banco':'teste banco 3',
                           'parcelas':3,

                         }
                       ] ;
                     
                     docReference.set({"5": FieldValue.arrayUnion(data) } , SetOptions(merge: true));
                     print(dia_radio.data);
                   },
                  child: WBotao(rotulo: "Enviar",))
              ],
            ),
          ),
         ),
     );
  }
}
 
  

