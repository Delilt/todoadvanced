import 'package:flutter/foundation.dart' hide Category;
import 'package:todoadvanced/data/models/category_model.dart';
import 'package:todoadvanced/data/services/database_service.dart';

class HomeViewModel extends ChangeNotifier {
  final DatabaseService _dbService = DatabaseService();

  List<Category> _categories = [];
  List<Category> get categories => _categories;

  HomeViewModel() {
    _loadCategories();
  }

  void _loadCategories() {
    _categories = _dbService.getCategories();
    // Add some default categories if the box is empty
    if (_categories.isEmpty) {
      addCategory(Category(name: 'İş'));
      addCategory(Category(name: 'Kişisel'));
      addCategory(Category(name: 'Alışveriş'));
    }
    notifyListeners();
  }

  Future<void> addCategory(Category category) async {
    await _dbService.addCategory(category);
    _loadCategories(); // Reload to get the updated list
  }

  Future<void> deleteCategory(String categoryId) async {
    await _dbService.deleteCategory(categoryId);
    _loadCategories(); // Reload to get the updated list
  }
} 