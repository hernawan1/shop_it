import 'package:bloc/bloc.dart';
import 'package:shop_it/common/api_provider.dart';
import 'package:shop_it/common/shared_prefs_services.dart';
import 'package:shop_it/src/auth/model/login_model.dart';
import 'package:equatable/equatable.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  ApiProvider apiProvider = ApiProvider();

  Future<void> login() async {
    try {
      emit(AuthLoading());
      LoginModel loginModel = await apiProvider.login();
      SharedPrefsServices()
          .saveToken(loginModel.access_token, loginModel.refresh_token);
      emit(AuthLogin(loginModel));
    } catch (e) {
      throw Exception(e);
      // emit(AuthError(e.toString()));
    }
  }
}
