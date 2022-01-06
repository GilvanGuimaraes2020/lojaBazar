import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_lista_prod_cad.dart';

// ignore: must_be_immutable
class WpopupCadastro extends StatefulWidget {
  
   WpopupCadastro({ Key key}) ;

  @override
  State<WpopupCadastro> createState() => _WpopupCadastroState();
}

class _WpopupCadastroState extends State<WpopupCadastro> {
 var wProduto = WlistaProdCad();
  @override
  Widget build(BuildContext context)  {
    
    return AlertDialog(
        title: Text("Escolher produto "),

        //Forma lista com cadastros ja realizados para verificar se ja esta salvo
        content: wProduto,
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