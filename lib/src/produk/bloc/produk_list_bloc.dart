import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_it/common/api_provider.dart';
import 'package:shop_it/src/produk/model/produklist.dart';

part 'produk_list_event.dart';
part 'produk_list_state.dart';

class ProdukListBloc extends Bloc<ProdukListEvent, ProdukListState> {
  ApiProvider apiProvider = ApiProvider();
  ProdukListBloc() : super(ProdukListInitial()) {
    on<GetProduk>((event, emit) async {
      // TODO: implement event handler
      emit(ProdukListInitial());
      final list = await apiProvider.getAllProduk();
      emit(ProdukListLoaded(list));
    });
  }
}
