import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/routes/app_routes.dart';
import '../../models/movie.dart';
import '../../widgets/common/custom_button.dart';

class DateTimeSelectionScreen extends StatefulWidget {
  final Movie movie;

  const DateTimeSelectionScreen({
    super.key,
    required this.movie,
  });

  @override
  State<DateTimeSelectionScreen> createState() =>
      _DateTimeSelectionScreenState();
}

class _DateTimeSelectionScreenState extends State<DateTimeSelectionScreen> {
  int _selectedDateIndex = 0;
  String? _selectedTime;
  String? _selectedPackage;

  final List<DateOption> _dates = [
    DateOption(day: '22', weekday: 'Mon', month: 'Apr'),
    DateOption(day: '23', weekday: 'Tue', month: 'Apr'),
    DateOption(day: '24', weekday: 'Wed', month: 'Apr'),
    DateOption(day: '25', weekday: 'Thu', month: 'Apr'),
    DateOption(day: '26', weekday: 'Fri', month: 'Apr'),
  ];

  final List<TimeSlot> _timeSlots = [
    TimeSlot(time: '10:00', auditorium: 'Auditorium 3'),
    TimeSlot(time: '12:30', auditorium: 'Auditorium 3'),
    TimeSlot(time: '15:00', auditorium: 'Auditorium 3'),
    TimeSlot(time: '17:30', auditorium: 'Auditorium 3'),
    TimeSlot(time: '20:00', auditorium: 'Auditorium 3'),
    TimeSlot(time: '22:30', auditorium: 'Auditorium 3'),
  ];

  final List<PackageOption> _packages = [
    PackageOption(name: 'Standard', price: 12.00, auditorium: 'Auditorium 3'),
    PackageOption(name: 'IMAX', price: 17.00, auditorium: 'Auditorium 4'),
  ];

  void _continue() {
    if (_selectedTime == null || _selectedPackage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select date, time and package'),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    Navigator.pushNamed(
      context,
      AppRoutes.seatSelection,
      arguments: widget.movie,
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
          'Choose Date and Time',
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
                    // Cinema Info Card
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Icon(
                                  Icons.location_on,
                                  color: AppColors.white,
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              const Expanded(
                                child: Text(
                                  'AMC Empire 25',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '4.1 (10,779 Google reviews)',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '234 W 42nd St, New York, NY 10036, United States',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '+1 212-398-2597',
                            style: TextStyle(
                              fontSize: 12,
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Date Selection
                    SizedBox(
                      height: 80,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: _dates.length,
                        itemBuilder: (context, index) {
                          final date = _dates[index];
                          final isSelected = _selectedDateIndex == index;
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDateIndex = index;
                              });
                            },
                            child: Container(
                              width: 70,
                              margin: const EdgeInsets.only(right: 12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppColors.primary
                                    : AppColors.grey.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    date.day,
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w700,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                  Text(
                                    date.weekday,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                  Text(
                                    date.month,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? AppColors.white
                                          : AppColors.textSecondary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Packages
                    ..._packages.map((package) {
                      final isSelected = _selectedPackage == package.name;
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${package.name} ( \$${package.price.toStringAsFixed(2)} )',
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                                Text(
                                  package.auditorium,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Wrap(
                              spacing: 12,
                              runSpacing: 12,
                              children: _timeSlots.map((slot) {
                                final isTimeSelected =
                                    _selectedTime == slot.time &&
                                        _selectedPackage == package.name;
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedTime = slot.time;
                                      _selectedPackage = package.name;
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 12,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isTimeSelected
                                          ? AppColors.primary
                                          : AppColors.grey.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      slot.time,
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isTimeSelected
                                            ? AppColors.white
                                            : AppColors.textPrimary,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),

            // Continue Button
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
                text: 'Continue',
                onPressed: _continue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateOption {
  final String day;
  final String weekday;
  final String month;

  DateOption({
    required this.day,
    required this.weekday,
    required this.month,
  });
}

class TimeSlot {
  final String time;
  final String auditorium;

  TimeSlot({
    required this.time,
    required this.auditorium,
  });
}

class PackageOption {
  final String name;
  final double price;
  final String auditorium;

  PackageOption({
    required this.name,
    required this.price,
    required this.auditorium,
  });
}
