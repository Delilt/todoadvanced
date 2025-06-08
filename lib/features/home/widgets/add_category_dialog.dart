import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoadvanced/data/models/category_model.dart';
import 'package:todoadvanced/features/home/viewmodels/home_viewmodel.dart';

void showAddCategoryDialog(BuildContext context) {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Yeni Kategori Ekle'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Kategori Adı'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Lütfen bir kategori adı girin';
              }
              return null;
            },
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('İptal'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text('Ekle'),
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final category = Category(name: nameController.text);
                Provider.of<HomeViewModel>(context, listen: false).addCategory(category);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
} 