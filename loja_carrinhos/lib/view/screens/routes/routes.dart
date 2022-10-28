import 'package:flutter/cupertino.dart';

import 'package:loja_carrinhos/TelaCadastroProduto.dart';
import 'package:loja_carrinhos/control/teste_notification/teste_notification.dart';
import 'package:loja_carrinhos/relatorio.dart';
import 'package:loja_carrinhos/view/cloudFiles/show_images.dart';
import 'package:loja_carrinhos/view/screens/cadastro_cliente_page.dart';
import 'package:loja_carrinhos/view/screens/cash_page.dart';
import 'package:loja_carrinhos/view/screens/compra_page.dart';
import 'package:loja_carrinhos/view/screens/estoque_page.dart';
import 'package:loja_carrinhos/view/screens/home_page.dart';
import 'package:loja_carrinhos/view/screens/menu_page.dart';
import 'package:loja_carrinhos/view/screens/venda_page.dart';

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
             pageBuilder: (_ , __ , ___) => CadastroClientePage()));
        } else if(route == 'produto'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => CadastroProduto()));
        } else if(route == 'estoque'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => EstoquePage()));
        } else if(route == 'vender'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => PageVenda()));
        } else if(route == 'comprar'){
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => CompraPage()));
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
          //Usar o icone alerta para trata dos dados do banco NormalizaBanco,
          //serao convertidos os dados do documento de registro antigo para os novos
          //teste notification: TesteNotification
          //estava VendaFutura na rota desta parte
          Navigator.push(context,
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___) => TesteNotification()));
        } else if(route == "logout"){
           Navigator.pushAndRemoveUntil(context, 
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___ ) => HomePage()), 
             (route) => false);
        } else if(route == "fotos"){
           Navigator.pushAndRemoveUntil(context, 
           PageRouteBuilder(
             transitionDuration: Duration(milliseconds: 100),
             pageBuilder: (_ , __ , ___ ) => ShowImages()), 
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

  Routes.rota(BuildContext context, Widget rota){
    Navigator.push(context, 
    PageRouteBuilder(
      transitionDuration: Duration(milliseconds: 100),
      pageBuilder: (_ , __ , ___) => rota));
  }
   
}