import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';

class ReservationModel {
  final String userId;
  final List<ReservationForm> reservations;
  ReservationModel({
    required this.userId,
    required this.reservations,
  });

  ReservationModel copyWith({
    String? userId,
    List<ReservationForm>? reservations,
  }) {
    return ReservationModel(
      userId: userId ?? this.userId,
      reservations: reservations ?? this.reservations,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'reservations': reservations.map((x) => x.toMap()).toList(),
    };
  }

  factory ReservationModel.fromMap(Map<String, dynamic> map) {
    return ReservationModel(
      userId: map['userId'] as String,
      reservations: List<ReservationForm>.from(
        (map['reservations'] as List<int>).map<ReservationForm>(
          (x) => ReservationForm.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}
