import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:topparcel/global/cubits/app_message_cubit.dart';
import 'package:topparcel/pages/parcels/state/parcels_popup_menu_state.dart';
import 'package:topparcel/interfaces/user_repository.dart';

class ParcelsPopupMenuCubit extends Cubit<ParcelsPopupMenuState> {
  ParcelsPopupMenuCubit({
    required UserRepository userRepository,
    required AppMessageCubit appMessageCubit,
  })  : _userRepository = userRepository,
        _appMessageCubit = appMessageCubit,
        super(ParcelsPopupMenuState(status: ParcelsPopupMenuInitialStatus()));

  UserRepository _userRepository;
  final AppMessageCubit _appMessageCubit;

  //popup menu actions
  void showDocuments(String email, int id) async {
    await _showDocuments(email, id);
  }

  void showLabel(String email, int id) async {
    await _showLabel(email, id);
  }

  void showDeclaration(String email, int id) async {
    await _showDeclaration(email, id);
  }

  void showInvoice(String email, int id) async {
    await _showInvoice(email, id);
  }

  //Network request

  Future<void> _showInvoice(String email, int id) async {
    try {
      emit(state.copyWith(status: ParcelsPopupMenuLoadingStatus()));
      final result = await _userRepository.fetchInvoice(email, id);
      final pdfPath = await _openPdfFile(result.pdf);
      _openPdf(pdfPath);
      emit(state.copyWith(invoice: result, status: LoadedInvoiceStatus()));
    } on DioError catch (e) {
      emit(state.copyWith(status: ParcelsPopupMenuErrorStatus()));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> _showDocuments(String email, int id) async {
    try {
      emit(state.copyWith(status: ParcelsPopupMenuLoadingStatus()));
      final result = await _userRepository.fetchDocuments(email, id);
      final pdfPath = await _openPdfFile(result.documents);
      _openPdf(pdfPath);
      emit(state.copyWith(document: result, status: LoadedDocumentsStatus()));
    } on DioError catch (e) {
      emit(state.copyWith(status: ParcelsPopupMenuErrorStatus()));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> _showLabel(String email, int id) async {
    try {
      emit(state.copyWith(status: ParcelsPopupMenuLoadingStatus()));
      final result = await _userRepository.fetchLabel(email, id);
      final pdfPath = await _openPdfFile(result.label);
      _openPdf(pdfPath);
      emit(state.copyWith(label: result, status: LoadedLabelStatus()));
    } on DioError catch (e) {
      emit(state.copyWith(status: ParcelsPopupMenuErrorStatus()));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }

  Future<void> _showDeclaration(String email, int id) async {
    try {
      emit(state.copyWith(status: ParcelsPopupMenuLoadingStatus()));
      final result = await _userRepository.fetchDeclaration(email, id);
      final pdfPath = await _openPdfFile(result.documents);
      _openPdf(pdfPath);
      emit(state.copyWith(
          declaration: result, status: LoadedDeclarationStatus()));
    } on DioError catch (e) {
      emit(state.copyWith(status: ParcelsPopupMenuErrorStatus()));
      _appMessageCubit.showDioErrorMessage(e);
    }
  }
}

Future<String> _openPdfFile(String encodedString) async {
  final bytes = File(await _createPdfFile(encodedString)).readAsBytesSync();
  final dir = await getTemporaryDirectory();
  final file = File('${dir.path}/document.pdf');
  await file.writeAsBytes(bytes);
  return file.path;
}

Future<String> _createPdfFile(String encodedString) async {
  Uint8List bytes = base64.decode(encodedString);
  String dir = (await getApplicationCacheDirectory()).path;
  File file = File("$dir/" + DateTime.now().toString() + ".pdf");
  await file.writeAsBytes(bytes);
  return file.path;
}

void _openPdf(String path) async {
  if (path != null) {
    await OpenFile.open(path);
  }
}
