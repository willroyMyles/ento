import 'package:awesome_notifications/awesome_notifications.dart';
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
          ),
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

  createNotification(RemoteMessage message) {
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
}

NotificationService notificationService = NotificationService();
NotificationService get noti => notificationService;
