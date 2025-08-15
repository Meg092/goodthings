class GoodThingEntity {
  final int? id;
  final String note;
  final DateTime? createdTime;

  GoodThingEntity({this.id, required this.note, this.createdTime});

  Map<String, dynamic> toMap() {
    if (id == null) {
      return {
        'note': note,
        'created_time': createdTime ?? DateTime.now().toIso8601String(),
      };
    }
    return {
      'id': id,
      'note': note,
      'created_time': createdTime ?? DateTime.now().toIso8601String(),
    };
  }

  factory GoodThingEntity.fromMap(Map<String, dynamic> map) {
    return GoodThingEntity(
      id: map['id'],
      note: map['note'],
      createdTime: DateTime.parse(map['created_time']),
    );
  }
}

class CheckInStats {
  final int streak;
  final int recordCount;

  CheckInStats({required this.streak, required this.recordCount});
}

class LuckyDrawEntity {
  final int? id;
  final String title;
  final String description;
  final DateTime? createdTime;

  LuckyDrawEntity({
    this.id,
    required this.title,
    required this.description,
    this.createdTime,
  });

  Map<String, dynamic> toMap() {
    if (id == null) {
      return {
        'title': title,
        'description': description,
        'created_time': createdTime ?? DateTime.now().toIso8601String(),
      };
    }
    return {
      'id': id,
      'title': title,
      'description': description,
      'created_time': createdTime ?? DateTime.now().toIso8601String(),
    };
  }

  factory LuckyDrawEntity.fromMap(Map<String, dynamic> map) {
    return LuckyDrawEntity(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      createdTime: DateTime.parse(map['created_time']),
    );
  }
}

List<LuckyDrawEntity> luckyDraws = [
  LuckyDrawEntity(
    title: 'Smooth Sailing',
    description:
        'Today, your path is as smooth as a gentle breeze. Take the first step boldly, and success awaits you.',
  ),
  LuckyDrawEntity(
    title: 'Dreams Come True',
    description:
        'What your heart desires can be achieved. Stay focused, and your efforts will bear fruit.',
  ),
  LuckyDrawEntity(
    title: 'Guided by a Mentor',
    description:
        'A helpful guide will appear by your side today. Listen to their advice, and opportunities will follow.',
  ),
  LuckyDrawEntity(
    title: 'Unexpected Joy',
    description:
        'A pleasant surprise is on its way. Keep an open mind, and good fortune will find you.',
  ),
  LuckyDrawEntity(
    title: 'Steady Wins the Race',
    description:
        'Move forward steadily, without haste. Your patience today will pave the way to success.',
  ),
];
