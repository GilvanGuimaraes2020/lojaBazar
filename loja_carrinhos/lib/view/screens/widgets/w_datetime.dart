import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_dialog_cash.dart';
import 'package:toast/toast.dart';

// ignore: must_be_immutable
class WDatetime extends StatefulWidget {
  
  
  DataRadio data_radio;
  WDatetime({ Key key,   this.data_radio});

  @override
  _WDatetimeState createState() => _WDatetimeState();
}

class _WDatetimeState extends State<WDatetime> {
  DateTime data;
  @override
  Widget build(BuildContext context) {
      
    return Container(

      //width: MediaQuery.of(context).size.width,
      child: Column(
        
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            //padding: EdgeInsets.symmetric(horizontal: 20),
            child: GestureDetector(

              onTap: ()async{
                if (widget.data_radio.selectRadio == 1 || widget.data_radio.selectRadio == 2){
                   data = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), 
                firstDate: DateTime(2018),
                 lastDate: DateTime(2030),
                 
                 builder: (context, child) => Theme(data: ThemeData.dark(), child: child),               
                 );

                 setState(() {
                   data;
                   
                   widget.data_radio.data = data;
                   
                 });
                } else {
                  Toast.show("Necessario escolher categoria acima", context,
                  duration: Toast.LENGTH_LONG,gravity: Toast.BOTTOM ,backgroundColor: Colors.red);
                }
               
            }, 
            child: WBotao(rotulo: data==null?
            "Escolher Data":
            DateFormat("dd/MM/yyyy").format(data),)
             ),
                    
                    ),
          
          
          
        ],
      ),

      
    );
  }
}