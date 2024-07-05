import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/database_repository.dart';

import 'package:savoir/common/logger.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/util.dart';

final reservationFormProvider =
    StateNotifierProvider.autoDispose<ReservationFormState, ReservationForm>((ref) {
  return ReservationFormState(ref);
});

class ReservationForm {
  final DateTime reservationDate;
  final int numberOfPeople;
  final int durationHours;
  final String instructions;
  final String? restaurantId;

  ReservationForm({
    required this.reservationDate,
    required this.numberOfPeople,
    required this.durationHours,
    required this.instructions,
    required this.restaurantId,
  });

  ReservationForm copyWith({
    DateTime? reservationDate,
    int? numberOfPeople,
    int? durationHours,
    String? instrucciones,
    String? restaurantId,
  }) {
    return ReservationForm(
      reservationDate: reservationDate ?? this.reservationDate,
      numberOfPeople: numberOfPeople ?? this.numberOfPeople,
      durationHours: durationHours ?? this.durationHours,
      instructions: instrucciones ?? this.instructions,
      restaurantId: restaurantId ?? this.restaurantId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reservationDate': reservationDate.millisecondsSinceEpoch,
      'numberOfPeople': numberOfPeople,
      'durationHours': durationHours,
      'instructions': instructions,
      'restaurantId': restaurantId
    };
  }

  factory ReservationForm.fromMap(Map<String, dynamic> map) {
    return ReservationForm(
      reservationDate: DateTime.fromMillisecondsSinceEpoch(map['reservationDate'] as int),
      numberOfPeople: map['numberOfPeople'] as int,
      durationHours: map['durationHours'] as int,
      instructions: map['instructions'] as String,
      restaurantId: map['restaurantId'] as String,
    );
  }
}

class ReservationFormState extends StateNotifier<ReservationForm> {
  final Ref ref;
  ReservationFormState(this.ref)
      : super(ReservationForm(
            reservationDate: DateTime.now(),
            numberOfPeople: 2,
            durationHours: 1,
            instructions: '',
            restaurantId: ''));
  static final _logger = AppLogger.getLogger(ReservationFormState);

  void setRestaurantId(String restaurantId) {
    _logger.i('Setting restaurant id to $restaurantId');
    state = state.copyWith(restaurantId: restaurantId);
  }

  void incNumberOfPeople() {
    _logger.i('Incrementing number of people');
    state = state.copyWith(numberOfPeople: state.numberOfPeople < 5 ? state.numberOfPeople + 1 : 5);
  }

  void decNumberOfPeople() {
    _logger.i('Decrementing number of people');
    state = state.copyWith(numberOfPeople: state.numberOfPeople > 1 ? state.numberOfPeople - 1 : 1);
  }

  void incDurationHours() {
    _logger.i('Incrementing duration hours');
    state = state.copyWith(durationHours: state.durationHours < 3 ? state.durationHours + 1 : 3);
  }

  void decDurationHours() {
    _logger.i('Decrementing duration hours');
    state = state.copyWith(durationHours: state.durationHours > 1 ? state.durationHours - 1 : 1);
  }

  void withInstructions(String instrucciones) {
    _logger.i('Setting reservation instructions to $instrucciones');
    state = state.copyWith(instrucciones: instrucciones);
  }

  void setDateTime(DateTime dateTime) {
    _logger.i('Setting reservation date to $dateTime');
    state = state.copyWith(reservationDate: dateTime);
  }

  void setHourForReservation(String hour) {
    // convert time to DateTime
    final timeParts = hour.split(":");
    final newDateTime = state.reservationDate.add(
      Duration(hours: int.parse(timeParts[0]), minutes: int.parse(timeParts[1])),
    );
    state = state.copyWith(reservationDate: newDateTime);
  }

  void makeReservation() async {
    try {
      final user = ref.watch(userProvider);
      if (user == null) {
        return;
      }

      await ref.read(databaseRepositoryProvider).addReservation(state, user!.uid);
    } catch (e) {
      _logger.e('Error making reservation: $e');
    }
  }
}
