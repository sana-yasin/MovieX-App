import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/movie.dart';
import '../../widgets/common/custom_button.dart';
import '../../services/ticket_manager.dart';
import '../../models/ticket.dart';

class PaymentMethodScreen extends StatefulWidget {
  final Map<String, dynamic>? bookingData;

  const PaymentMethodScreen({
    super.key,
    this.bookingData,
  });

  @override
  State<PaymentMethodScreen> createState() => _PaymentMethodScreenState();
}

class _PaymentMethodScreenState extends State<PaymentMethodScreen> {
  String _selectedMethod = 'credit_card';

  final List<PaymentOption> _paymentOptions = [
    PaymentOption(
      id: 'credit_card',
      title: 'Credit Card',
      subtitle: '**** **** **** 4532',
      icon: Icons.credit_card,
    ),
    PaymentOption(
      id: 'paypal',
      title: 'PayPal',
      subtitle: 'user@example.com',
      icon: Icons.paypal_outlined,
    ),
    PaymentOption(
      id: 'apple_pay',
      title: 'Apple Pay',
      subtitle: 'Pay with Apple',
      icon: Icons.apple,
    ),
    PaymentOption(
      id: 'google_pay',
      title: 'Google Pay',
      subtitle: 'Pay with Google',
      icon: Icons.g_mobiledata,
    ),
  ];

  void _processPayment() {
    // Generate random IDs
    final bookingId =
        'BK${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final transactionId =
        'TRX${DateTime.now().millisecondsSinceEpoch.toString().substring(6)}';
    final referenceId =
        'REF${DateTime.now().millisecondsSinceEpoch.toString().substring(5)}';

    // Get booking data
    final movie = widget.bookingData?['movie'] as Movie?;
    final selectedSeats =
        widget.bookingData?['selectedSeats'] as List<String>? ??
            ['F6', 'F7', 'F8', 'F9'];
    final selectedDate =
        widget.bookingData?['selectedDate'] as String? ?? 'Dec 22, 2023';
    final selectedTime =
        widget.bookingData?['selectedTime'] as String? ?? '17:30 - 20:38';
    final selectedPackage =
        widget.bookingData?['selectedPackage'] as String? ?? 'Standard';
    final totalPrice = widget.bookingData?['totalPrice'] as double? ?? 50.0;
    final showDateTime = _parseDateTime(selectedDate, selectedTime);

    if (movie != null) {
    final ticket = Ticket(
      bookingId: bookingId,
      transactionId: transactionId,
      referenceId: referenceId,
      movie: movie,
      selectedSeats: selectedSeats,
      showDateTime: showDateTime,
      selectedPackage: selectedPackage,
      totalPrice: totalPrice,
    );
    
    TicketManager().addTicket(ticket); // حفظ التذكرة
  }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withOpacity(0.1),
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: AppColors.white,
                        size: 40,
                      ),
                    ),
                    Positioned(top: 10, left: 20, child: _buildDot()),
                    Positioned(top: 15, right: 15, child: _buildDot()),
                    Positioned(bottom: 10, left: 15, child: _buildDot()),
                    Positioned(bottom: 15, right: 20, child: _buildDot()),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              const Text(
                'Tickets Successfully\nBooked!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 12),

              Text(
                'You\'re all set for an amazing movie\nexperience!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ),

              const SizedBox(height: 32),

              // View My Ticket Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    Navigator.pushNamed(
                      context,
                      AppRoutes.ticket,
                      arguments: {
                        'movie': movie,
                        'selectedSeats': selectedSeats,
                        'selectedDate': selectedDate,
                        'selectedTime': selectedTime,
                        'selectedPackage': selectedPackage,
                        'totalPrice': totalPrice,
                        'bookingId': bookingId,
                        'transactionId': transactionId,
                        'referenceId': referenceId,
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: const Text(
                    'View My Ticket',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // Back to Home Button
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    AppRoutes.home,
                    (route) => false,
                  );
                },
                child: const Text(
                  'Back to Home',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لتحويل النص إلى DateTime
DateTime _parseDateTime(String date, String time) {
  try {
    // مثال: "Dec 22, 2023" و "17:30 - 20:38"
    final dateParts = date.split(' ');
    final months = {
      'Jan': 1, 'Feb': 2, 'Mar': 3, 'Apr': 4, 'May': 5, 'Jun': 6,
      'Jul': 7, 'Aug': 8, 'Sep': 9, 'Oct': 10, 'Nov': 11, 'Dec': 12
    };
    
    final month = months[dateParts[0]] ?? 1;
    final day = int.parse(dateParts[1].replaceAll(',', ''));
    final year = int.parse(dateParts[2]);
    
    final timeParts = time.split(' - ')[0].split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);
    
    return DateTime(year, month, day, hour, minute);
  } catch (e) {
    return DateTime.now();
  }
}



  Widget _buildDot() {
    return Container(
      width: 8,
      height: 8,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primary.withOpacity(0.3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ticketCount =
        (widget.bookingData?['selectedSeats'] as List<String>?)?.length ?? 4;
    final ticketPrice = widget.bookingData?['ticketPrice'] as double? ?? 48.0;
    final serviceFee = widget.bookingData?['serviceFee'] as double? ?? 2.0;
    final totalPrice = widget.bookingData?['totalPrice'] as double? ?? 50.0;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
        ),
        title: const Text(
          'Payment Method',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Select Payment Method',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ...(_paymentOptions.map((option) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: _buildPaymentOption(option),
                      );
                    }).toList()),
                    const SizedBox(height: 24),
                    OutlinedButton.icon(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content:
                                Text('Add payment method feature coming soon!'),
                          ),
                        );
                      },
                      icon: const Icon(Icons.add, color: AppColors.primary),
                      label: const Text(
                        'Add New Payment Method',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        minimumSize: const Size(double.infinity, 50),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Payment Summary',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          _buildSummaryRow('Tickets ($ticketCount)',
                              '\$${ticketPrice.toStringAsFixed(2)}'),
                          const SizedBox(height: 8),
                          _buildSummaryRow('Service Fee',
                              '\$${serviceFee.toStringAsFixed(2)}'),
                          const Divider(height: 24),
                          _buildSummaryRow(
                              'Total', '\$${totalPrice.toStringAsFixed(2)}',
                              isBold: true),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: CustomButton(
                text: 'Confirm Payment',
                onPressed: _processPayment,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPaymentOption(PaymentOption option) {
    final isSelected = _selectedMethod == option.id;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMethod = option.id;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withOpacity(0.05)
              : AppColors.white,
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : AppColors.grey.withOpacity(0.3),
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary.withOpacity(0.1)
                    : AppColors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                option.icon,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    option.subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, {bool isBold = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w600 : FontWeight.w400,
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isBold ? FontWeight.w700 : FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}

class PaymentOption {
  final String id;
  final String title;
  final String subtitle;
  final IconData icon;

  PaymentOption({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
  });
}
