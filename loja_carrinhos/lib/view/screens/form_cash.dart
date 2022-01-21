import 'package:flutter/material.dart';
import 'package:loja_carrinhos/data/connDataBase/writeData/write_movimento.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_numero.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_campo_texto.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_dropdown.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_datetime.dart';
import 'package:loja_carrinhos/view/shared/messages/dialogos/confirmar_dados.dart';
import 'package:loja_carrinhos/view/shared/messages/retornoEventos.dart';
import 'package:loja_carrinhos/view/shared/validation.dart';
import 'package:toast/toast.dart';


class FormCash extends StatefulWidget {
  final String title;
  final String inOrOut;
  const FormCash({ Key key , this.title, this.inOrOut  }) ;

  @override
  State<FormCash> createState() => _FormCashState();
}

//classe interna para setar a data vinda do widget wdatetime.dart


class _FormCashState extends State<FormCash> {
  var formKey = GlobalKey<FormState>();
  var dropBanco = WDropDown(selectedItem: "nenhum", selectList: "banco", );
  var dropPagamento = WDropDown(selectedItem: "nenhum", selectList: "pagamento",);

  var ctrlDetalhe = TextEditingController();
  var ctrlValor = TextEditingController();  
  var ctrlParcelas = TextEditingController();
  
  //construtor da classe data e selectRadio
  var dateTime = WDatetime();
  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Text("${widget.inOrOut}: ${widget.title} "),

         backgroundColor: widget.inOrOut == "Entrada" ? 
             Colors.green[200] :
             Colors.red[200],),
       

       body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Flexible(
            flex: 1,
            child: Column(
              children:<Widget> [
                 
                   Form(
                     key: formKey,
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                       children: [

                         Center(child: Text("Detalhar Movimento",
                         style: TextStyle(
                           fontWeight: FontWeight.bold,
                           color: Colors.black87
                         ),
                         ),),
                         dateTime,
                          WcampoTexto(rotulo: "Detalhe",senha: false,variavel: ctrlDetalhe,
                          validator:(String value) {
                            return Validation().campoTexto(value);
                          } ,),

                          WCampoNumero(rotulo: "Valor", variavel: ctrlValor, validator: (value) {
                             return Validation().campoMoeda(value);
                           },),
                           
                           WCampoNumero(rotulo: "Parcelas", variavel: ctrlParcelas, validator: (value) {
                             return Validation().campoNumero(value);
                           },),   
                           Center(child: Text("Forma Pagamento"),),
                           dropPagamento,
                           Center(child: Text("Bancos"),),
                           dropBanco
                       ],
                     )
                     ),
                Spacer(),
                 GestureDetector(
                   onTap: ()async{
                     if(formKey.currentState.validate()){
                       
                       List data = [] ;
                       Map<String , dynamic> map =  {
                           'valor' : ctrlValor.text ,
                           'detalhe':ctrlDetalhe.text,
                           'operacao': dropPagamento.selectedItem,
                           'banco': dropBanco.selectedItem,
                           'parcelas':double.tryParse(ctrlParcelas.text),
                           'status' : widget.inOrOut
                         } ;
                      data.add(map);                      
                      Map mapToMsg = map;
                      mapToMsg['data'] = dateTime.data;
                     var result = await showDialog(                       
                       context: context, builder: (context)=>ConfirmarDados(mapCash: mapToMsg , title: "Confirmar Dados",));
                     
                     if(result[0]){
                         String writeDados = await WriteMovimento().writeDados(categoria: widget.title,  lista: data, data: dateTime.data);
                    
                     Toast.show(
                       writeDados,context,duration: Toast.LENGTH_LONG, backgroundColor: writeDados==RetornoEventos().salvo?
                        Colors.green :
                        Colors.red);

                     Navigator.of(context).pop();
                     } 
                   
                     }
                   
                   },
                  child: WBotao(rotulo: "Enviar",))
              ],
            ),
          ),
         ),
     );
  }
}
 
  

