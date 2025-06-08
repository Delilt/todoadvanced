import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/data/models/task_model.dart';
import 'package:todoadvanced/features/tasks/viewmodels/task_viewmodel.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  const TaskListItem({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TaskViewModel>(context, listen: false);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: task.isCompleted ? Colors.green.withOpacity(0.2) : Colors.black.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            color: Colors.white,
            decoration: task.isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
          ),
        ),
        trailing: WaterDropButton(
          isCompleted: task.isCompleted,
          onTap: () {
            viewModel.toggleTaskCompletion(task);
          },
        ),
      ),
    );
  }
}

class WaterDropButton extends StatefulWidget {
  final bool isCompleted;
  final VoidCallback onTap;

  const WaterDropButton({super.key, required this.isCompleted, required this.onTap});

  @override
  State<WaterDropButton> createState() => _WaterDropButtonState();
}

class _WaterDropButtonState extends State<WaterDropButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    widget.onTap();
    _controller.forward().then((_) => _controller.reverse());
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: widget.isCompleted ? Colors.red : Colors.green,
            shape: BoxShape.circle,
          ),
          child: Icon(
            widget.isCompleted ? Icons.close : Icons.check,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
} 