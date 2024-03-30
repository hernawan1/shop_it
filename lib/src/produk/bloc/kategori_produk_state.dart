part of 'kategori_produk_bloc.dart';

sealed class KategoriProdukState extends Equatable {
  const KategoriProdukState();

  @override
  List<Object> get props => [];
}

final class KategoriProdukInitial extends KategoriProdukState {}

final class KategoriProdukLoading extends KategoriProdukState {}

final class KategoriProdukLoaded extends KategoriProdukState {
  final KategoriProdukModel kategoriProdukModel;
  const KategoriProdukLoaded(this.kategoriProdukModel);
}

final class KategoriProdukError extends KategoriProdukState {
  final String reason;
  const KategoriProdukError(this.reason);

  @override
  List<Object> get props => [reason];
}
