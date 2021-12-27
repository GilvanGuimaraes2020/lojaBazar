import 'package:flutter/cupertino.dart';

class Forms{
BuildContext context;
Forms({this.context});

double component(String componente){
  return MediaQuery.of(context).size.width;
}

}