import 'package:flutter/material.dart';

// ignore: must_be_immutable
class WDialogs extends StatefulWidget {
  String title;
  String content;
  
   WDialogs({ Key key, this.title, this.content,}) ;

  @override
  State<WDialogs> createState() => _WDialogsState();
}

class _WDialogsState extends State<WDialogs> {
  @override
  Widget build(BuildContext context)  {
    return AlertDialog(
      title: Text(widget.title) ,
      content: Text(widget.content),

      actions: [],
    );
    
  }
}