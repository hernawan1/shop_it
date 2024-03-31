part of 'search_produk_bloc.dart';

sealed class SearchProdukState extends Equatable {
  const SearchProdukState();
  
  @override
  List<Object> get props => [];
}

final class SearchProdukInitial extends SearchProdukState {}


final class SearchProdukLoading extends SearchProdukState {}

final class SearchProdukLoaded extends SearchProdukState {
  final ProdukModel produkModel;
  const SearchProdukLoaded(this.produkModel);
}

final class SearchProdukError extends SearchProdukState {
  final String reason;
  const SearchProdukError(this.reason);

  @override
  List<Object> get props => [reason];
}