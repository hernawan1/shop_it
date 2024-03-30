import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_it/common/api_provider.dart';
import 'package:shop_it/src/produk/model/kategori_produk.dart';

part 'kategori_produk_event.dart';
part 'kategori_produk_state.dart';

class KategoriProdukBloc
    extends Bloc<KategoriProdukEvent, KategoriProdukState> {
  final ApiProvider apiProvider = ApiProvider();
  KategoriProdukBloc() : super(KategoriProdukInitial()) {
    on<KategoriProdukList>((event, emit) async {
      // TODO: implement event handler
      emit(KategoriProdukInitial());
      final list = await apiProvider.getKategoriProduk();
      emit(KategoriProdukLoaded(list));
    });
  }
}
