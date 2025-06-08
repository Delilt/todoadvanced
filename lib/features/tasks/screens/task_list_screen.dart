import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/data/models/category_model.dart';
import 'package:todoadvanced/features/tasks/viewmodels/task_viewmodel.dart';
import 'package:todoadvanced/features/tasks/widgets/task_list_item.dart';

class TaskListScreen extends StatelessWidget {
  final Category category;

  const TaskListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.name} Görevleri'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF2c2143), // Darker Deep Purple
              Color(0xFF1a1a1d), // Rich Charcoal Black
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Consumer<TaskViewModel>(
            builder: (context, viewModel, child) {
              final tasks = viewModel.tasks
                  .where((task) => task.categoryId == category.id)
                  .toList();

              if (tasks.isEmpty) {
                return const Center(
                  child: Text(
                    'Bu kategoride henüz görev yok.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return TaskListItem(task: task);
                },
              );
            },
          ),
        ),
      ),
    );
  }
} 