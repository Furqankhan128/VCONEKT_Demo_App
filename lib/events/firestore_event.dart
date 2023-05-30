

abstract class FireStoreEvent {}

class GetFireStoreProducts extends FireStoreEvent {
  GetFireStoreProducts();
}

class CreateProduct extends FireStoreEvent {
  final String name;
  final String price;
  CreateProduct({required this.name,required this.price});
}

class UpdateProduct extends FireStoreEvent {
  final String productId;
  final String name;
  final String price;
  UpdateProduct({required this.name,required this.price, required this.productId});
}

class DeleteProduct extends FireStoreEvent {
  final String productId;
  DeleteProduct({required this.productId});
}


class ResetFireStoreProducts extends FireStoreEvent {
  ResetFireStoreProducts();
}
