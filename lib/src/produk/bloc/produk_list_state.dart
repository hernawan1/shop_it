part of 'produk_list_bloc.dart';

sealed class ProdukListState extends Equatable {
  const ProdukListState();

  @override
  List<Object> get props => [];
}

final class ProdukListInitial extends ProdukListState {}

final class ProdukListLoading extends ProdukListState {}

final class ProdukListLoaded extends ProdukListState {
  final ProdukModel produkModel;
  const ProdukListLoaded(this.produkModel);
}

final class ProdukListErorr extends ProdukListState {
  final String reason;
  const ProdukListErorr(this.reason);

  @override
  List<Object> get props => [reason];
}
