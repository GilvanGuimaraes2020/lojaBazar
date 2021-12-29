import 'package:flutter/cupertino.dart';

import 'package:loja_carrinhos/RealizarCompra.dart';
import 'package:loja_carrinhos/RealizarVenda.dart';
import 'package:loja_carrinhos/TelaCadastroProduto.dart';
import 'package:loja_carrinhos/TelaEstoque.dart';
import 'package:loja_carrinhos/alertaPeriodoVenda.dart';
import 'package:loja_carrinhos/relatorio.dart';
import 'package:loja_carrinhos/view/screens/cash_page.dart';
import 'package:loja_carrinhos/view/screens/home_page.dart';
import 'package:loja_carrinhos/view/screens/menu_page.dart';

import '../../../TelaCadastroCliente.dart';
import '../../../comentarios.dart';
import '../../../data/creditSimulation/TelaSimulacaoVenda.dart';

class Routes{
  String route;
  BuildContext context;
  Routes({this.route, this.context});

  void changeRoute(){
    if(route == 'comentario'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => Comentarios()));
        } else if(route == 'simular'){
           Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => SimulacaoVenda()));
        } else if(route == 'cliente'){
           Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => CadastroCliente()));
        } else if(route == 'produto'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => CadastroProduto()));
        } else if(route == 'estoque'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => TelaEstoque()));
        } else if(route == 'vender'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => RealizarVenda()));
        } else if(route == 'comprar'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => RealizarCompra()));
        } else if (route == 'relatorio'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => Relatorios()));
        } else if(route == 'caixa'){
          //CashPage pagina com upgrade
          //Caixa pagina antiga
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => CashPage()));
        } else if(route == 'alerta'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => VendaFutura()));
        } else if(route == "logout"){
           Navigator.pushAndRemoveUntil(context, 
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___ ) => HomePage()), 
             (route) => false);
        } 
        else {
           Navigator.pushAndRemoveUntil(context, 
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___ ) => MenuPage()), 
             (route) => false);
        }
  }
   
}