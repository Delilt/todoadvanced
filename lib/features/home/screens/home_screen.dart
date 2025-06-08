import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/features/home/viewmodels/home_viewmodel.dart';
import 'package:todoadvanced/features/home/widgets/add_category_dialog.dart';
import 'package:todoadvanced/features/home/widgets/category_card.dart';
import 'package:todoadvanced/features/tasks/screens/task_list_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhatToDo ?',style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Text(
                  'Lütfen eklemek istediğiniz görev kategorilerini seçiniz',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.white),
                ),
              ),
              Expanded(
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, child) {
                    if (viewModel.categories.isEmpty) {
                      return const Center(
                          child: Text(
                        'Henüz kategori eklenmemiş.',
                        style: TextStyle(color: Colors.white),
                      ));
                    }
                    return GridView.builder(
                      padding: const EdgeInsets.all(8.0),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8.0,
                        mainAxisSpacing: 8.0,
                        childAspectRatio: 1.2,
                      ),
                      itemCount: viewModel.categories.length,
                      itemBuilder: (context, index) {
                        final category = viewModel.categories[index];
                        return CategoryCard(
                          category: category,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => TaskListScreen(category: category),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: ElevatedButton(
                  onPressed: () => showAddCategoryDialog(context),
                  child: const Text('Yeni Bir Kategori Ekle'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
} 