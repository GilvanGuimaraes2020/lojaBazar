
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loja_carrinhos/AtualizaCaixa.dart';
import 'package:loja_carrinhos/Models.dart';
import 'package:loja_carrinhos/view/screens/widgets/compra/w_popup_cliente.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/w_datetime.dart';
import 'package:loja_carrinhos/view/screens/widgets/compra/w_popup_cadastro.dart';

class CompraPage extends StatefulWidget {
  @override
  _CompraPageState createState() => _CompraPageState();
}

class _CompraPageState extends State<CompraPage> {

  var nomeControl = TextEditingController();
  var produtoControl = TextEditingController();
  Icon icon = Icon(Icons.search);
  var valorControl = TextEditingController();
  var codClienteControl = TextEditingController();
   var codProdControl = TextEditingController();
   var corControl = TextEditingController();
   var qtdFormaPag = TextEditingController();
   var pag1Ctrl = TextEditingController();
   var pag2Ctrl = TextEditingController();

   var _scaffoldKey = GlobalKey<ScaffoldState>();
   DateFormat formatter = DateFormat("yyyy-MM-dd");
   DateTime data;
   int numCodigo = 0;
   var dropPagamento = WDropDown(selectedItem: "nenhum", selectList: "pagamento",);
   var dropBanco = WDropDown(selectedItem: "nenhum", selectList: "banco");
   var dropSexo = WDropDown(selectedItem: "nenhum",selectList: "sexo");
   var dataTime = WDatetime();
  String sexo = "Unissex";
   
   var db = FirebaseFirestore.instance;

   List<Clientes> cliente = [];
    List pagAlternativo = [];

 String transf = "Selecione o Banco";
 
  //*******************Funçao para formar a lista dos produtos cadastrados********** */



//**************Widget para apresentar showdialog do produtos***************** */

     
// Traz lista dos clientes com cadastro no banco 
 
  
//Salva no banco clientes que ainda nao possuem cadastro
  salvarCadastroCliente(List<String> salvaCliente){
    /* dbCliente.collection('clientes').add({
      'codigo' : (numCodigo +1 ).toString(),
      'nome' : salvaCliente[0],
      'telefone' : salvaCliente[1],
      'endereco' : salvaCliente[2],
      'bairro' : salvaCliente[3]
    }); */
    print("criar funçao externa");

  }

void openDrawer(){
  _scaffoldKey.currentState.openDrawer();
}


  @override
  Widget build(BuildContext context) {
  
//Apos comparar na lista, gera pop-up para inserir dados para cadastro
     
    

//******************Inicio do retorno de builder******************************* */
    return Scaffold(
      appBar: AppBar(
        title: Text("Realizar Compra"),
        leading: IconButton(onPressed: (){
          Navigator.of(context).pop();
        }, icon: Icon(Icons.arrow_back)
        ),
         
      ),

      key: _scaffoldKey,
      
      body: SingleChildScrollView(
              child: Container(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [

 //Campo para inserir nome do cliente           
             WcampoTexto(rotulo: "Nome Cliente", 
             senha: false, variavel: nomeControl,
             icon: IconButton(onPressed: ()async{
               var popCliente = WpopupCliente(name: nomeControl.text);
               await showDialog(
                     context: context,
                     builder: (context) {
                       return popCliente;
                     },
                   );
                   print(popCliente.codCliente);
              setState(() {
                nomeControl.text = popCliente.name;
                icon = popCliente.codCliente == null ? Icon(Icons.thumb_down , color: Colors.red,):
                Icon(Icons.thumb_up_alt,color: Colors.green,);
              });

             }, icon: icon), 
             ), 
                
 //Campo para inserir endereço. Chama funçao para verificar se ja ha existencia de cadastro           
           
 
//Campo para inserir nome produto. Chama pop-up para escolha de produto ou cadastro de novo produto
             TextField(
               decoration: InputDecoration(
                 labelText: 'Produto'
               ),
               controller: produtoControl,
onTap: (){
  if (codProdControl.text == ""){
    return showDialog(
                     context: context,
                     builder: (context) {
                       return WpopupCadastro();
                     },
                   );
   
  }
},
             ),

 //Campo para inserir cor ou detalhe do produto            
            WcampoTexto(rotulo: "cor ", senha: false,
            variavel: corControl,),

//Apresenta opçoes para o sexo do produto             
             dropSexo,

 //Campo para inserir valor do produto            
              WcampoTexto(rotulo: "valor", senha: false,
              variavel: valorControl,),
             
 //calendario para escolher data
      dataTime,

//Apresenta opçoes para o tipo de pagamento
      dropPagamento,

  //Opçao quando pagamento for alternativo
                            Visibility(
                              visible: dropPagamento.selectedItem =="Pagamento Alternativo",
                              child: TextField(
                                decoration: InputDecoration(
                                  labelText: 'Quantas formas de pagamento'
                                ),
                                keyboardType: TextInputType.number,
                                controller: qtdFormaPag,
                                onChanged: (String qtdPag){
                                 

                                  if (qtdPag == '2'){
                                   openDrawer();
                                  }
                                },
                              )),
             
//Apresenta seleçao de bancos, caso tipo de pagamento seja = transferencia            
             Visibility(
               visible: dropPagamento.selectedItem == "transferencia",
               child:   dropBanco,
             ),
             
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 ElevatedButton(
                  child: Text("Salvar"),
                  style: ButtonStyle(
    backgroundColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.pressed))
          return Colors.green;
        return null; // Use the component's default.
      },
    ),
  ),
                  onPressed: () {
                    
                   // DateFormat formatter = DateFormat('yyyy-MM-dd');

//condicional que verifica se todos os requisitos foram preenchidos
                    if(codClienteControl.text!="" && codProdControl.text != "" && 
                    data!=null && dropPagamento.selectedItem!="Selecione forma de Pagamento"){

               
                        db.collection('estoque').add({
                      'codCliente' : codClienteControl.text,
                      'codProduto' : codProdControl.text,
                      'corProduto' : corControl.text,
                      'sexoProduto' : sexo,
                      'resCliente' : nomeControl.text,
                      'resProduto' : produtoControl.text,
                      'valor' : valorControl.text,
                      'status' : "1",
                      'data' : data
                    }); 
                      
int contItemCaixa = 0;

//listaIDCaixa é formado no initState com os dados das transaçoes no banco 
/* for (final e in listaIdCaixa){
  //Verifica se o ano-mes esta contido no banco
  if(e.id.contains("${data.year}-${data.month}")){
    Map mapDadosCaixa = e.dias[data.day.toString()]; //Coleta o map do dia especifico
    print(mapDadosCaixa);
  // verifica se este map esta vazio
    if(mapDadosCaixa!=null){
      mapDadosCaixa.forEach((key, value) {
         print(key);
 //verifica quantas vezes teve ocorrencia de compra naquele dia
if( key.toString().substring(0 , 5) == "compr"){
  contItemCaixa++;
  print( contItemCaixa);
}
        });
        break;
    }
}
} */
                    if(pagAlternativo.length>0){
                      for (int i =0; i<2; i++){
                        if (i == 1) {
                          contItemCaixa = contItemCaixa + 1;
                          i = 3;
                        }
                      AtualizaCaixa.compra ( data,  pagAlternativo[i + 2], "s" ,
                    "compraItemPA", pagAlternativo[i + 1] ,pagAlternativo[i],produtoControl.text, contItemCaixa);  
                      }
                    }else{
                       AtualizaCaixa.compra ( data,  valorControl.text, "s" ,
                    "compraItem", dropBanco.selectedItem ,dropPagamento.selectedItem,produtoControl.text, contItemCaixa); 
                    }
                     
                      
                      Navigator.pop(context);
                      

                    } else{
                      return showDialog(
                        context: context,
                        builder: (context){
                          return AlertDialog(
                            title: Text("Falta Informaçoes"),
                            content: Text("Verificar se todas as informaçoes foram preenchidas"),
                            actions: [
                              ElevatedButton(
                                child: Text("ok"),
                                onPressed: (){
                                  Navigator.pop(context);
                                },
                              )
                            ],
                          );
                        }
                        
                        
                                              );
                    }
                  },
                 ),
                 
               ],
             )
            ],
          ),

        ),
      ),

    backgroundColor: Colors.brown[100],
drawer: Drawer(
  child: Scaffold(
    appBar: AppBar(
      title: Text("Pagamento Alternativo"),
    ),
    body: Column(
      children: [
      

          TextField(
            decoration: InputDecoration(
             labelText: 'Valor pago em dinheiro'
            ),
            controller: pag1Ctrl,
            keyboardType: TextInputType.number,            
          ),
        

             DropdownButton(
              
                 value: transf,
                 items:<String> ["Selecione o Banco","Bradesco" , "Santander", "Caixa", "Nubank", "Outro"]
                 .map<DropdownMenuItem<String>>((String value){
                   return DropdownMenuItem<String>(
                     value: value,
                     child: Text(value, style: TextStyle(fontSize: 14),),
                   );
                 }).toList(),
                 isExpanded: true,
                 onChanged: (String newValue){
                   setState(() {
                     transf = newValue;
                     pag2Ctrl.text = (double.tryParse(valorControl.text) - double.tryParse(pag1Ctrl.text)).toString();
                  
                   });
                 },
               ),
        TextField(
          decoration: InputDecoration(
            labelText: 'Valor pagamento 2'
          ),
          enabled: false,
          controller: pag2Ctrl,
        ),

        ElevatedButton(
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
            setState(() {
             pagAlternativo.add("Dinheiro");
             pagAlternativo.add(dropBanco.selectedItem);//igualar os laços ate encontrar maneira mais adequada
             pagAlternativo.add(pag1Ctrl.text);
             pagAlternativo.add("Transferencia");
             pagAlternativo.add(transf);
             pagAlternativo.add(pag2Ctrl.text);
                  print(pagAlternativo.length);  
                  Navigator.pop(context);

            });
           


          }, child: Text("OK"))
        


      ],
    ),
  ),
),
    );
  }
}