
// lib/services/ticket_manager.dart
import '../models/ticket.dart';

class TicketManager {
  static final TicketManager _instance = TicketManager._internal();
  factory TicketManager() => _instance;
  TicketManager._internal();

  final List<Ticket> _tickets = [];

  // إضافة تذكرة جديدة
  void addTicket(Ticket ticket) {
    _tickets.add(ticket);
  }

  // الحصول على جميع التذاكر
  List<Ticket> getAllTickets() {
    return List.unmodifiable(_tickets);
  }

  // الحصول على التذاكر القادمة
  List<Ticket> getUpcomingTickets() {
    final now = DateTime.now();
    return _tickets
        .where((ticket) => ticket.showDateTime.isAfter(now))
        .toList()
      ..sort((a, b) => a.showDateTime.compareTo(b.showDateTime));
  }

  // الحصول على التذاكر الماضية
  List<Ticket> getPassedTickets() {
    final now = DateTime.now();
    return _tickets
        .where((ticket) => ticket.showDateTime.isBefore(now))
        .toList()
      ..sort((a, b) => b.showDateTime.compareTo(a.showDateTime));
  }

  // الحصول على التذاكر الملغاة
  List<Ticket> getCancelledTickets() {
    return _tickets.where((ticket) => ticket.isCancelled).toList()
      ..sort((a, b) => b.showDateTime.compareTo(a.showDateTime));
  }

  // إلغاء تذكرة
  void cancelTicket(String ticketId) {
    final ticketIndex = _tickets.indexWhere((t) => t.bookingId == ticketId);
    if (ticketIndex != -1) {
      _tickets[ticketIndex] = _tickets[ticketIndex].copyWith(isCancelled: true);
    }
  }

  // تفعيل/إيقاف التذكير
  void toggleReminder(String ticketId) {
    final ticketIndex = _tickets.indexWhere((t) => t.bookingId == ticketId);
    if (ticketIndex != -1) {
      _tickets[ticketIndex] = _tickets[ticketIndex].copyWith(
        reminderEnabled: !_tickets[ticketIndex].reminderEnabled,
      );
    }
  }

  // حذف جميع التذاكر (للتجربة)
  void clearAllTickets() {
    _tickets.clear();
  }
}

