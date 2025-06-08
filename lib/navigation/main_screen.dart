import 'package:flutter/material.dart';
import 'package:todoadvanced/features/home/screens/home_screen.dart';
import 'package:todoadvanced/features/tasks/screens/completed_tasks_screen.dart';
import 'package:todoadvanced/features/tasks/screens/pending_tasks_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 1; // Start with the home screen

  static const List<Widget> _widgetOptions = <Widget>[
    PendingTasksScreen(),
    HomeScreen(),
    CompletedTasksScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        elevation: 0,
        shape: const CircularNotchedRectangle(),
        notchMargin: 8.0,
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 0 ? Theme.of(context).primaryColor.withOpacity(0.10) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.pending_actions),
                  onPressed: () => _onItemTapped(0),
                  color: _selectedIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ),
              const SizedBox(width: 48), // The space for the FAB
              Container(
                decoration: BoxDecoration(
                  color: _selectedIndex == 2 ? Theme.of(context).primaryColor.withOpacity(0.15) : Colors.transparent,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(Icons.check_circle),
                  onPressed: () => _onItemTapped(2),
                  color: _selectedIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _onItemTapped(1),
        elevation: 2.0,
        backgroundColor: _selectedIndex == 1 ? Theme.of(context).primaryColor : const Color.fromARGB(255, 255, 255, 255),
        child: const Icon(Icons.home),
      ),
    );
  }
} 