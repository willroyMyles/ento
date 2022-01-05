import 'package:ento/backend/api/api.dart';
import 'package:ento/services/notification.service.dart';
import 'package:ento/services/storage.service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

Future<void> _handleFirebaeBackgroundMessage(RemoteMessage message) async {
  print("background message recieved");
  ApiCall calls = ApiCall();
  calls.addNotificationToMyNotifications(message.data["ref"]);
}

class FireBaseMessagingService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final String androidNotification = "AndroidNotification";
  final api = Get.find<ApiCall>();
  // SharedPreferences _prefs;

  FireBaseMessagingService() {
    // initialize();
  }

  initialize() async {
    // _prefs = await SharedPreferences.getInstance();
    messaging.setForegroundNotificationPresentationOptions(
      alert: true, // Required to display a heads up notification
      badge: true,
      sound: true,
    );
    permission();
    setupInteractedMessage();
    getToken();
  }

  permission() async {
    var settings = await messaging.getNotificationSettings();
    switch (settings.authorizationStatus) {
      case AuthorizationStatus.authorized:
        break;
      case AuthorizationStatus.denied:
        break;
      case AuthorizationStatus.notDetermined:
        await requestPermission();
        break;
      case AuthorizationStatus.provisional:
        break;
    }
  }

  requestPermission() async {
    var settings = await messaging.requestPermission(
        alert: true, badge: true, criticalAlert: false, sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }
  }

  Future<void> setupInteractedMessage() async {
    messaging.setAutoInitEnabled(true);
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage = await messaging.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessagePressed);
    FirebaseMessaging.onMessage.listen(_handleMessage);

    FirebaseMessaging?.onBackgroundMessage(_handleFirebaeBackgroundMessage);
  }

  void _handleMessage(RemoteMessage message) {
    print("message handle recieved recieved ${message.toString()}");
    api.addNotificationToMyNotifications(message.data["ref"]);
    noti.createNotification(message);
  }

  void _handleMessagePressed(RemoteMessage message) {
    print("message pressed recieved ${message.toString()}");
    api.addNotificationToMyNotifications(message.data["ref"]);
    // Navigator.of(Get.context).pushNamed(message.data["ref"]);
  }

  void getToken() async {
    var token = await messaging.getToken();

    // infoService.updateTokenId(token);
    // apiS.saveToken(token);
    var confirmToken = storeage.store.read<String>("fbToken");

    if (confirmToken != token) {
      api.saveToken(token);
      storeage.store.write("fbToken", token);
    }
    print(token);
  }

  void justPrint() {
    print("pressed");
    initialize();
  }
}

FireBaseMessagingService fireBaseMessagingService = FireBaseMessagingService();
FireBaseMessagingService get messagingService => fireBaseMessagingService;
