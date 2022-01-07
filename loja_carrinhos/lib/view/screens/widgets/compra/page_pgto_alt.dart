import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_numero.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dialogs.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:toast/toast.dart';

class PagePgtoAlt extends StatefulWidget {
  final double totalCompra;
  final DateTime data;
  const PagePgtoAlt({ Key key, this.totalCompra, this.data });

  @override
  _PagePgtoAltState createState() => _PagePgtoAltState();
}

class _PagePgtoAltState extends State<PagePgtoAlt> {
  int contador = 1;
   List<TextEditingController> pagAltControl = [new TextEditingController() , new TextEditingController(), new TextEditingController()];
  List<WDropDown> dropAltPgto =[
    new WDropDown(selectedItem: "nenhum" , selectList: "pagamento",),
    new WDropDown(selectedItem: "nenhum" , selectList: "pagamento",),
    new WDropDown(selectedItem: "nenhum" , selectList: "pagamento",),  ] ;
  
  List<WDropDown> dropAltBanco =[
    new WDropDown(selectedItem: "nenhum" , selectList: "banco",),
    new WDropDown(selectedItem: "nenhum" , selectList: "banco",),
    new WDropDown(selectedItem: "nenhum" , selectList: "banco",),  ] ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pagamento Alternativo"),),
        body: Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black)              
          ),
          child: SingleChildScrollView(
            child: Column(            
              children:List.generate(3, (index){
                return Container(
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.all(5),
                  
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.blue[100],
                  ),
                  child: Column(
                    children: [
                      Text("Tipo Pagamento ${index + 1}"),
                      dropAltPgto[index],
                      Text("Destino Pagamento ${index + 1}"),
                      dropAltBanco[index],
                      WCampoNumero(rotulo: "valor",
                      variavel: pagAltControl[index],
                      ),
                      
                    ],
              ),
                );
              }),
          
             
            ),
          )

        ),
        backgroundColor: Color.fromARGB(255, 236, 182, 162),
        persistentFooterButtons: [
          GestureDetector(
            onTap: (){
              double soma= 0;
              List page = [];
              for (var i = 0; i < 3; i++) {
                if (pagAltControl[i].text != ""){
                  page.add({
                  "banco" :dropAltBanco[i].selectedItem,
                  "operacao":dropAltPgto[i].selectedItem,
                  "valor":double.tryParse(pagAltControl[i].text)
                }); 
                soma = soma + double.tryParse(pagAltControl[i].text);
                }                
               
              }
              print(soma);
              if (widget.totalCompra == soma){
                Navigator.pop(context , page);
              } else{
                print("valores nao batem");
                Toast.show("Soma dos valores nao batem", context, duration: Toast.LENGTH_LONG, backgroundColor: Colors.red);

              }
              
              
            },
            child: WBotao(rotulo: "Seguir",),
          )
        ],
    );
      
  }
}