import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'task_model.g.dart';

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  late String categoryId;

  @HiveField(3)
  bool isCompleted;

  Task({
    required this.title,
    required this.categoryId,
    this.isCompleted = false,
  }) {
    id = const Uuid().v4();
  }
} 