import 'package:bloc/bloc.dart';
import 'package:topparcel/data/local_db/email_storage.dart';
import 'package:topparcel/data/local_db/token_storage.dart';
import 'package:topparcel/data/models/response/create_hscode_response.dart';
import 'package:topparcel/data/network/hscode_api.dart';

part '../states/hscode_state.dart';

class HscodeCubit extends Cubit<HscodeState> {
  HscodeCubit({required this.emailStorage, required this.tokenStorage})
      : super(HscodeInitial());
  final EmailStorage emailStorage;
  final TokenStorage tokenStorage;
  Future<void> getHSCodes(String code) async {
    try {
      final hscodeResponse = await HScodeApi.getHSCodesList(
          emailStorage.email, tokenStorage.token, code);
      emit(HscodeLoadedState(hscodeResponse));
    } catch (e) {
      emit(HscodeErrorState('Failed to load data. Error: $e'));
    }
  }
}
