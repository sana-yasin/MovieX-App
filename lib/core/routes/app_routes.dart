import 'package:flutter/material.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/onboarding/onboarding_screen.dart';
import '../../screens/auth/signup_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/date_time_selection/date_time_selection_screen.dart';
import '../../screens/seat_selection/seat_selection_screen.dart';
import '../../screens/MovieDetailsScreen/MovieDetailsScreen.dart';
import '../../screens/review_summary/review_summary_screen.dart';
import '../../screens/payment/payment_method_screen.dart';
import '../../models/movie.dart';
import '../../screens/ticket/ticket_screen.dart';
import '../../screens/ticket/my_tickets_screen.dart';

class AppRoutes {
  // Route Names
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String signup = '/signup';
  static const String login = '/login';
  static const String home = '/home';

  static const String dateTimeSelection = '/date-time-selection';
  static const String seatSelection = '/seat-selection';
  static const String movieDetails = '/movie-details';
  static const String reviewSummary = '/review-summary';
  static const String payment = '/payment';
  static const String ticket = '/ticket';
  static const String myTickets = '/my-tickets';

  // Route Generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

      case onboarding:
        return MaterialPageRoute(
          builder: (_) => const OnboardingScreen(),
        );

      case signup:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );

      case login:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );

      case dateTimeSelection:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => DateTimeSelectionScreen(movie: movie),
        );

      case seatSelection:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => SeatSelectionScreen(movie: movie),
        );

      case movieDetails:
        final movie = settings.arguments as Movie;
        return MaterialPageRoute(
          builder: (_) => MovieDetailsScreen(movie: movie),
        );

      case reviewSummary:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => ReviewSummaryScreen(
            movie: args['movie'] as Movie,
            selectedSeats: args['selectedSeats'] as List<String>,
            selectedDate: args['selectedDate'] as String,
            selectedTime: args['selectedTime'] as String,
            selectedPackage: args['selectedPackage'] as String,
          ),
        );

      case payment:
        final bookingData = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => PaymentMethodScreen(bookingData: bookingData),
        );

      case ticket: // أضف هذا الـ case
        return MaterialPageRoute(
          builder: (_) => const TicketScreen(),
          settings: settings, // مهم: لتمرير الـ arguments
        );

        case myTickets:
        return MaterialPageRoute(
          builder: (_) => const MyTicketsScreen());

      

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
