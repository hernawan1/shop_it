part of 'produk_list_bloc.dart';

sealed class ProdukListEvent extends Equatable {
  const ProdukListEvent();

  @override
  List<Object> get props => [];
}

class GetProduk extends ProdukListEvent {}
