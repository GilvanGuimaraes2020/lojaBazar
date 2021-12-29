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
      margin: EdgeInsets.all(2),
      padding: EdgeInsets.all(6),
      child: Theme(
        data: Theme.of(context).copyWith(backgroundColor: Colors.grey),
        child: DropdownButton(
          value: dropValue,
          borderRadius: BorderRadius.circular(10),
          elevation: 30,
      
          isExpanded: true,
          items: <String>["Selecione", "Santander", "Bradesco"]
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
      ),
    );
  }
}