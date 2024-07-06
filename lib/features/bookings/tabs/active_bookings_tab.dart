import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/common/theme.dart';
import 'package:savoir/common/widgets/buttons.dart';
import 'package:savoir/features/bookings/controller/booking_controller.dart';
import 'package:savoir/features/search/controller/restaurant_reservation_controller.dart';
import 'package:savoir/features/search/model/reservation.dart';
import 'package:shimmer/shimmer.dart';

class ActiveBookingsTab extends ConsumerWidget {
  const ActiveBookingsTab({super.key});

  void _cancelBooking(ReservationForm booking, WidgetRef ref) {
    ref.read(databaseRepositoryProvider).cancelReservation(
          userId: ref.read(userProvider)!.uid,
          restaurantId: booking.restaurantId!,
        );
    ref.invalidate(bookingsControllerProvider);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookings = ref.watch(bookingsControllerProvider);
    if (bookings.isLoading) {
      return _BookingsShimmer();
    } else if (bookings.bookings == null || bookings.bookings!.reservations.isEmpty) {
      return Center(
        child: Text('No active bookings'),
      );
    } else {
      return _Bookings(
        bookings: bookings.bookings!,
        onCancel: (booking) => _cancelBooking(booking, ref),
      );
    }
  }
}

class _Bookings extends StatelessWidget {
  final ReservationModel bookings;
  final Function(ReservationForm) onCancel;
  const _Bookings({
    required this.bookings,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bookings.reservations.length,
      itemBuilder: (context, index) {
        final booking = bookings.reservations[index];
        return CachedNetworkImage(
          imageUrl: booking.restaurantPhotoUrl,
          placeholder: (context, url) {
            return ListTile(
              leading: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  radius: 30,
                ),
              ),
              title: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey,
                  height: 20,
                ),
              ),
              subtitle: Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  color: Colors.grey,
                  height: 20,
                ),
              ),
            );
          },
          imageBuilder: (context, imageProvider) => ListTile(
            isThreeLine: true,
            leading: CircleAvatar(
              backgroundImage: imageProvider,
              radius: 30,
            ),
            // cancel button
            trailing: IconButton(
              icon: Icon(Icons.cancel),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Cancelar reserva'),
                        content: Text('¿Estás seguro de que deseas cancelar esta reserva?'),
                        actions: [
                          PrimaryButton(
                            text: 'Cancelar reserva',
                            onPressed: () {
                              onCancel(booking);
                              Navigator.pop(context);
                            },
                          ),
                          const SizedBox(height: 8),
                          SecondaryButton(
                            text: 'Ir atrás',
                            onPressed: () {
                              onCancel(booking);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              },
            ),
            title: Text(booking.restaurantName),
            subtitle: Text(
              formatReservationDate(booking.reservationDate),
              style: TextStyle(
                color: AppTheme.textColor,
              ),
            ),
            onTap: () => openBookingDetailsModal(context: context, booking: booking),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        );
      },
    );
  }

  void openBookingDetailsModal({
    required BuildContext context,
    required ReservationForm booking,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Detalles de la reserva'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: Text('Restaurante', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(booking.restaurantName),
              ),
              ListTile(
                title: Text('Fecha y hora', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(formatReservationDate(booking.reservationDate)),
              ),
              ListTile(
                title: Text('Personas', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(booking.numberOfPeople.toString()),
              ),
              ListTile(
                title: Text('Duración', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(
                  '${booking.durationHours}${booking.durationHours > 1 ? ' horas' : ' hora'}',
                ),
              ),
              ListTile(
                title: Text('Cuota de reserva', style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text('RD\$300.00'),
              ),
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Instrucciones'),
                        content: Text(booking.instructions),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: Text('Cerrar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text(
                  'Ver instrucciones',
                  style: TextStyle(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  String formatReservationDate(DateTime date) {
    String period = date.hour < 12 ? 'AM' : 'PM';
    int hourOfPeriod = date.hour > 12 ? date.hour - 12 : date.hour;
    String minute = date.minute < 10 ? '0${date.minute}' : '${date.minute}';
    return "Reserva para el ${date.day}/${date.month}/${date.year} a las $hourOfPeriod:$minute $period";
  }
}

class _BookingsShimmer extends StatelessWidget {
  const _BookingsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer(
          gradient: LinearGradient(
            colors: [Colors.grey[300]!, Colors.grey[100]!],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.grey,
              radius: 30,
            ),
            title: Container(
              color: Colors.grey,
              height: 20,
            ),
            subtitle: Container(
              color: Colors.grey,
              height: 20,
            ),
          ),
        );
      },
    );
  }
}
