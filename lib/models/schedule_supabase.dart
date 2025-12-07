import 'package:depi_graduation_project/models/schedule_model.dart';

class ScheduleSupabase extends ScheduleModel {
  final int? scheduleId;
  final int? notificationId; // NEW

  ScheduleSupabase({
    this.scheduleId,
    this.notificationId, // FIXED
    required int placeId,
    required String date,
    required String hour,
    required String? note,
    required bool isDone,
    required int createdAt,
    required String? userId,
    required double? lat,
    required double? lng,
    required String? image,
    required String? name,
  }) : super(
         placeId: placeId,
         date: date,
         hour: hour,
         name: name,
         note: note,
         isDone: isDone,
         createdAt: createdAt,
         userId: userId,
         lat: lat,
         lng: lng,
         image: image,
       );

  factory ScheduleSupabase.fromMap(Map<String, dynamic> map) {
    return ScheduleSupabase(
      scheduleId: map['schedule_id'] as int?,
      notificationId: map['notification_id'] as int?, // NEW
      placeId: map['place_id'] as int,
      date: map['date'] as String,
      hour: map['hour'] as String,
      note: map['note'] as String?,
      isDone: map['is_done'] as bool? ?? false,
      createdAt: map['created_at'] as int,
      userId: map['user_id'] as String?,
      lat: map['lat'] as double?,
      lng: map['lng'] as double?,
      image: map['image'] as String?,
      name: map['name'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    final map = {
      'place_id': placeId,
      'date': date,
      'hour': hour,
      'note': note,
      'is_done': isDone,
      'created_at': createdAt,
      'user_id': userId,
      'lat': lat,
      'lng': lng,
      'name': name,
      'image': image,
      'notification_id': notificationId, // NEW
    };

    if (scheduleId != null) {
      map['schedule_id'] = scheduleId;
    }

    return map;
  }
}
