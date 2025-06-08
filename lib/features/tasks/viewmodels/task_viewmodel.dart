import 'package:flutter/foundation.dart';
import 'package:todoadvanced/data/models/task_model.dart';
import 'package:todoadvanced/data/services/database_service.dart';

class TaskViewModel extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<Task> _tasks = [];
  List<Task> get tasks => _tasks;

  List<Task> get pendingTasks => _tasks.where((task) => !task.isCompleted).toList();
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  TaskViewModel() {
    loadTasks();
  }

  void loadTasks() {
    _tasks = _dbService.getTasks();
    notifyListeners();
  }

  Future<void> addTask(Task task) async {
    await _dbService.addTask(task);
    loadTasks();
  }

  Future<void> updateTask(Task task) async {
    await _dbService.updateTask(task);
    loadTasks();
  }

  Future<void> deleteTask(String taskId) async {
    await _dbService.deleteTask(taskId);
    loadTasks();
  }

  void toggleTaskCompletion(Task task) {
    task.isCompleted = !task.isCompleted;
    updateTask(task);
  }
} 