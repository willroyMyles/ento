import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:ento/services/storage.service.dart';
import 'package:firebase_messaging_platform_interface/src/remote_message.dart';
import 'package:flutter/material.dart';

class NotificationService {
  final awe = AwesomeNotifications();
  NotificationService() {
    awe.initialize(
        null,
        [
          NotificationChannel(
              channelKey: "test_channel",
              channelName: "test channel",
              channelDescription: "just using to test notifications",
              defaultColor: Colors.green,
              importance: NotificationImportance.High,
              criticalAlerts: true,
              channelShowBadge: true),
        ],
        debug: true);
    listenToNotifications();
  }

  promptNotificationPermissionifNotPresent() async {
    final allowed = await awe.isNotificationAllowed();
    if (!allowed) {
      //prompt
      awe.requestPermissionToSendNotifications();
    }
  }

  listenToNotifications() {
    //to detect taps
    awe.actionStream.listen((event) {
      print(event);
    });
  }

  createSimpleNotification(RemoteMessage message) {
    //get notification permission
    var perm = storeage.getManagedPermission(message.data["companyId"]);
    var shouldCreatePermission = perm.permissions["simple"];
    if (shouldCreatePermission ?? false)
      awe.createNotification(
          content: NotificationContent(
            id: 10,
            channelKey: "test_channel",
            title: message.notification?.title,
            body: message.notification?.body,
            ticker: "what is ticker",
            color: Colors.green,
            displayOnForeground: true,
            displayOnBackground: true,
            summary: "summary of message",
            backgroundColor: Colors.yellow,
          ),
          actionButtons: [
            NotificationActionButton(
              key: "yes",
              label: "Yes",
            ),
            NotificationActionButton(
              key: "No",
              label: "No",
            )
          ]);
  }

  createPromotionNotification(RemoteMessage message) {
    var perm = storeage.getManagedPermission(message.data["companyId"]);
    var shouldCreatePermission = perm.permissions["promotion"];
    if (shouldCreatePermission ?? false)
      awe.createNotification(
          content: NotificationContent(
              id: 10,
              channelKey: "test_channel",
              title: message.notification?.title,
              body: message.notification?.body,
              ticker: "what is ticker",
              color: Colors.green,
              displayOnForeground: true,
              displayOnBackground: true,
              summary: "summary of message",
              backgroundColor: Colors.yellow,
              bigPicture: message.data["image"],
              // category: NotificationCategory.,
              // icon: message.notification?.android?.imageUrl,

              largeIcon: message.data["image"],
              hideLargeIconOnExpand: true,
              notificationLayout: NotificationLayout.BigPicture),
          actionButtons: [
            NotificationActionButton(
              key: "yes",
              label: "Yes",
            ),
            NotificationActionButton(
              key: "No",
              label: "No",
            )
          ]);
  }

  createNotification(RemoteMessage message) {
    if (message.data["image"] != "")
      return createPromotionNotification(message);
    return createSimpleNotification(message);
  }
}

NotificationService notificationService = NotificationService();
NotificationService get noti => notificationService;
