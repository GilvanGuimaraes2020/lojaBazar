
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  
 /*  const AndroidNotificationDetails androidPlatformChannelSpecifics = 
    AndroidNotificationDetails(
        channelId: String,   //Required for Android 8.0 or after
        channelName: String, //Required for Android 8.0 or after
        channelDescription: String, //Required for Android 8.0 or after
        importance: Importance,
        priority: Priority
    );
     */
  static final NotificationService _notificationService =
      NotificationService._internal();

  factory NotificationService() {
    return _notificationService;
  }

  NotificationService._internal();
  
  void init() async{
    
  final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher.png');
  
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
    requestSoundPermission: false,
    requestBadgePermission: false,
    requestAlertPermission: false,
    //onDidReceiveLocalNotification: onDidReceiveLocalNotification,
  );
  
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: initializationSettingsAndroid, 
            iOS: initializationSettingsIOS, 
            macOS: null);

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);  
    
  }

  Future selectNotification(String payload) async {
      //Handle notification tapped logic here
   }
   
}