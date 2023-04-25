import 'package:flutter/material.dart';

import '../../../domain/models/cat_breeds_model.dart';
import '../../../domain/repositories/cat_repository.dart';
import 'home_state.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.catRepository,
  });
  final CatRepository catRepository;
  HomeState _state = HomeLoading();

  final List<CatModel> _cats = [];

  List<CatModel> get cats => _cats;
  HomeState get state => _state;

  init() async {
    _cats.addAll(await catRepository.getCats());
    _state = HomeInitial();
    notifyListeners();
  }
}
