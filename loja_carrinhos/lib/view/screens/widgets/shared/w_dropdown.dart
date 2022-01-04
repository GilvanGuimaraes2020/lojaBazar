import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/shared/messages/listas.dart';

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
  
  @override
  Widget build(BuildContext context) {  
    
    List<String> drop = ListsShared().selectList(widget.selectList);
    drop.add('nenhum');
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