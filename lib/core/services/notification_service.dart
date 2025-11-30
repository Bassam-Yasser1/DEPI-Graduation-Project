import 'package:awesome_notifications/awesome_notifications.dart';

class NotificationService {
  static Future<void> initialize() async {
    await AwesomeNotifications().initialize(
      null, // Use app icon
      [
        NotificationChannel(
          channelKey: 'scheduled_channel',
          channelName: 'Scheduled Reminders',
          channelDescription: 'Notifications for scheduled visits',
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          // defaultColor: const Color(0xFF0057FF),
          // ledColor: const Color(0xFFFFFFFF),
        ),
      ],
      debug: true,
    );
  }

  static Future<void> showNotification({
    required int id,
    required String title,
    required String body,
  }) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'scheduled_channel',
        title: title,
        body: body,
        notificationLayout: NotificationLayout.Default,
      ),
    );
  }
}
