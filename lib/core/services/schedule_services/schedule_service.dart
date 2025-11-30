import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:depi_graduation_project/core/services/supabase_services/schedule_service_supabase.dart';
import 'package:depi_graduation_project/main.dart';
import 'package:depi_graduation_project/models/schedule_supabase.dart';

import '../../database/models/schedules.dart';
import '../alarm_callback.dart';

class ScheduleService {
  Future<void> createSchedule(Schedule schedule) async {
    // Schedule the alarm for the exact time
    final scheduledDate = DateTime.parse(schedule.scheduled_at);
    final id = await database.scheduledao.insertSchedule(schedule);
    await ScheduleServiceSupabase().createSchedule(
      ScheduleSupabase(
        scheduleId: id,
        scheduledAt: scheduledDate,
        createdAt: schedule.created_at,
        placeId: schedule.place_id,
        userId: cloud.auth.currentUser?.id,
      ),
    );

    await AndroidAlarmManager.oneShotAt(
      scheduledDate,
      id, // Use schedule_id as the unique alarm ID
      alarmCallbackWithId,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
  }

  Future<void> deleteSchedule(Schedule schedule) async {
    await database.scheduledao.deleteSchedule(schedule);
    await ScheduleServiceSupabase().deleteSchedule(schedule.schedule_id);

    // Cancel the alarm
    await AndroidAlarmManager.cancel(schedule.schedule_id!);
  }

  // Mark schedule as done
  Future<void> markAsDone(int id) async {
    await database.scheduledao.markAsDone(id);
    await ScheduleServiceSupabase().markAsDone(id);
  }

  // Fetch schedules for a user
  Future<List<Schedule>> getSchedulesDB(String uid) async {
    return await database.scheduledao.selectSchedules(uid);
  }

  Future<List<ScheduleSupabase>> getSchedulesSB(String uid) async {
    return await ScheduleServiceSupabase().getSchedules(uid);
  }
}
