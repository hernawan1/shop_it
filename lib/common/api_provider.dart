import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart' show ChangeNotifier;
import 'package:shop_it/src/auth/model/login_model.dart';
import 'package:shop_it/src/produk/model/kategori_produk.dart';
import 'package:shop_it/src/produk/model/produklist.dart';

class ApiProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<LoginModel> login() async {
    try {
      Response response = await _dio.post(
        // ignore: prefer_interpolation_to_compose_strings
        _baseUrl + '/auth/login',
        data: {"email": "john@mail.com", "password": "changeme"},
      );
      return LoginModel.fromJson(response.data);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<KategoriProdukModel> getKategoriProduk() async {
    try {
      Response response = await _dio.get(_baseUrl + '/categories');
      print(response.data);
      return KategoriProdukModel.fromJson(response.data);
    } catch (error) {
      throw Exception(error);
    }
  }

  Future<ProdukModel> getAllProduk() async {
    try {
      Response response = await _dio.get(_baseUrl + '/products');
      print(response.data.length);
      return ProdukModel.fromJson(response.data);
    } catch (error) {
      throw Exception(error);
    }
  }
}
