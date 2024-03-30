import 'package:flutter/src/widgets/container.dart';

class KategoriProdukModel {
  List<KategoriProduk>? dataKategori;
  String? error;

  KategoriProdukModel({this.dataKategori});

  KategoriProdukModel.withError(String errorMessage) {
    error = errorMessage;
  }

  KategoriProdukModel.fromJson(json) {
    dataKategori = [];
    json.forEach((v) {
      dataKategori!.add(KategoriProduk.fromJson(v));
    });
  }

  map(Set<Container> Function(dynamic e) param0) {}
}

class KategoriProduk {
  int? id;
  String? name;
  KategoriProduk({
    this.id,
    this.name,
  });

  KategoriProduk.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
