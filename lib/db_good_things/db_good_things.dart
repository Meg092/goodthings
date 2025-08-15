import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'good_things_entity.dart';

class DB extends GetxService {
  Database? _database;

  Future<DB> init() async {
    await dbBase;
    return this;
  }

  Future<Database> get dbBase async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), 'good_things.db');

    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE good_things (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            note TEXT NOT NULL,
            created_time TEXT NOT NULL
          );
        ''');

        await db.execute('''
          CREATE TABLE lucky_draws (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title TEXT NOT NULL,
            description TEXT NOT NULL,
            created_time TEXT NOT NULL
          );
        ''');
      },
    );
  }

  Future<CheckInStats> getConsecutiveCheckInDays() async {
    final db = await dbBase;
    final today = DateTime.now();
    final todayStart = DateTime(today.year, today.month, today.day);

    final maps = await db.query('good_things', orderBy: 'created_time DESC');

    if (maps.isEmpty) {
      return CheckInStats(streak: 0, recordCount: 0);
    }

    int streak = 0;
    Set<String> checkInDates = {};

    for (var map in maps) {
      final date = DateTime.parse(map['created_time'] as String);
      final checkInDate = DateTime(date.year, date.month, date.day);
      checkInDates.add(DateFormat('yyyy-MM-dd').format(checkInDate));
    }

    final sortedDates =
        checkInDates.map((dateStr) => DateTime.parse(dateStr)).toList()
          ..sort((a, b) => b.compareTo(a));

    DateTime currentDate = todayStart;
    for (int i = 0; i < sortedDates.length; i++) {
      if (sortedDates[i] == currentDate) {
        streak++;
        currentDate = currentDate.subtract(Duration(days: 1));
      } else {
        break;
      }
    }

    int recordCount = 0;
    if (streak > 0) {
      final endDate = todayStart.add(Duration(days: 1));
      final startDate = todayStart.subtract(Duration(days: streak - 1));
      final startDateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(startDate);
      final endDateStr = DateFormat('yyyy-MM-dd HH:mm:ss').format(endDate);

      final result = await db.rawQuery(
        'SELECT COUNT(*) as count FROM good_things WHERE created_time >= ? AND created_time < ?',
        [startDateStr, endDateStr],
      );
      recordCount = Sqflite.firstIntValue(result) ?? 0;
    }

    return CheckInStats(streak: streak, recordCount: recordCount);
  }

  Future<int> create(GoodThingEntity goodThingEntity) async {
    final db = await dbBase;
    return await db.insert('good_things', goodThingEntity.toMap());
  }

  Future<List<GoodThingEntity>> getAll() async {
    final db = await dbBase;
    final maps = await db.query('good_things', orderBy: 'created_time DESC');
    return List.generate(maps.length, (i) => GoodThingEntity.fromMap(maps[i]));
  }

  Future<List<GoodThingEntity>> getByMonth(String year, String month) async {
    final _year = int.parse(year);
    final _month = int.parse(month);

    final db = await dbBase;
    final startDate = DateFormat('yyyy-MM-dd').format(DateTime(_year, _month));
    final endDate = DateFormat(
      'yyyy-MM-dd',
    ).format(DateTime(_year, _month + 1));

    final maps = await db.query(
      'good_things',
      where: 'created_time >= ? AND created_time < ?',
      whereArgs: [startDate, endDate],
      orderBy: 'created_time DESC',
    );

    return List.generate(maps.length, (i) => GoodThingEntity.fromMap(maps[i]));
  }

  Future<int> update(GoodThingEntity goodThingEntity) async {
    final db = await dbBase;
    return await db.update(
      'good_things',
      goodThingEntity.toMap(),
      where: 'id = ?',
      whereArgs: [goodThingEntity.id],
    );
  }

  Future<int> createLuckyDraw(LuckyDrawEntity luckyDrawEntity) async {
    final db = await dbBase;
    return await db.insert('lucky_draws', luckyDrawEntity.toMap());
  }

  Future<List<LuckyDrawEntity>> getAllLuckyDraws() async {
    final db = await dbBase;
    final maps = await db.query('lucky_draws', orderBy: 'created_time DESC');
    return List.generate(maps.length, (i) => LuckyDrawEntity.fromMap(maps[i]));
  }

  Future<LuckyDrawEntity?> getLuckyDrawById(int id) async {
    final db = await dbBase;
    final maps = await db.query(
      'lucky_draws',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return LuckyDrawEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<LuckyDrawEntity?> getLuckyDrawByDate(String date) async {
    final db = await dbBase;
    final maps = await db.query(
      'lucky_draws',
      where: "created_time LIKE ?",
      whereArgs: ['$date%'],
    );

    if (maps.isNotEmpty) {
      return LuckyDrawEntity.fromMap(maps.first);
    }
    return null;
  }

  Future<void> clearRecords() async {
    final db = await dbBase;
    try {
      await db.delete('good_things');
      await db.delete('lucky_draws');
    } catch (e) {
      print('Clear data error: $e');
    }
  }

  @override
  void onClose() {
    _database?.close();
    super.onClose();
  }
}
