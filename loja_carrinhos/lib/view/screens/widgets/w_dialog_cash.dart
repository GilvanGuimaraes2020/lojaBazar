import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dialogs.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_numero.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_datetime.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_radiolist_outin.dart';
class WDialogCash extends StatefulWidget {
  final String title;
  const WDialogCash({ Key key , this.title }) ;

  @override
  State<WDialogCash> createState() => _WDialogCashState();
}

//classe interna para setar a data vinda do widget wdatetime.dart
class  DataRadio {
  DateTime data; 
  int selectRadio;
}

class _WDialogCashState extends State<WDialogCash> {
  var formKey = GlobalKey<FormState>();
  
  var ctrlDetalhe = TextEditingController();
  var crtlValor = TextEditingController();  
  
  //construtor da classe data e selectRadio
  DataRadio dia_radio = new DataRadio();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("Categoria: ${widget.title} "),),
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
                 //WRadioListInOut(operacao: dia_radio,),
                 
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
 
  

