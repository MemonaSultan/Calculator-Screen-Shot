import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:csv/csv.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io'; // Import dart:io to use File
import 'task_model.dart';

class ExportAndNotifications {
  FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();

  ExportAndNotifications() {
    var initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    notificationsPlugin.initialize(initializationSettings);
  }

  void scheduleNotification(Task task) {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      channelDescription: 'Notifications for upcoming tasks',
      importance: Importance.max,
      priority: Priority.high,
    );
    var platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);

    notificationsPlugin.schedule(
      task.id!,
      'Task Reminder',
      task.title,
      task.dueDate,
      platformChannelSpecifics,
    );
  }

  Future<void> exportToCsv(List<Task> tasks) async {
    List<List<String>> csvData = [
      ['ID', 'Title', 'Description', 'Due Date', 'Completed', 'Repeated'],
      ...tasks.map((task) => [
        task.id.toString(),
        task.title,
        task.description,
        task.dueDate.toIso8601String(),
        task.isCompleted ? 'Yes' : 'No',
        task.isRepeated ? 'Yes' : 'No'
      ])
    ];

    String csv = const ListToCsvConverter().convert(csvData);

    // Retrieve the temporary directory for file storage
    final directory = await getTemporaryDirectory();
    final path = '${directory.path}/tasks_export.csv';
    final file = File(path);

    // Write CSV data to the file
    await file.writeAsString(csv);

    // Share the CSV file
    Share.shareFiles([path], text: 'Tasks Export');
  }
}
