import 'package:topparcel/data/models/requests/create_address_request.dart';
import 'package:topparcel/data/models/requests/create_parcel_request.dart';
import 'package:topparcel/data/models/requests/create_rate_request.dart';
import 'package:topparcel/data/models/requests/fetch_addresses_request.dart';
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

abstract class UserRepository {
  Future<FetchCountryResponse> fetchCountryList(String email);
  Future<List<ParcelModel>> fetchParcels(String email);
  Future<TrackingNumberResponse> trackingNumber(
      String trackNumber, String email);
  Future<CreaterateResponse> createRate(
      List<Parcel> requestModel, String email);
  Future<CreatePayResponse> createPay(String email, int typeId, int amount);
  Future<int> createParcels(ParcelsRequest model, String email);
  Future<FetchDocumentsResponse> fetchDocuments(String email, int id);
  Future<FetchLabelResponse> fetchLabel(String email, int id);
  Future<FetchDeclarationResponse> fetchDeclaration(String email, int id);
  Future<UserDetailsResponse> fetchUserDetails(UserDetailsRequest requestModel);
  Future<UpdateUserResponse> updateUser(UpdateUserRequest requestModel);
  Future<UpdateUserResponse> createAddress(CreateAddressRequest requestModel);
  Future<FetchInvoiceResponse> fetchInvoice(String email, int id);
  Future<UserAddressesResponse> fetchUserAddresses(
      UserAddressesRequest requestModel);
}
