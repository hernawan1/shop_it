import 'package:shop_it/src/produk/model/kategori_produk.dart';

class ProdukModel {
  List<ProdukList>? produkList;
  String? error;

  ProdukModel({this.produkList});

  ProdukModel.withError(String errorMessage) {
    error = errorMessage;
  }

  ProdukModel.fromJson(json) {
    produkList = [];
    json.forEach((v) {
      produkList!.add(ProdukList.fromJson(v));
    });
  }
}

class ProdukList {
  int? id;
  String? title;
  int? price;
  String? description;
  List<String>? images;
  KategoriProduk? category;

  ProdukList({
    this.id,
    this.title,
    this.price,
    this.description,
    this.images,
    this.category,
  });

  ProdukList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    description = json['description'];
    images = json['images'].cast<String>();
    category = json['category'] != null
        ? new KategoriProduk.fromJson(json['category'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['images'] = this.images;
    if (category != null) {
      data['category'] = this.category!.toJson();
    }
    return data;
  }
}
