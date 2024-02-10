import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
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
import 'package:topparcel/data/models/response/create_parcel_response.dart';
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

part 'user_api.g.dart';

@RestApi()
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @POST('api/country')
  Future<FetchCountryResponse> fetchCountryList(
      @Body() FetchCountryRequest requestModel);

  @POST('api/parcel')
  Future<FetchParcelsResponse> fetchParcelsList(
      @Body() FetchParcelsRequest requestModel);

  @POST('api/rate')
  Future<CreaterateResponse> createRate(@Body() CreaterateRequest requestModel);

  @POST('api/importParcels')
  Future<CreateParcelResponse> createParcel(
      @Body() CreateParcelRequest requestModel);

  @POST('api/topup')
  Future<CreatePayResponse> createPay(@Body() CreatePayRequest requestModel);

  @POST('api/trackParcel')
  Future<TrackingNumberResponse> trackingNumber(
      @Body() TrackingNumberRequest requestModel);

  @POST('api/docs')
  Future<FetchDocumentsResponse> fetchDocuments(
      @Body() FetchDocumentsRequest requestModel);

  @POST('api/label')
  Future<FetchLabelResponse> fetchLabel(@Body() FetchLabelRequest requestModel);

  @POST('api/declaration')
  Future<FetchDeclarationResponse> fetchDeclaration(
      @Body() FetchDeclarationRequest requestModel);

  @POST('api/user')
  Future<UserDetailsResponse> fetchUserDetails(
      @Body() UserDetailsRequest requestModel);

  @POST('api/address')
  Future<UserAddressesResponse> fetchUserAddresses(
      @Body() UserAddressesRequest requestModel);

  @POST('api/updateUser')
  Future<UpdateUserResponse> updateUser(@Body() UpdateUserRequest requestModel);

  @POST('api/saveAddress')
  Future<UpdateUserResponse> createAddress(
      @Body() CreateAddressRequest requestModel);

  @POST('api/invoice')
  Future<FetchInvoiceResponse> fetchInvoice(
      @Body() FetchInvoiceRequest requestModel);
}
