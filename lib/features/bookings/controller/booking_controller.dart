import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:savoir/common/database_repository.dart';
import 'package:savoir/common/providers.dart';
import 'package:savoir/features/search/model/reservation.dart';

final bookingsFetchProvider = FutureProvider<ReservationModel>((ref) async {
  final user = ref.watch(userProvider);
  final res = ref.read(databaseRepositoryProvider).readBookings(user!.uid);
  return res;
});

final bookingsControllerProvider = StateNotifierProvider<BookingsController, BookingsState>((ref) {
  final bookings = ref.watch(bookingsFetchProvider);
  return bookings.when(
    data: (data) {
      return BookingsController(ref, BookingsState(isLoading: false, bookings: data));
    },
    error: (e, s) => BookingsController(ref, BookingsState.err()),
    loading: () => BookingsController(ref, BookingsState.initial()),
  );
});

class BookingsState {
  bool isLoading;
  ReservationModel? bookings;
  BookingsState({required this.isLoading, required this.bookings});

  BookingsState.initial()
      : isLoading = true,
        bookings = null;

  BookingsState.err()
      : isLoading = false,
        bookings = null;

  BookingsState copyWith({
    bool? isLoading,
    ReservationModel? bookings,
  }) {
    return BookingsState(
      isLoading: isLoading ?? this.isLoading,
      bookings: bookings ?? this.bookings,
    );
  }
}

class BookingsController extends StateNotifier<BookingsState> {
  final Ref ref;
  final BookingsState init;
  BookingsController(this.ref, this.init) : super(init);

  Future<void> getBookings() async {
    final user = ref.read(userProvider);
    if (user == null) {
      return;
    }
    state = state.copyWith(isLoading: true);
    final bookings = await ref.read(databaseRepositoryProvider).readBookings(user.uid);
    state = state.copyWith(isLoading: false, bookings: bookings);
  }
}
