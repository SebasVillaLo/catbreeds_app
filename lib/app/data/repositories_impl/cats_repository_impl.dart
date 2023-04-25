import '../../domain/models/cat_breeds_model.dart';
import '../../domain/repositories/cat_repository.dart';
import '../services/the_cat_api.dart';

class CatsRepositoryImpl implements CatRepository {
  CatsRepositoryImpl(this._theCatApi);

  final TheCatApi _theCatApi;
  @override
  Future<List<CatModel>> getCats() {
    return _theCatApi.getCats();
  }
}
