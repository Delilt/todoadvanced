import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

part 'category_model.g.dart';

@HiveType(typeId: 0)
class Category extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  String name;

  Category({required this.name}) {
    id = const Uuid().v4();
  }
} 