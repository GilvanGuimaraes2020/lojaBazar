import 'package:flutter/material.dart';

class WDropDown extends StatefulWidget {
  const WDropDown({ Key key }) ;

  @override
  _WDropDownState createState() => _WDropDownState();
}

class _WDropDownState extends State<WDropDown> {
  String dropValue = "Selecione";
  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: dropValue,
        
        items: <String>["Selecione", "Santander"]
        .map<DropdownMenuItem<String>>((String e) {
          return DropdownMenuItem<String>
          (value: e,
          child: Text(e),);
        }).toList(), 
        onChanged: (String newValue){
          setState(() {
            dropValue = newValue;
          });
          
        }),
    );
  }
}