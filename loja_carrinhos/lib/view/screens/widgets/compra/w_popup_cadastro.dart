import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_lista_prod_cad.dart';

// ignore: must_be_immutable
class WpopupCadastro extends StatefulWidget {
  String title;
  String content;
  
   WpopupCadastro({ Key key, this.title, this.content}) ;

  @override
  State<WpopupCadastro> createState() => _WpopupCadastroState();
}

class _WpopupCadastroState extends State<WpopupCadastro> {
  @override
  Widget build(BuildContext context)  {
    return AlertDialog(
        title: Text("Escolher produto clicando "),

        //Forma lista com cadastros ja realizados para verificar se ja esta salvo
        content: WlistaProdCad(),
        actions: [
          ElevatedButton(
            child: Text("Cadastrar Produto"),
            style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                             onPressed: (){
                               Navigator.popAndPushNamed(context, '/cadastroProduto');
                              
                             },
                           )
                         ],
                       );
    
  }
}