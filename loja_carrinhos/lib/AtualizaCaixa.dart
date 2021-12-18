//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class AtualizaCaixa  {

  DateTime data;
  String operacao;
  String valor;
  String tipoConta;
  String contaTransferencia ;
  String tipoPag ;
  String detalhe;
  String parcelas;
  String somaValor;


CollectionReference diario = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('48yPK84Rbpi307lcrUBq').collection('contasVariadas');

DocumentReference<Map> caixa = FirebaseFirestore.instance.collection('MovimentoCaixa').
 doc('ControleContas');

   void teste()async{

     print("entrou em Teste");
 
if (this.operacao == "s"){
  print("Operaçao de saida");
   if(this.tipoPag == "Dinheiro") {
                      double valorDinheiro;

                     

                    await   caixa.get().then((value) {
                        valorDinheiro =  value.data()['caixaDinheiro'];
                      });

                    

                        valorDinheiro = valorDinheiro - double.tryParse(this.valor);
                     print(valorDinheiro);                 
                     
                      await  caixa.update({
                          "caixaDinheiro" : valorDinheiro 
                        });

                         if(this.tipoConta == "emergencia"){
                           double valorConta;

                      if(somaValor=="Sim"){

                         await   caixa.get().then((value) {

                        
                        valorConta =  value.data()[this.detalhe];
                      });
                        valorConta = valorConta + double.tryParse(this.valor);
                      } else if(somaValor=="Nao"){

                        valorConta = double.tryParse(this.valor);
                      }

                       await  caixa.update({
                          this.detalhe : valorConta 
                        });


                      } else if(this.tipoConta == "reserva"){
                        print("entrou em reserva");
                      double valorConta;
                       await caixa.get().then((value) {
                        valorConta = value.data()[this.tipoConta];
                      });

                      valorConta = valorConta + double.tryParse(this.valor);
                      print(valorConta);

                       await caixa.set(
                        {
                          this.tipoConta : valorConta
                        }, SetOptions(merge: true)
                      );
                    }

                    }else if(this.tipoPag == "Transferencia" ){
                      Map<String , dynamic> dadoMes = Map();
                      double valorDinheiro;
                      String mes = "${data.year}-${data.month}";

                      await  caixa.get().then((value)  {
                        dadoMes =  value.data()[this.contaTransferencia];
                      });
                      
                      if(dadoMes[mes]!=null){
                        valorDinheiro = dadoMes[mes] - double.tryParse(this.valor);
                      } else{
                        valorDinheiro = 0-  double.tryParse(this.valor);
                      }
                        
                      


                     
                      await   caixa.set({
                          this.contaTransferencia : {mes: valorDinheiro} ,
                          
                        },SetOptions(merge: true));

                          await   caixa.set({
                         
                          this.contaTransferencia:{"total-${data.year}": 
                          (dadoMes["total-${data.year}"] - double.tryParse(this.valor))}
                        },SetOptions(merge: true));
        

                    }else if(this.tipoPag == "Troca Negociacao" ){
                                

                    } else if(this.tipoPag == "cartaoProprio"){
                       Map<String , dynamic> dadoMes = Map();
                      double valorDinheiro;
                      String mes = "${data.year}-${data.month}";

                      await  caixa.get().then((value)  {
                        dadoMes =  value.data()[this.tipoPag];
                      });

                       
                      if(dadoMes[mes]!=null){
                        valorDinheiro = dadoMes[mes] + double.tryParse(this.valor);
                      } else{
                        valorDinheiro = double.tryParse(this.valor);
                      }
                        
                      


                     
                      await   caixa.set({
                          this.tipoPag : {mes: valorDinheiro} ,
                          
                        },SetOptions(merge: true));

                          await   caixa.set({
                         
                          this.tipoPag:{"total-${data.year}": 
                          (dadoMes["total-${data.year}"] + double.tryParse(this.valor))}
                        },SetOptions(merge: true));
        

                    } else if(this.tipoPag == "Carteira Cis" || this.tipoPag == "Carteira Gil"){
                      print("Entrou em cartao cis ou gil");
                     double valorConta;
                     var valorCelConta;
                      await caixa.get().then((value) {
                        valorCelConta = value.data()[this.tipoPag];
                      });

                      valorConta = valorCelConta.toDouble() - double.tryParse(this.valor);
                      print("$valorConta");
                      await caixa.set(
                        {
                          this.tipoPag : valorConta
                        }, SetOptions(merge: true)
                      );
                    } else if(this.tipoPag == "Vale Alimentacao"){
                      print("Entrou Vale");
                      
                     double valorConta;
                      await caixa.get().then((value) {
                        valorConta = value.data()[this.tipoPag];
                      });

                      valorConta = valorConta + double.tryParse(this.valor);
                      print("$valorConta");
                      await caixa.set(
                        {
                          this.tipoPag : valorConta
                        }, SetOptions(merge: true)
                      );
                    } 
} else if(this.operacao == "e"){
  print("entrada de caixa");
   if(this.tipoPag == "Dinheiro") {
                      double valorDinheiro;

                    await   caixa.get().then((value) {
                        valorDinheiro =  value.data()['caixaDinheiro'];
                      });

                    

                        valorDinheiro = valorDinheiro + double.tryParse(this.valor);
                     print(valorDinheiro);                 
                     
                      await  caixa.update({
                          "caixaDinheiro" : valorDinheiro 
                        });

                    }else if(this.tipoPag == "Transferencia" ){
                      print("Entrou em entrada transferencia");

                      Map<String , dynamic> dadoMes = Map();
                      double valorDinheiro;
                      String mes = "${data.year}-${data.month}";

                      await  caixa.get().then((value)  {
                        dadoMes =  value.data()[this.contaTransferencia];
                      });
                      
                      if(dadoMes[mes]!=null){
                        valorDinheiro = dadoMes[mes] + double.tryParse(this.valor);
                      } else{
                        valorDinheiro = double.tryParse(this.valor);
                      }
                        
                      await   caixa.set({
                          this.contaTransferencia : {mes: valorDinheiro} ,
                          
                        },SetOptions(merge: true));

                          await   caixa.set({
                         
                          this.contaTransferencia:{"total-${data.year}": 
                          (double.tryParse(this.valor) + dadoMes["total-${data.year}"])}
                        },SetOptions(merge: true));

                    }
                    else if(this.tipoPag == "Maquina Cartao" ){
                      print("Entrada Maquina Cartao");
                      Map<String , dynamic> dadoMes = Map();
                      double valorDinheiro;
                      double valorParcelas = 0;
                     
                      List<String> listaMes = [];

                      listaMes.add("${data.year}-${data.month}");

                      if(int.tryParse(this.parcelas)>1){
                        for(int i = 1; i<int.tryParse(this.parcelas);i++){
                          listaMes.add("${data.year}-${data.month + i}"); 
                        }
                        
                      }

                      print(listaMes);

                     await  caixa.get().then((value)  {
                        dadoMes =  value.data()['contaSum'];
                      });

                      valorParcelas = double.tryParse(this.valor) / double.tryParse(this.parcelas);

                      for (int i  = 0 ; i < listaMes.length; i++){
                        print("Dados do For: ${dadoMes[listaMes[i]]}");
                      
                      if(dadoMes[listaMes[i]]!=null){
                        print("dadoMes contem valor");
                        valorDinheiro = dadoMes[listaMes[i]]  + valorParcelas;
                         await   caixa.set({
                          'contaSum' : {listaMes[i]: valorDinheiro} 
                        },SetOptions(merge: true));                        

                      } else{
                        await   caixa.set({
                          'contaSum' : {listaMes[i]: valorParcelas} 
                        },SetOptions(merge: true)); 
                      }

                      if(i == listaMes.length - 1){
                        if(dadoMes["total-${data.year}"] !=null){
                          await   caixa.set({
                          'contaSum' : {"total-${data.year}": 
                          (double.tryParse(this.valor) + dadoMes['total-${data.year}'])} 
                        },SetOptions(merge: true));
                        } else{
                           await   caixa.set({
                          'contaSum' : {"total-${data.year}": 
                          valorParcelas} 
                        },SetOptions(merge: true));
                        }
                      }
                      }
                        
                  

                    }
}
              

              }

AtualizaCaixa(this.data, this.operacao, this.valor, this.tipoConta,
 this.contaTransferencia, this.tipoPag, this.detalhe, this.parcelas);

AtualizaCaixa.compra(DateTime data, String valor, String operacao, String tipoConta, String contaTransferencia,
String tipoPag, String detalhe, int contItem) {
this.tipoPag = tipoPag;
this.contaTransferencia = contaTransferencia;
this.valor = valor;
this.operacao = operacao;
this.data = data;

String document = "${data.year}-${data.month}";
String conta;
double tratValor = double.tryParse(valor);
print(contItem);
if(contItem>0){
conta = "$tipoConta$contItem";

} else if(contItem==0){
  conta = tipoConta;
}


             diario.doc(document).set({
              data.day.toString() : {conta: "$tratValor;$detalhe-$operacao;$tipoPag", 
              }   
              }, SetOptions(merge: true) );

         
              teste();
             
 
 }

AtualizaCaixa.venda(DateTime data, String valor, String operacao, String tipoConta, String contaTransferencia,
String tipoPag, String detalhe, int contItem, String parcelas)  {
this.tipoPag = tipoPag;
this.contaTransferencia = contaTransferencia;
this.valor = valor;
this.operacao = operacao;
this.data = data;
this.parcelas = parcelas;

String document = "${data.year}-${data.month}";
String conta;
double tratValor = double.tryParse(valor);
print(contItem);

if(contItem>0){
conta = "$tipoConta$contItem";

} else if(contItem==0){
  conta = tipoConta;
}


             diario.doc(document).set({
               data.day.toString() : {conta: "$tratValor;$detalhe-$operacao;$tipoPag-$parcelas", 
              } 
                
              }, SetOptions(merge: true) );

              teste();
             
 
 }

AtualizaCaixa.caixa(DateTime data, String valor, String operacao, String tipoConta, String contaTransferencia,
String tipoPag, String detalhe, int contItem, String somaValor)  {
this.tipoPag = tipoPag;
this.contaTransferencia = contaTransferencia;
this.valor = valor;
this.operacao = operacao;
this.data = data;
this.tipoConta = tipoConta;
this.somaValor = somaValor;
this.detalhe = detalhe;

print("conta: $detalhe");
String document = "${data.year}-${data.month}";
String conta;
String tratTransf;
double tratValor = double.tryParse(valor);
print(contItem);

/**Acrescenta contador quando realizado mais de uma operacao com mesmo item */

if(contItem>0){
conta = "$tipoConta$contItem";

} else if(contItem==0){
  conta = tipoConta;
}

/**Salva conta em que esta sendo executada transferencia */
if (tipoPag == "Transferencia"){
  tratTransf = "$tipoPag-$contaTransferencia";
} else{
  tratTransf = tipoPag;
}

             diario.doc(document).set({
               data.day.toString() : {conta: "$tratValor;$detalhe-$operacao;$tratTransf", 
              } 
                
              }, SetOptions(merge: true) );

              teste();
             
 
 }

}