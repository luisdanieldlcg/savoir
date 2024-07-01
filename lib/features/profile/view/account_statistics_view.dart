import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/features/profile/model/stats.dart';

final accountStatisticsViewProvider = FutureProvider((ref) async {
  final favorite = ref.watch(favoriteProvider);
  final repository = ref.watch(databaseRepositoryProvider);

  final user = ref.watch(userProvider)!;

  final comments = await repository.userCommentsCount(user.username);
  final stats = StatsModel(
    totalReservations: 0,
    canceledReservations: 0,
    totalComments: comments,
    totalFavorites: favorite == null ? 0 : favorite.restaurants.length,
  );
  return stats;
});

class AccountStatisticsView extends ConsumerWidget {
  const AccountStatisticsView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(accountStatisticsViewProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Estadísticas de la cuenta",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 40),
            stats.when(
              data: (stats) {
                return _StatsView(stats: stats);
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) {
                return Center(child: Text("Error: $error"));
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _StatsView extends StatelessWidget {
  final StatsModel stats;
  const _StatsView({required this.stats});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 5),
          child: Text(
            "Reservas",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Stat(
              title: "Total",
              value: stats.totalReservations.toString(),
              icon: Icons.receipt_long_sharp,
            ),
            _Stat(
              title: "Canceladas",
              value: stats.canceledReservations.toString(),
              icon: Icons.cancel,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.only(bottom: 10, left: 5),
          child: Text(
            "Interacciones",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _Stat(
              title: "Comentarios",
              value: stats.totalComments.toString(),
              icon: Icons.comment,
            ),
            _Stat(
              title: "Favoritos",
              value: stats.totalFavorites.toString(),
              icon: Icons.favorite,
            ),
          ],
        ),
        const SizedBox(height: 25),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Text(
            "Tus estadísticas se actualizarán cada vez que realices una reserva, "
            "añadas un lugar a tus favoritos, comentes o valores un lugar.",
            style: TextStyle(
              color: Colors.grey[700],
              fontSize: 12,
              height: 1.5,
            ),
          ),
        ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  const _Stat({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 90,
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Icon(icon, color: AppTheme.primaryColor),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title),
              Text(value),
            ],
          ),
        ],
      ),
    );
  }
}
