import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';

import 'package:loja_carrinhos/Models.dart';

class Menu extends StatefulWidget {
  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  List<AlertaLista> listaAlerta = [];
  bool existeAlerta = false;
  var listaAlertaBanco = FirebaseFirestore.instance.collection("alertas");

  @override
  void initState(){
    super.initState();
    listaAlertaBanco.where('status' , isEqualTo: true).
    where('dataPrevista',isLessThan: DateTime.now().add(Duration(days: 60))).get().
    then((value) {
      setState(() {
        listaAlerta = value.docs.map((e) => AlertaLista.fromMap(e.id, e.data())).toList();
      });
      
    });

    if (listaAlerta.length >0) existeAlerta = true;
    print(existeAlerta);
  }

  Widget corpoMenu(){

    
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(

          image: DecorationImage(
          image: AssetImage('images/artigosInfantis.jpg'),
          fit: BoxFit.contain,
          ),
          

        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Container(
              child: ElevatedButton(
    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
    //foregroundColor: MaterialStateProperty.all(value)
  ),
                   child: Text('Cad Prod'),
                    onPressed: (){
                       Navigator.pushNamed(context, '/cadastroProduto');
                    },
                  ),
                ),
                Container(
                  child: ElevatedButton(
                  
                   style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                    child: Text('Cad Cli'),
                    onPressed: (){
                       Navigator.pushNamed(context, '/telaCadastroCliente');
                    },
                  ),
                ),
                // container relacionado à agenda
               /*
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                   child: Text('Agenda'),
                    onPressed: (){
                       Navigator.pushNamed(context, '/agendamento');
                    },
                  ),
                ),
             */
             Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                   child: Text('Estq'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/telaEstoque');
                    },
                  ),
                ),  
                ],


            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [  

                //Container relacionado a ver agenda              
               /*
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                    child: Text('V agenda'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/agenda');
                    },
                  ),
                ),
                */
                
                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                    child: Text('Simular'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/simularVenda');
                    },
                  ),
                ),
             Container(
                  child: ElevatedButton(
                   style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                   child: Text('Vender'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/realizarVenda');
                    },
                  ),
                ),

                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                   child: Text('Comprar'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/realizarCompra');
                    },
                  ),
                ), 
                 ],

            ), 
           /*  Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
               

               
              ],

            ), */
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: ElevatedButton(
                   style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                    child: Text('Relat'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/relatorio');
                    },
                  ),
                ),
 Container(
                  child: ElevatedButton(
                   style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                    child: Text('Coment'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/comentario');
                    },
                  ),
                ),
              /*   Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                    child: Text('Teste'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/teste');
                    },
                  ),
                ), */

                Container(
                  child: ElevatedButton(
                    style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return Colors.brown; // Use the component's default.
      },
    ),
  ),
                    child: Text('Caixa'),
                    onPressed: (){
                      Navigator.pushNamed(context, '/caixa');
                    },
                  ),
                ),
              ],
            ), 
  Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      ElevatedButton(  
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) 
          { if(states.contains(MaterialState.pressed))
          return Colors.green;
          return Colors.brown;
          })
        ),      
        onPressed: (){
          Navigator.pushNamed(context, "/vendaFutura");
        }, 
        child: Row(
          children: [
            Icon(Icons.alarm),
            Text("Alerta Futuro")
          ],
        ))
         //Text("Alerta Futuro"))
    ],
  )

          ],
        ),
      );
  }



  @override
  Widget build(BuildContext context) {
   if (existeAlerta){
     return Scaffold(
       appBar: AppBar(
         title: Center(child: Text("Alerta de Venda"),),

       ),
       body: Container(
         padding: EdgeInsets.all(10),
         
         child: Column(
           mainAxisAlignment: MainAxisAlignment.spaceAround,
           children: [
             
             Center(
               child: Text("...Há possiveis vendas em sua lista futura...",
               
               style: TextStyle(
                 fontFamily: 'Zen Tokyo Zoo',
                 fontSize : 18,
                 color: Colors.red
               ), 
               ),
             ),
             
             Row(
               mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 Expanded(
                   child: ElevatedButton(
                     style: ButtonStyle(
                       backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if(states.contains(MaterialState.pressed))
                          return Colors.green;
                          return Colors.blue;                  
                       }),
                       
                     ),
                     onPressed: (){
                       setState(() {
                         existeAlerta = false;
                       });
                     }, 
                     child: Text("MENU")),
                 ),
               ],
             ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Expanded(
                     child: ElevatedButton(
                      
                      style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
                        if(states.contains(MaterialState.pressed))
                        return Colors.green;
                        return Colors.blue;
                      }),
                      fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(double.infinity))
                      ),
                     onPressed: (){
                       setState(() {
                         existeAlerta = false;
                       });
                       Navigator.pushNamed(context, '/telaAlerta');
                     }, 
                     child: Text("VER LISTA")),
                   ),
                 ],
               ),

           ],
         ),
         ),
       
     );
   } else{
      return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Menu")),
      ),

      backgroundColor: Colors.blue[100],

      body: 
      corpoMenu() ,
    );
  }
   }
   
}

