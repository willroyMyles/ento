import 'package:ento/backend/api/api.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

class FireBaseMessagingService {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final String androidNotification = "AndroidNotification";
  final api = Get.find<ApiCall>();
  // SharedPreferences _prefs;

  FireBaseMessagingService() {
    initialize();
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

    // FirebaseMessaging.onBackgroundMessage((message) {
    //   if (message != null) {
    //     print(message);
    //     print(message.data);
    //   }
    //   return Future.value();
    // });
  }

  void _handleMessage(RemoteMessage message) {
    print("message recieved $message");
  }

  void _handleMessagePressed(RemoteMessage message) {
    print("message recieved $message");
    // Navigator.of(Get.context).pushNamed(message.data["ref"]);
  }

  void getToken() async {
    var token = await messaging.getToken();
    // infoService.updateTokenId(token);
    // apiS.saveToken(token);
    api.saveToken(token);
    print(token);
  }

  void justPrint() {
    print("pressed");
  }
}

FireBaseMessagingService fireBaseMessagingService = FireBaseMessagingService();
FireBaseMessagingService get messagingService => fireBaseMessagingService;
