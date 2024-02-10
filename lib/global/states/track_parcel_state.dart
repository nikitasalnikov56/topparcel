part of '../cubits/track_parcel_cubit.dart';

class TrackParcelState {
  final TrackParcelStatus status;
  final List<Event> eventsList;
  final String email;

  TrackParcelState({
    required this.status,
    required this.eventsList,
    required this.email,
  });

  TrackParcelState copyWith({
    TrackParcelStatus? status,
    List<Event>? eventsList,
    String? email,
  }) {
    return TrackParcelState(
      status: status ?? this.status,
      eventsList: eventsList ?? this.eventsList,
      email: email ?? this.email,
    );
  }
}

abstract class TrackParcelStatus {}

class LoadingTrackParcelStatus extends TrackParcelStatus {}

class OkTrackParcelStatus extends TrackParcelStatus {}

class ErrorTrackParcelStatus extends TrackParcelStatus {}
