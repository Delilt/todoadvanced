import 'package:hive/hive.dart';
import 'package:todoadvanced/data/models/category_model.dart';
import 'package:todoadvanced/data/models/task_model.dart';

class DatabaseService {
  final Box<Category> _categoryBox = Hive.box<Category>('categories');
  final Box<Task> _taskBox = Hive.box<Task>('tasks');

  // Category Operations
  List<Category> getCategories() {
    return _categoryBox.values.toList();
  }

  Future<void> addCategory(Category category) async {
    await _categoryBox.put(category.id, category);
  }

  Future<void> deleteCategory(String categoryId) async {
    // Also delete all tasks associated with this category
    final tasksToDelete = _taskBox.values.where((task) => task.categoryId == categoryId);
    for (var task in tasksToDelete) {
      await _taskBox.delete(task.id);
    }
    await _categoryBox.delete(categoryId);
  }

  // Task Operations
  List<Task> getTasks() {
    return _taskBox.values.toList();
  }

  Future<void> addTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> updateTask(Task task) async {
    await _taskBox.put(task.id, task);
  }

  Future<void> deleteTask(String taskId) async {
    await _taskBox.delete(taskId);
  }
} 