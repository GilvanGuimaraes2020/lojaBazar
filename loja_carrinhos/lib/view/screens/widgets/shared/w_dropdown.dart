import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WDropDown extends StatefulWidget {
  String selectedItem;
  String selectList;
  WDropDown({ Key key, this.selectedItem, this.selectList }) ;

  @override
  _WDropDownState createState() => _WDropDownState();
}

class _WDropDownState extends State<WDropDown> {
  String dropValue = "nenhum";
  List<String> operacao = ["nenhum", "dinheiro", "credito", "transferencia", "maquina cartao"];
  List<String> banco = ["nenhum", "santander", "bradesco", "nubank", "caixa federal", "sumup"];

  
  @override
  Widget build(BuildContext context) {
    
    List<String> drop = [];
    if (widget.selectList == "operacao"){drop = operacao;} else {drop = banco;}
     
    return Container(
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(6),
      child: Theme(
        data: Theme.of(context).copyWith(backgroundColor: Colors.grey),
        child: DropdownButton(
          value: dropValue,
          borderRadius: BorderRadius.circular(10),
          elevation: 30,
      
          isExpanded: true,
          items: drop
          .map<DropdownMenuItem<String>>((String e) {
            return DropdownMenuItem<String>
            (value: e,
            child: Text(e),);
          }).toList(), 
          onChanged: (String newValue){
            setState(() {
              dropValue = newValue;
              widget.selectedItem = dropValue;
            });
            
          }),
      ),
    );
  }
}