part of 'search_produk_bloc.dart';

sealed class SearchProdukEvent extends Equatable {
  const SearchProdukEvent();

  @override
  List<Object> get props => [];
}

class SearchProdukName extends SearchProdukEvent {
  final String title;
  SearchProdukName(this.title);
}
