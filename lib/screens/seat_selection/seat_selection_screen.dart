import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/movie.dart';
import '../../widgets/common/custom_button.dart';

class SeatSelectionScreen extends StatefulWidget {
  final Movie movie;

  const SeatSelectionScreen({
    super.key,
    required this.movie,
  });

  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen> {
  final Set<String> _selectedSeats = {};
  final Set<String> _takenSeats = {'C3', 'C4', 'D5', 'D6', 'G7', 'G8'};

  final List<String> _rows = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  final int _seatsPerRow = 10;

  double get _totalPrice => _selectedSeats.length * 12.0;

  void _continue() {
    if (_selectedSeats.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select at least one seat'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.reviewSummary,
      arguments: {
        'movie': widget.movie,
        'selectedSeats': _selectedSeats.toList(),
        'selectedDate': 'Dec 22, 2023',
        'selectedTime': '17:30 - 20:38',
        'selectedPackage': 'Standard',
      },
    );
  }

  @override
  Widget build(BuildContext context) {
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
          'Choose Seat(s)',
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
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Cinema Screen
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          Container(
                            height: 4,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.primary.withOpacity(0.1),
                                  AppColors.primary,
                                  AppColors.primary.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(2),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Cinema Screen Here',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Seat Grid
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: _rows.map((row) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Row Label
                                SizedBox(
                                  width: 24,
                                  child: Text(
                                    row,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.textSecondary,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                // Seats
                                ...List.generate(_seatsPerRow, (index) {
                                  final seatNumber = index + 1;
                                  final seatId = '$row$seatNumber';
                                  final isTaken = _takenSeats.contains(seatId);
                                  final isSelected =
                                      _selectedSeats.contains(seatId);

                                  return GestureDetector(
                                    onTap: isTaken
                                        ? null
                                        : () {
                                            setState(() {
                                              if (isSelected) {
                                                _selectedSeats.remove(seatId);
                                              } else {
                                                _selectedSeats.add(seatId);
                                              }
                                            });
                                          },
                                    child: Container(
                                      width: 28,
                                      height: 28,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      decoration: BoxDecoration(
                                        color: isTaken
                                            ? AppColors.grey.withOpacity(0.3)
                                            : isSelected
                                                ? AppColors.primary
                                                : AppColors.grey
                                                    .withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(
                                          color: isTaken
                                              ? AppColors.grey.withOpacity(0.3)
                                              : isSelected
                                                  ? AppColors.primary
                                                  : AppColors.grey
                                                      .withOpacity(0.3),
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          seatNumber.toString(),
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.w600,
                                            color: isTaken
                                                ? AppColors.grey
                                                : isSelected
                                                    ? AppColors.white
                                                    : AppColors.textSecondary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Legend
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildLegendItem(
                              'Available',
                              AppColors.grey.withOpacity(0.1),
                              AppColors.textSecondary),
                          const SizedBox(width: 16),
                          _buildLegendItem('Taken',
                              AppColors.grey.withOpacity(0.3), AppColors.grey),
                          const SizedBox(width: 16),
                          _buildLegendItem(
                              'Selected', AppColors.primary, AppColors.white),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Section
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
              child: Column(
                children: [
                  // Price and Seats Info
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Total price',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '\$${_totalPrice.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      // Selected Seats
                      if (_selectedSeats.isNotEmpty)
                        Wrap(
                          spacing: 8,
                          children: _selectedSeats.take(4).map((seat) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                seat,
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.white,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  CustomButton(
                    text: 'Continue',
                    onPressed: _continue,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color bgColor, Color textColor) {
    return Row(
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: bgColor == AppColors.grey.withOpacity(0.1)
                  ? AppColors.grey.withOpacity(0.3)
                  : bgColor,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
