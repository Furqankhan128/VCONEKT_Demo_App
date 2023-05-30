abstract class CategoryEvent {}

class GetCategories extends CategoryEvent {
  GetCategories();
}

class ResetCategories extends CategoryEvent {
  ResetCategories();
}
