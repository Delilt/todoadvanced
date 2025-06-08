import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/features/tasks/viewmodels/task_viewmodel.dart';
import 'package:todoadvanced/features/tasks/widgets/task_list_item.dart';

class CompletedTasksScreen extends StatelessWidget {
  const CompletedTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tamamlanmış Görevler',style: TextStyle(color: Colors.white),),
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
              final completedTasks = viewModel.completedTasks;

              if (completedTasks.isEmpty) {
                return const Center(
                  child: Text(
                    'Henüz tamamlanmış görev yok.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: completedTasks.length,
                itemBuilder: (context, index) {
                  final task = completedTasks[index];
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