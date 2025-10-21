
import 'movie.dart';

class Ticket {
  final String bookingId;
  final String transactionId;
  final String referenceId;
  final Movie movie;
  final List<String> selectedSeats;
  final DateTime showDateTime;
  final String selectedPackage;
  final double totalPrice;
  final bool reminderEnabled;
  final bool isCancelled;

  Ticket({
    required this.bookingId,
    required this.transactionId,
    required this.referenceId,
    required this.movie,
    required this.selectedSeats,
    required this.showDateTime,
    required this.selectedPackage,
    required this.totalPrice,
    this.reminderEnabled = true,
    this.isCancelled = false,
  });

  Ticket copyWith({
    String? bookingId,
    String? transactionId,
    String? referenceId,
    Movie? movie,
    List<String>? selectedSeats,
    DateTime? showDateTime,
    String? selectedPackage,
    double? totalPrice,
    bool? reminderEnabled,
    bool? isCancelled,
  }) {
    return Ticket(
      bookingId: bookingId ?? this.bookingId,
      transactionId: transactionId ?? this.transactionId,
      referenceId: referenceId ?? this.referenceId,
      movie: movie ?? this.movie,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      showDateTime: showDateTime ?? this.showDateTime,
      selectedPackage: selectedPackage ?? this.selectedPackage,
      totalPrice: totalPrice ?? this.totalPrice,
      reminderEnabled: reminderEnabled ?? this.reminderEnabled,
      isCancelled: isCancelled ?? this.isCancelled,
    );
  }

  String get formattedDate {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[showDateTime.month - 1]} ${showDateTime.day}, ${showDateTime.year}';
  }

  String get formattedTime {
    final hour = showDateTime.hour;
    final minute = showDateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  String get formattedTimeRange {
    final startHour = showDateTime.hour;
    final startMinute = showDateTime.minute.toString().padLeft(2, '0');
    
    // افترض أن الفيلم مدته ساعتين ونصف
    final endTime = showDateTime.add(const Duration(hours: 2, minutes: 30));
    final endHour = endTime.hour;
    final endMinute = endTime.minute.toString().padLeft(2, '0');
    
    return '$startHour:$startMinute - $endHour:$endMinute';
  }
}