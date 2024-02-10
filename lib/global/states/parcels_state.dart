// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../cubits/parcels_cubit.dart';

class ParcelsState {
  final ParcelsStatus status;
  final List<Country> countriesList;
  final List<ParcelResponse> newRates;
  final Courier selecteCourier;
  final List<ParcelModel> parcelsList;
  final OrderingStepOneModel? stepOne;
  final List<ParcelContentModel>? itemsList;
  final bool isInsuarance;
  final String email;

  ParcelsState({
    required this.status,
    required this.countriesList,
    required this.newRates,
    required this.parcelsList,
    required this.selecteCourier,
    required this.isInsuarance,
    this.itemsList,
    this.stepOne,
    required this.email,
  });

  ParcelsState copyWith({
    ParcelsStatus? status,
    Courier? selecteCourier,
    List<Country>? countriesList,
    List<ParcelResponse>? ratesList,
    List<ParcelModel>? parcelsList,
    OrderingStepOneModel? stepOne,
    List<ParcelContentModel>? itemsList,
    bool? isInsuarance,
    String? email,
  }) {
    return ParcelsState(
      status: status ?? this.status,
      selecteCourier: selecteCourier ?? this.selecteCourier,
      countriesList: countriesList ?? this.countriesList,
      newRates: ratesList ?? this.newRates,
      parcelsList: parcelsList ?? this.parcelsList,
      stepOne: stepOne ?? this.stepOne,
      itemsList: itemsList ?? this.itemsList,
      isInsuarance: isInsuarance ?? this.isInsuarance,
      email: email ?? this.email,
    );
  }
}

abstract class ParcelsStatus {}

class LoadingParcelsStatus extends ParcelsStatus {}

class OrderingStepOneStatus extends ParcelsStatus {}

class OrderingStepTwoStatus extends ParcelsStatus {}

class OrderingStepThreeStatus extends ParcelsStatus {}

class OrderingPayStatus extends ParcelsStatus {}

class CreateParcelStatus extends ParcelsStatus {
  final StepParcel step;
  final TypePayment typePayment;

  CreateParcelStatus({
    required this.step,
    this.typePayment = TypePayment.payPall,
  });
}

class SuccessPaymentStatus extends ParcelsStatus {}

class OkParcelsStatus extends ParcelsStatus {}

class RateParcelsStatus extends ParcelsStatus {}

class ErrorPaymentCreateParcelsStatus extends ParcelsStatus {}

class SuccessPaymentCreateParcelsStatus extends ParcelsStatus {}
