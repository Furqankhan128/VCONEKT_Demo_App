

class CategoryModel {
  final List<String> _categories = [];

  CategoryModel.fromJson({parsedJson}) {
    for (var category in parsedJson) {
      _categories.add(category);
    }
  }

  List<String> get categories => _categories;
}


