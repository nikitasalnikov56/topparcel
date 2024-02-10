import 'package:topparcel/data/local_db/token_storage.dart';
import 'package:topparcel/data/models/requests/create_address_request.dart';
import 'package:topparcel/data/models/requests/create_parcel_request.dart';
import 'package:topparcel/data/models/requests/create_payment_request.dart';
import 'package:topparcel/data/models/requests/create_rate_request.dart';
import 'package:topparcel/data/models/requests/fetch_addresses_request.dart';
import 'package:topparcel/data/models/requests/fetch_country_request.dart';
import 'package:topparcel/data/models/requests/fetch_declaration_request.dart';
import 'package:topparcel/data/models/requests/fetch_documents_request.dart';
import 'package:topparcel/data/models/requests/fetch_label_request.dart';
import 'package:topparcel/data/models/requests/fetch_invoice_request.dart';
import 'package:topparcel/data/models/requests/fetch_parcels_request.dart';
import 'package:topparcel/data/models/requests/tracking_number_request.dart';
import 'package:topparcel/data/models/requests/update_user_request.dart';
import 'package:topparcel/data/models/requests/user_details_request.dart';
import 'package:topparcel/data/models/response/create_pay_response.dart';
import 'package:topparcel/data/models/response/create_rate_response.dart';
import 'package:topparcel/data/models/response/fetch_addresses_response.dart';
import 'package:topparcel/data/models/response/fetch_country_response.dart';
import 'package:topparcel/data/models/response/fetch_declaration_response.dart';
import 'package:topparcel/data/models/response/fetch_documents_response.dart';
import 'package:topparcel/data/models/response/fetch_label_response.dart';
import 'package:topparcel/data/models/response/fetch_invoice_response.dart';
import 'package:topparcel/data/models/response/fetch_parcels_response.dart';
import 'package:topparcel/data/models/response/tracking_number_response.dart';
import 'package:topparcel/data/models/response/update_user_response.dart';
import 'package:topparcel/data/models/response/user_details_response.dart';
import 'package:topparcel/interfaces/user_repository.dart';

import '../data/network/user_api.dart';

class UserRepositoryImpl extends UserRepository {
  final UserApi userAPI;
  final TokenStorage tokenStorage;
  UserRepositoryImpl({
    required this.userAPI,
    required this.tokenStorage,
  });

  @override
  Future<UserAddressesResponse> fetchUserAddresses(
      UserAddressesRequest model) async {
    try {
      UserAddressesRequest requestModel = UserAddressesRequest(
        email: model.email,
        password: tokenStorage.token,
      );
      final result = await userAPI.fetchUserAddresses(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FetchCountryResponse> fetchCountryList(String email) async {
    try {
      FetchCountryRequest requestModel = FetchCountryRequest(
        email: email,
        token: tokenStorage.token,
      );
      final result = await userAPI.fetchCountryList(requestModel);

      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<TrackingNumberResponse> trackingNumber(
      String trackNumber, String email) async {
    try {
      TrackingNumberRequest requestModel = TrackingNumberRequest(
          email: email, token: tokenStorage.token, track: trackNumber);
      final result = await userAPI.trackingNumber(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreaterateResponse> createRate(
      List<Parcel> parcelsList, String email) async {
    final requestModel = CreaterateRequest(
        email: email, token: tokenStorage.token, parcelsList: parcelsList);
    try {
      final result = await userAPI.createRate(requestModel);

      return result;
    } catch (e) {
      // print('Error during createRate: $e');
      rethrow;
    }
  }

  @override
  Future<List<ParcelModel>> fetchParcels(String email) async {
    try {
      final requstModel = FetchParcelsRequest(
          email: email, token: tokenStorage.token, currency: 'GBP');
      final result = await userAPI.fetchParcelsList(requstModel);
      return result.parcelsList;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<int> createParcels(ParcelsRequest model, String email) async {
    try {
      final requestModel = CreateParcelRequest(
          email: email, token: tokenStorage.token, parcels: model);
      final result = await userAPI.createParcel(requestModel);
      return result.status;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FetchInvoiceResponse> fetchInvoice(String email, int id) async {
    try {
      final requestModel = FetchInvoiceRequest(
        email: email,
        token: tokenStorage.token,
        id: id,
        currency: 'GBP',
      );
      final result = await userAPI.fetchInvoice(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserDetailsResponse> fetchUserDetails(UserDetailsRequest model) async {
    final requestModel = UserDetailsRequest(
        email: model.email, password: tokenStorage.token, currency: 'GBP');
    try {
      final result = await userAPI.fetchUserDetails(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdateUserResponse> updateUser(UpdateUserRequest model) async {
    final requestModel = UpdateUserRequest(
      email: model.email,
      password: tokenStorage.token,
      firstname: model.firstname,
      lastname: model.lastname,
      addressLine1: model.addressLine1,
      addressLine2: model.addressLine2,
      countryId: model.countryId,
      county: model.county,
      phone: model.phone,
      postcode: model.postcode,
      city: model.city,
    );

    try {
      final result = await userAPI.updateUser(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CreatePayResponse> createPay(
      String email, int typeId, int amount) async {
    try {
      final requestModel = CreatePayRequest(
        email: email,
        token: tokenStorage.token,
        amount: amount,
        typeId: typeId,
      );
      final result = await userAPI.createPay(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FetchDocumentsResponse> fetchDocuments(String email, int id) async {
    try {
      final requestModel = FetchDocumentsRequest(
        email: email,
        token: tokenStorage.token,
        id: id,
      );
      final result = await userAPI.fetchDocuments(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FetchLabelResponse> fetchLabel(String email, int id) async {
    try {
      final requestModel = FetchLabelRequest(
        email: email,
        token: tokenStorage.token,
        id: id,
      );
      final result = await userAPI.fetchLabel(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<FetchDeclarationResponse> fetchDeclaration(
      String email, int id) async {
    try {
      final requestModel = FetchDeclarationRequest(
        email: email,
        token: tokenStorage.token,
        id: id,
      );
      final result = await userAPI.fetchDeclaration(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UpdateUserResponse> createAddress(
      CreateAddressRequest requestModel) async {
    try {
      final requestModelNew = requestModel;
      requestModelNew.token = tokenStorage.token;
      final result = await userAPI.createAddress(requestModel);
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
