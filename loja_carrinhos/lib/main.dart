



import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:loja_carrinhos/ListaProdutos.dart';
import 'package:loja_carrinhos/TelaCadastroProduto.dart';
import 'package:loja_carrinhos/data/creditSimulation/TelaSimulacaoVenda.dart';
import 'package:loja_carrinhos/alertaListaVendas.dart';
//import 'package:loja_carrinhos/TesteMudarData.dart';
import 'package:loja_carrinhos/alertaPeriodoVenda.dart';
import 'package:loja_carrinhos/comentarios.dart';

//import 'package:loja_carrinhos/TelaAgenda.dart';
import 'package:loja_carrinhos/relatorio.dart';
import 'package:loja_carrinhos/view/screens/home_page.dart';
import 'package:loja_carrinhos/view/screens/menu_page.dart';




void main  () async
 {
    WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); 

  runApp(MaterialApp(
debugShowCheckedModeBanner: false,
//Inserir menuPage para nao precisar digitar senha quando reloaded, padrao HomePage
    home: HomePage(),

    routes: {
      
      
      '/telaAlerta' : (context) => AlertaListaTela(),
      '/cadastroProduto' : (context) => CadastroProduto(),
      '/listaProdutos' : (context) => ListaProdutos(),
      '/simularVenda' : (context) => SimulacaoVenda(),
      '/comentario' : (context) => Comentarios(),
      '/relatorio' : (context)=> Relatorios(),
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
