import 'package:flutter/material.dart';
import 'package:loja_carrinhos/view/screens/widgets/shared/w_botao.dart';

import 'models/alarm_info.dart';

class TesteNotification extends StatefulWidget {
  const TesteNotification({ Key key });

  @override
  _TesteNotificationState createState() => _TesteNotificationState();
}

class _TesteNotificationState extends State<TesteNotification> {
  
 
  
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: Colors.amber
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: (){}/* NotificationApi.showNotifications(
              title: 'Sarah Abs',
              body: 'Hey! Do we have everything we need',
              payload: 'sarah.abs'
            ) */,
            child: WBotao(rotulo: "Testar Notificaçao", cor: Colors.blue,),
          )
        ],
      ),
    );
  }
  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, AlarmInfo alarmInfo) async {

    /* var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
 
    await flutterLocalNotificationsPlugin.schedule(0, 'Office', alarmInfo.title,
        scheduledNotificationDateTime, platformChannelSpecifics);*/
  }
}