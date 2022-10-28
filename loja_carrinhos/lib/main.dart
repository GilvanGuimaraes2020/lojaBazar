



import 'package:firebase_core/firebase_core.dart';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
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
import 'package:loja_carrinhos/view/screens/error_page.dart';
import 'package:loja_carrinhos/view/screens/home_page.dart';
import 'package:loja_carrinhos/view/screens/loading_page.dart';
import 'package:loja_carrinhos/view/screens/menu_page.dart';

void main  () async
 {
    WidgetsFlutterBinding.ensureInitialized();
  
  runApp(App());
}

class App extends StatefulWidget {

  App({ Key key }) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final Future<FirebaseApp> _inicializacao = Firebase.initializeApp(); 

  FlutterLocalNotificationsPlugin localNotificationsPlugin;

  Future _showNotification()async{
    var androidDetails = AndroidNotificationDetails("channelId", "channelName"
    "this is the description", importance: Importance.high
    );

    var iosDetails = IOSNotificationDetails();

    var generalDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);

    await localNotificationsPlugin.show(0, "Notif Title", 
    "the Body Notification" , generalDetails);
  }

  /* requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: 
      (int id, String title, String body, String payload) async
      {} */

  @override
void initState(){
  super.initState();
  var initializationSettingAndroid = AndroidInitializationSettings('ic_launcher');
  var initializationSettingIOS = IOSInitializationSettings();
  
  var initializationSettings = InitializationSettings(
      android: initializationSettingAndroid , iOS: initializationSettingIOS
    );
    localNotificationsPlugin = new FlutterLocalNotificationsPlugin();

    localNotificationsPlugin.initialize(initializationSettings);
}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
debugShowCheckedModeBanner: false,
//Inserir menuPage para nao precisar digitar senha quando reloaded, padrao HomePage
    home: FutureBuilder(
      future: _inicializacao,
      builder: (context , app){
        if (app.connectionState == ConnectionState.done){
          _showNotification();
          return HomePage();
        } else if(app.hasError){
          return ErrorPage();
        }else{
          return LoadingPage();
        }
      },
    ),

    routes: {
      
      '/menu' : (context) => MenuPage(),
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

  );
  }
}