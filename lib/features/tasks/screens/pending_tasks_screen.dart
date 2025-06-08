import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/features/tasks/viewmodels/task_viewmodel.dart';
import 'package:todoadvanced/features/tasks/widgets/task_list_item.dart';

class PendingTasksScreen extends StatelessWidget {
  const PendingTasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bekleyen Görevler',style: TextStyle(color: Colors.white),),
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
              final pendingTasks = viewModel.pendingTasks;

              if (pendingTasks.isEmpty) {
                return const Center(
                  child: Text(
                    'Bekleyen görev bulunmamaktadır.',
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.only(top: 16),
                itemCount: pendingTasks.length,
                itemBuilder: (context, index) {
                  final task = pendingTasks[index];
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