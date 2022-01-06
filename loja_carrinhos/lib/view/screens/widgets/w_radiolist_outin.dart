import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/form_cash.dart';

// ignore: must_be_immutable
class WRadioListInOut extends StatefulWidget {
  
  WRadioListInOut({ Key key }) ;

  @override
  State<WRadioListInOut> createState() => _WRadioListInOutState();
}

class _WRadioListInOutState extends State<WRadioListInOut> {
  int selectedRadio = 0;

  

  @override
  Widget build(BuildContext context) {    
    
    return Container(
      
      child: Column(

        children: [
          selectedRadio == 1 ? 
          Icon(Icons.arrow_upward_rounded , color: Colors.green, size: MediaQuery.of(context).size.width / 4,):
          selectedRadio == 2 ? 
          Icon(Icons.arrow_downward_outlined, color: Colors.red, size: MediaQuery.of(context).size.width / 4):
          Icon(Icons.help_rounded, color: Colors.yellow, size: MediaQuery.of(context).size.width / 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              
               Container(
                 width: MediaQuery.of(context).size.width / 3,
                 height: MediaQuery.of(context).size.height / 10,
                 child: RadioListTile(
                   
                   title: Text("Entrada"),
                     value: 1,
                     groupValue: selectedRadio,                     
                     onChanged: (val){
                       setState(() {
                         selectedRadio = val;
                         
                          print(selectedRadio);                         
                          
                       });

                     },

                   ),
               ),
                   Container(
                     width: MediaQuery.of(context).size.width / 3,
                     height: MediaQuery.of(context).size.height / 10,
                     child: RadioListTile(
                       title: Text("Saida"),
                     value: 2,
                     groupValue: selectedRadio,
                     
                     onChanged: (val){
                       setState(() {
                         selectedRadio = val;
                         

                         print(selectedRadio);
                         
                       });

                     },


                 ),
                   ),
                

            ],
          ),
        ],
      ),
    );
  }
}