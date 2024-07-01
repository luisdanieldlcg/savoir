class StatsModel {
  final int totalReservations;
  final int canceledReservations;
  final int totalComments;
  final int totalFavorites;

  const StatsModel({
    required this.totalReservations,
    required this.canceledReservations,
    required this.totalComments,
    required this.totalFavorites,
  });

  StatsModel copyWith({
    int? totalReservations,
    int? canceledReservations,
    int? totalComments,
    int? totalFavorites,
  }) {
    return StatsModel(
      totalReservations: totalReservations ?? this.totalReservations,
      canceledReservations: canceledReservations ?? this.canceledReservations,
      totalComments: totalComments ?? this.totalComments,
      totalFavorites: totalFavorites ?? this.totalFavorites,
    );
  }
}
