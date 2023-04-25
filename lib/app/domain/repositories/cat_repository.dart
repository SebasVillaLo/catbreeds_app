import '../models/cat_breeds_model.dart';

abstract class CatRepository {
  Future<List<CatModel>> getCats();
}
