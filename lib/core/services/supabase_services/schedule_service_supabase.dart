import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import '../../../main.dart';
import '../../../models/schedule_supabase.dart';
import '../alarm_callback.dart';

class ScheduleServiceSupabase {
  ScheduleServiceSupabase();

  /// Create a new schedule and set an alarm
  Future<int> createSchedule(ScheduleSupabase schedule) async {
    // Insert schedule into Supabase
    final inserted = await cloud
        .from('schedules')
        .insert(schedule.toMap())
        .select()
        .single();

    final scheduleId = inserted['schedule_id'] as int;

    // Schedule the alarm
    // final scheduledDate = DateTime.parse(schedule.date);
    final date = schedule.date; // "2025-01-10"
    final hour = schedule.hour; // "14:30"
    final scheduledDateTime = DateTime.parse(
      "${schedule.date} ${schedule.hour}:00",
    );

    await AndroidAlarmManager.oneShotAt(
      scheduledDateTime,
      scheduleId, // unique alarm ID
      alarmCallbackWithId,
      exact: true,
      wakeup: true,
      rescheduleOnReboot: true,
    );
    return scheduleId;
  }

  /// Delete a schedule and cancel the alarm
  Future<void> deleteSchedule(int? scheduleId) async {
    await cloud.from('schedules').delete().eq('schedule_id', scheduleId!);

    // Cancel the alarm
    await AndroidAlarmManager.cancel(scheduleId);
  }

  /// Mark a schedule as done
  Future<void> markAsDone(int scheduleId) async {
    await cloud
        .from('schedules')
        .update({'is_done': true})
        .eq('schedule_id', scheduleId);

    // Optionally, cancel the alarm if you don't want notifications anymore
    await AndroidAlarmManager.cancel(scheduleId);
  }

  /// Fetch all schedules for the current user
  Future<List<ScheduleSupabase>> getSchedules(String userId) async {
    final data = await cloud
        .from('schedules')
        .select()
        .eq('user_id', userId)
        .order('scheduled_at', ascending: true);

    return (data as List)
        .map((e) => ScheduleSupabase.fromMap(e as Map<String, dynamic>))
        .toList();
  }

  /// Fetch a single schedule by ID
  Future<ScheduleSupabase?> getScheduleById(int scheduleId) async {
    final data = await cloud
        .from('schedules')
        .select()
        .eq('schedule_id', scheduleId)
        .maybeSingle();

    if (data == null) return null;
    return ScheduleSupabase.fromMap(data as Map<String, dynamic>);
  }
}
