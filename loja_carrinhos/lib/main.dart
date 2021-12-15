



import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loja_carrinhos/ListaProdutos.dart';
import 'package:loja_carrinhos/MovimentoCaixa.dart';
import 'package:loja_carrinhos/RealizarVenda.dart';

//import 'package:loja_carrinhos/TelaAgendamento.dart';
import 'package:loja_carrinhos/TelaCadastroCliente.dart';
import 'package:loja_carrinhos/TelaCadastroProduto.dart';
import 'package:loja_carrinhos/TelaEstoque.dart';

import 'package:loja_carrinhos/TelaLogin.dart';
import 'package:loja_carrinhos/TelaMenu.dart';
import 'package:loja_carrinhos/data/creditSimulation/TelaSimulacaoVenda.dart';
import 'package:loja_carrinhos/alertaListaVendas.dart';
//import 'package:loja_carrinhos/TesteMudarData.dart';
import 'package:loja_carrinhos/alertaPeriodoVenda.dart';
import 'package:loja_carrinhos/comentarios.dart';

import 'package:loja_carrinhos/realizarCompra.dart';
//import 'package:loja_carrinhos/TelaAgenda.dart';
import 'package:loja_carrinhos/relatorio.dart';



void main  () async
 {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  runApp(MaterialApp(
debugShowCheckedModeBanner: false,
    home: Menu(),

    routes: {
      '/telaCadastroCliente' : (context) => CadastroCliente(),     
      //'/agendamento' : (context) => TelaAgendamento(),
      '/telaLogin' : (context) => TelaLogin(),
      '/realizarCompra' : (context) => RealizarCompra(),
      //'/agenda' : (context) => TelaAgenda(),
      //'/teste' : (context) => TesteMudarData(),
      '/telaAlerta' : (context) => AlertaListaTela(),
      '/telaEstoque' : (context) => TelaEstoque(),
      '/cadastroProduto' : (context) => CadastroProduto(),
      '/listaProdutos' : (context) => ListaProdutos(),
      '/simularVenda' : (context) => SimulacaoVenda(),
      '/realizarVenda' : (context) => RealizarVenda(),
      '/comentario' : (context) => Comentarios(),
      '/relatorio' : (context)=> Relatorios(),
      '/caixa' : (context) => Caixa(),
      '/vendaFutura' : (context) => VendaFutura()
      
     },

    localizationsDelegates: [
      GlobalMaterialLocalizations.delegate
    ],
    supportedLocales: [
      const Locale('pt' )
    ],

  )
  );

 


}
