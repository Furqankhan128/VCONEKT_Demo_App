

abstract class ProductEvent {}

class GetProducts extends ProductEvent {
  GetProducts();
}

class GetProductsByCategory extends ProductEvent {
  final String? category;
  GetProductsByCategory({required this.category});
}


class ResetProducts extends ProductEvent {
  ResetProducts();
}
