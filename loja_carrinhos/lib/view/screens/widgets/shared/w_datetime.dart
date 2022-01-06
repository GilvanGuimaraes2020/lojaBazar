import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';


// ignore: must_be_immutable
class WDatetime extends StatefulWidget {
  DateTime data;
  
  WDatetime({ Key key });

  @override
  _WDatetimeState createState() => _WDatetimeState();
}

class _WDatetimeState extends State<WDatetime> {
  
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
               
                   widget.data = await showDatePicker(
                context: context,
                initialDate: DateTime.now(), 
                firstDate: DateTime(2018),
                 lastDate: DateTime(2030),
                 
                 builder: (context, child) => Theme(data: ThemeData.dark(), child: child),               
                 );

                 print(widget.data);

                 setState(() {
                   
                  widget.data;
                   
                 });
                
               
            }, 
            child: WBotao(rotulo: widget.data==null?
            "Escolher Data":
            DateFormat("dd/MM/yyyy").format(widget.data),)
             ),
                    
                    ),
          
          
          
        ],
      ),

      
    );
  }
}