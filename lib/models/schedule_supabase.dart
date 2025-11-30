class ScheduleSupabase {
  final int? scheduleId; // Supabase BIGSERIAL
  final String? placeId;
  final DateTime scheduledAt;
  final String? note;
  final bool isDone;
  final int createdAt; // milliseconds since epoch
  final String? userId;

  ScheduleSupabase({
    this.scheduleId,
    this.placeId,
    required this.scheduledAt,
    this.note,
    this.isDone = false,
    required this.createdAt,
    this.userId,
  });

  // Convert from Supabase map to Schedule object
  factory ScheduleSupabase.fromMap(Map<String, dynamic> map) {
    return ScheduleSupabase(
      scheduleId: map['schedule_id'] as int?,
      placeId: map['place_id'] as String?,
      scheduledAt: DateTime.parse(map['scheduled_at'] as String),
      note: map['note'] as String?,
      isDone: map['is_done'] as bool? ?? false,
      createdAt: map['created_at'] as int,
      userId: map['user_id'] as String?,
    );
  }

  // Convert Schedule object to map for Supabase insert/update
  Map<String, dynamic> toMap() {
    return {
      'schedule_id': scheduleId,
      'place_id': placeId,
      'scheduled_at': scheduledAt.toIso8601String(),
      'note': note,
      'is_done': isDone,
      'created_at': createdAt,
      'user_id': userId,
    };
  }
}
