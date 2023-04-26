import 'package:flutter/material.dart';

import '../../../domain/models/cat_breeds_model.dart';
import '../../../domain/repositories/cat_repository.dart';
import 'home_state.dart';

class HomeProvider extends ChangeNotifier {
  HomeProvider({
    required this.catRepository,
  });
  HomeState _state = HomeLoading();
  final CatRepository catRepository;
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final List<CatModel> _catsIds = [];
  final List<CatModel> _cats = [];
  final FocusNode _focusNode = FocusNode();
  bool _isBottom = false;
  bool _isLoading = false;
  bool _isSearching = false;

  List<CatModel> get cats => _catsIds;
  HomeState get state => _state;
  bool get isBottom => _isBottom;
  bool get isLoading => _isLoading;
  bool get isSearching => _isSearching;
  ScrollController get scrollController => _scrollController;
  TextEditingController get searchController => _searchController;
  FocusNode get focusNode => _focusNode;

  init() async {
    _cats.addAll(await catRepository.getCats());
    _state = HomeInitial();
    notifyListeners();
    addFiveImages();
    _searchController.addListener(search);
    _scrollController.addListener(() {
      if (!_isLoading &&
          _scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          _catsIds.length < _cats.length &&
          !_isSearching) {
        loadNextPage();
      }
      if (_scrollController.position.pixels == 0 ||
          _scrollController.position.pixels < 0 ||
          _isSearching) {
        _isBottom = false;
        notifyListeners();
      } else {
        _isBottom = true;
        notifyListeners();
      }
    });
  }

  Future loadNextPage() async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    addFiveImages();
    _isLoading = false;
    notifyListeners();
    moveScrollToBottom();
  }

  void moveScrollToBottom() {
    if (_scrollController.position.pixels + 100 <=
        _scrollController.position.maxScrollExtent) return;
    _scrollController.animateTo(
      _scrollController.position.pixels + 120,
      duration: const Duration(milliseconds: 300),
      curve: Curves.fastOutSlowIn,
    );
  }

  void addFiveImages() {
    final end = (_catsIds.length + 5).clamp(0, _cats.length);
    final newCats = _cats.sublist(_catsIds.length, end);
    _catsIds.addAll(newCats);
    notifyListeners();
  }

  void upToTop() async {
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeInOut,
    );
    await Future.delayed(const Duration(milliseconds: 800));
    _catsIds.clear();
    _isSearching ? null : addFiveImages();
    notifyListeners();
  }

  void search() async {
    final String text = _searchController.text;
    if (text.isEmpty) {
      loadNextPage();
      return;
    }
    _state = HomeLoading();
    notifyListeners();
    await Future.delayed(const Duration(seconds: 1));
    final List<CatModel> cats = _cats
        .where((cat) => cat.name.toLowerCase().contains(text.toLowerCase()))
        .toList();
    _catsIds.clear();
    _catsIds.addAll(cats);
    await Future.delayed(const Duration(seconds: 1));
    _state = HomeInitial();
    notifyListeners();
  }

  void setSearching(bool value) {
    _isSearching = value;
    if (!value) {
      searchController.clear();
      moveScrollToBottom();
    }
    notifyListeners();
  }

  void unFoucs() {
    _focusNode.unfocus();
    notifyListeners();
  }
}
