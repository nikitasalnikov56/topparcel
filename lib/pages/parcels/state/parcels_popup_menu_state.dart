import 'package:topparcel/data/models/response/fetch_declaration_response.dart';
import 'package:topparcel/data/models/response/fetch_documents_response.dart';
import 'package:topparcel/data/models/response/fetch_label_response.dart';

import '../../../data/models/response/fetch_invoice_response.dart';

class ParcelsPopupMenuState {
  final ParcelsPopupMenuStatus status;
  final FetchDocumentsResponse? document;
  final FetchLabelResponse? label;
  final FetchDeclarationResponse? declaration;
  final FetchInvoiceResponse? invoice;

  ParcelsPopupMenuState(
      {this.document,
      required this.status,
      this.label,
      this.declaration,
      this.invoice});

  ParcelsPopupMenuState copyWith({
    ParcelsPopupMenuStatus? status,
    FetchDocumentsResponse? document,
    FetchLabelResponse? label,
    FetchDeclarationResponse? declaration,
    FetchInvoiceResponse? invoice,
  }) {
    return ParcelsPopupMenuState(
      status: status ?? this.status,
      document: document ?? this.document,
      label: label ?? this.label,
      declaration: declaration ?? this.declaration,
      invoice: invoice ?? this.invoice,
    );
  }
}

abstract class ParcelsPopupMenuStatus {}

class ParcelsPopupMenuInitialStatus extends ParcelsPopupMenuStatus {}

class ParcelsPopupMenuLoadingStatus extends ParcelsPopupMenuStatus {}

class ParcelsPopupMenuErrorStatus extends ParcelsPopupMenuStatus {}

class LoadedDocumentsStatus extends ParcelsPopupMenuStatus {}

class LoadedLabelStatus extends ParcelsPopupMenuStatus {}

class LoadedDeclarationStatus extends ParcelsPopupMenuStatus {}

class LoadedInvoiceStatus extends ParcelsPopupMenuStatus {}
