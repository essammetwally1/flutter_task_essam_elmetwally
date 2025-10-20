// lib/providers/product_provider.dart
import 'package:flutter/material.dart';
import 'package:flutter_task_essam_elmetwally/models/product_model.dart';
import '../services/db_helper.dart';

class ProductProvider extends ChangeNotifier {
  final DBHelper _db = DBHelper.instance;
  List<Product> allProducts = [];
  List<Product> filterdProducts = [];
  bool _loading = true;

  bool get loading => _loading;

  Future<void> loadProducts() async {
    _setLoading(true);
    try {
      allProducts = await _db.getAllProducts();

      if (allProducts.isEmpty) {
        await _insertSampleData();
        allProducts = await _db.getAllProducts();
      }

      filterdProducts = List<Product>.from(allProducts);
    } catch (e) {
      allProducts = [];
      filterdProducts = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<void> refresh() async {
    await loadProducts();
  }

  Future<void> seedSampleData({bool force = false}) async {
    _setLoading(true);
    try {
      final existing = await _db.getAllProducts();
      if (existing.isNotEmpty && !force) {
        allProducts = existing;
        filterdProducts = List<Product>.from(allProducts);
      } else {
        if (force) {
          await _db.clearAll();
        }
        await _insertSampleData();
        allProducts = await _db.getAllProducts();
        filterdProducts = List<Product>.from(allProducts);
      }
    } finally {
      _setLoading(false);
    }
  }

  Future<void> clearAllProducts() async {
    _setLoading(true);
    try {
      await _db.clearAll();
      allProducts = [];
      filterdProducts = [];
    } finally {
      _setLoading(false);
    }
  }

  Future<List<Product>> filterByCategory(String? category) async {
    _setLoading(true);
    try {
      if (category == null ||
          category.trim().isEmpty ||
          category == 'كل العروض') {
        filterdProducts = List<Product>.from(allProducts);
      } else {
        filterdProducts = allProducts
            .where((p) => p.category == category)
            .toList(growable: false);
      }
      notifyListeners();
      return List<Product>.from(filterdProducts);
    } finally {
      _setLoading(false);
    }
  }

  void _setLoading(bool v) {
    _loading = v;
    notifyListeners();
  }

  Future<void> _insertSampleData() async {
    final sample = <Product>[
      Product(
        title: 'جاكيت من الصوف مناسب للشتاء - تصميم مريح وعصري',
        imagePath: 'assets/images/item1.png',
        price: '32,000,000 جم',
        oldPrice: '60 جم',
        soldCount: 'تم بيع 3.3k+',
        category: 'ملابس',
      ),
      Product(
        title: 'جاكيت من الصوف مناسب للشتاء - تصميم مريح وعصري',
        imagePath: 'assets/images/item2.png',
        price: '32,000,000 جم',
        oldPrice: '60 جم',
        soldCount: 'تم بيع 3.3k+',
        category: 'ملابس',
      ),
      Product(
        title: 'حذاء رياضي أسود مع خطوط خضراء',
        imagePath: 'assets/images/item3.png',
        price: '32,000,000 جم',
        oldPrice: '60 جم',
        soldCount: 'تم بيع 1.2k+',
        category: 'ملابس',
      ),
      Product(
        title: 'ساعة يد أنيقة',
        imagePath: 'assets/images/image2.png',
        price: '12,000 جم',
        oldPrice: '20,000 جم',
        soldCount: 'تم بيع 900+',
        category: 'ساعات',
      ),
      Product(
        title: 'جاكيت من الصوف مناسب للشتاء - تصميم مريح وعصري',
        imagePath: 'assets/images/item1.png',
        price: '32,000,000 جم',
        oldPrice: '60 جم',
        soldCount: 'تم بيع 3.3k+',
        category: 'ملابس',
      ),
      Product(
        title: 'حذاء رياضي أسود مع خطوط خضراء',
        imagePath: 'assets/images/item3.png',
        price: '32,000,000 جم',
        oldPrice: '60 جم',
        soldCount: 'تم بيع 1.2k+',
        category: 'ملابس',
      ),
      Product(
        title: 'منتجات تجميل',
        imagePath: 'assets/images/image6.png',
        price: '12,000 جم',
        oldPrice: '20,000 جم',
        soldCount: 'تم بيع 900+',
        category: 'منتجات تجميل',
      ),
      Product(
        title: 'منتجات تجميل',
        imagePath: 'assets/images/image6.png',
        price: '12,000 جم',
        oldPrice: '20,000 جم',
        soldCount: 'تم بيع 900+',
        category: 'منتجات تجميل',
      ),
    ];

    for (final p in sample) {
      await _db.insertProduct(p);
    }
  }
}
