import 'package:get/get.dart';

class BookingsController extends GetxController {
  final DateTime _today = DateTime.now();
  late final Rx<DateTime> visibleMonth = DateTime(
    _today.year,
    _today.month,
  ).obs;
  late final Rx<DateTime> selectedDate = _stripTime(_today).obs;

  final List<BookingItem> bookings = const [
    BookingItem(
      hotelName: 'Azure Coast Resort',
      location: 'Nusa Penida, Bali',
      status: 'Confirmed',
      dateLabel: 'Mar 4 - Mar 8',
      imageUrl:
          'https://images.unsplash.com/photo-1540541338287-41700207dee6?q=80&w=2070&auto=format&fit=crop',
    ),
    BookingItem(
      hotelName: 'Cave Suites Oia',
      location: 'Santorini, Greece',
      status: 'Upcoming',
      dateLabel: 'Mar 11 - Mar 14',
      imageUrl:
          'https://images.unsplash.com/photo-1533104816931-20fa691ff6ca?q=80&w=1974&auto=format&fit=crop',
    ),
    BookingItem(
      hotelName: 'Skyline Harbor Hotel',
      location: 'Dubai Marina, UAE',
      status: 'Pending',
      dateLabel: 'Mar 22 - Mar 25',
      imageUrl:
          'https://images.unsplash.com/photo-1512453979798-5ea266f8880c?q=80&w=1974&auto=format&fit=crop',
    ),
  ];

  List<DateTime?> get monthDates {
    final DateTime firstDayOfMonth = DateTime(
      visibleMonth.value.year,
      visibleMonth.value.month,
      1,
    );
    final int daysInMonth = DateTime(
      visibleMonth.value.year,
      visibleMonth.value.month + 1,
      0,
    ).day;
    final int leadingEmptySlots = (firstDayOfMonth.weekday + 6) % 7;
    final int totalSlots = ((leadingEmptySlots + daysInMonth + 6) ~/ 7) * 7;

    return List<DateTime?>.generate(totalSlots, (index) {
      final int day = index - leadingEmptySlots + 1;
      if (day < 1 || day > daysInMonth) return null;
      return DateTime(visibleMonth.value.year, visibleMonth.value.month, day);
    });
  }

  void selectDate(DateTime value) {
    selectedDate.value = _stripTime(value);
    visibleMonth.value = DateTime(value.year, value.month);
  }

  void goToPreviousMonth() {
    visibleMonth.value = DateTime(
      visibleMonth.value.year,
      visibleMonth.value.month - 1,
    );
  }

  void goToNextMonth() {
    visibleMonth.value = DateTime(
      visibleMonth.value.year,
      visibleMonth.value.month + 1,
    );
  }

  bool isSelected(DateTime value) {
    return _stripTime(value) == selectedDate.value;
  }

  bool isToday(DateTime value) {
    return _stripTime(value) == _stripTime(_today);
  }

  DateTime _stripTime(DateTime value) {
    return DateTime(value.year, value.month, value.day);
  }
}

class BookingItem {
  final String hotelName;
  final String location;
  final String status;
  final String dateLabel;
  final String imageUrl;

  const BookingItem({
    required this.hotelName,
    required this.location,
    required this.status,
    required this.dateLabel,
    required this.imageUrl,
  });
}
