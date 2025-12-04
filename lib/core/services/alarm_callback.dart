import 'package:depi_graduation_project/core/services/notification_service.dart';
import 'package:depi_graduation_project/core/services/supabase_services/schedule_service_supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../main.dart';
import '../database/tourApp_database.dart';

void alarmCallbackWithId(int scheduleId) async {
  // Initialize the database in this background isolate
  // final cloud = Supabase.instance.client;
  database = await $FloortourDatabase.databaseBuilder('tourAppDB.db').build();

  final scheduleDao = database.scheduledao;

  // Fetch the schedule
  final schedule = await scheduleDao.selectScheduleById(scheduleId);
  var supaSchedule;
  if (schedule == null) {
    supaSchedule = await ScheduleServiceSupabase().getScheduleById(scheduleId);
  }

  if (schedule != null) {
    // Show notification
    NotificationService.showNotification(
      id: schedule.scheduleId ?? scheduleId,
      title: 'Visit Reminder',
      body: 'It’s time to visit ${schedule.placeId ?? "your destination"}!',
    );
  } else if (supaSchedule != null) {
    NotificationService.showNotification(
      id: supaSchedule.schedule_id ?? scheduleId,
      title: 'Visit Reminder',
      body:
          'It’s time to visit ${supaSchedule.place_id ?? "your destination"}!',
    );
  }
}
