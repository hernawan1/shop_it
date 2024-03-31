import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shop_it/common/api_provider.dart';
import 'package:shop_it/src/produk/model/produklist.dart';

part 'search_produk_event.dart';
part 'search_produk_state.dart';

class SearchProdukBloc extends Bloc<SearchProdukEvent, SearchProdukState> {
  ApiProvider apiProvider = ApiProvider();
  SearchProdukBloc() : super(SearchProdukInitial()) {
    on<SearchProdukEvent>((event, emit) async {
      // TODO: implement event handler
      if (event is SearchProdukName) {
        emit(SearchProdukInitial());
        final list = await apiProvider.searchProduk(event.title);
        emit(SearchProdukLoaded(list));
      }
    });
  }
}
