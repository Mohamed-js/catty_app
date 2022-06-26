import 'dart:math';
import 'package:awesome_notifications/awesome_notifications.dart';

Future<void> createMessageNotification() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: 1,
      channelKey: 'messages_channel',
      title: "${Emojis.animals_dog} PetsMating ${Emojis.animals_cat}",
      body: 'You have a new message!',
      displayOnForeground: true,
      displayOnBackground: true,
    ),
  );
}
