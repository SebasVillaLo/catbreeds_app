// import 'dart:developer' as developer;

import 'package:dio/dio.dart';

import '../../domain/models/cat_breeds_model.dart';

class TheCatApi {
  final _dio = Dio();

  Future<List<CatModel>> getCats() async {
    final header = {'x-api-key': 'bda53789-d59e-46cd-9bc4-2936630fde39'};
    try {
      final response = await _dio.get(
        'https://api.thecatapi.com/v1/breeds',
        options: Options(headers: header),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        final List<Map<String, dynamic>> dataMap =
            List<Map<String, dynamic>>.from(data);
        final List<CatModel> cats = dataMap
            .map((Map<String, dynamic> e) => CatModel.fromJson(e))
            .toList();
        for (var element in cats) {
          element.urlImage =
              'https://cdn2.thecatapi.com/images/${element.referenceImageId}.jpg';
        }
        cats.removeWhere((element) => element.referenceImageId.isEmpty);
        return cats;
      }
    } catch (e) {
      rethrow;
    }
    return [];
  }
}
