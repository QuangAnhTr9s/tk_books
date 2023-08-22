import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tk_books/view/exercise_detail/screen/exercise_detail_screen.dart';
import 'package:tk_books/view/notification/screen/notification_screen.dart';
import 'package:tk_books/view/notification_detail/screen/notification_detail_screen.dart';
import 'package:tk_books/view/scan_screen/screen/scan_screen.dart';

import '../../shared/const/screen_consts.dart';
import '../book_details/screen/book_details_screen.dart';

import '../lesson_detail/screen/lesson_detail_screen.dart';
import '../recommended_books/screen/recommended_books_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BiBoo App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: TextTheme(
          displayLarge: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: const Color(0xffffffff),
          ),
          titleLarge: GoogleFonts.quicksand(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 1.2,
            color: const Color(0xff3f4254),
          ),
          titleMedium: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.25,
            color: const Color(0xff3f4254),
          ),
          titleSmall: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 1.4,
            color: const Color(0xff3f4254),
          ),
          displayMedium: GoogleFonts.quicksand(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 1.4,
              color: const Color(0xff8b90a7)),
          labelLarge: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 1.25,
            color: const Color(0xffffffff),
          ),
          labelMedium: GoogleFonts.quicksand(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: const Color(0xffe0f2f3),
          ),
          labelSmall: GoogleFonts.quicksand(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 1.17,
            color: const Color(0xff8b90a7),
          ),
          bodyLarge: GoogleFonts.quicksand(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            height: 1.5,
            color: const Color(0xffffffff),
          ),
          bodyMedium: GoogleFonts.quicksand(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: const Color(0xff8b90a7),
          ),
          bodySmall: GoogleFonts.quicksand(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: const Color(0xff8b90a7),
          ),
        ),
        bottomSheetTheme:
            const BottomSheetThemeData(backgroundColor: Colors.white),
      ),
      routes: {
        '/': (context) => const MainPage(),
        RouteName.bookDetailsScreen: (context) => const BookDetailsScreen(),
        RouteName.recommendedBooksScreen: (context) =>
            const RecommendedBooksScreen(),
        RouteName.lessonDetailScreen: (context) => const LessonDetailScreen(),
        RouteName.exerciseDetailScreen: (context) =>
            const ExerciseDetailScreen(),
        RouteName.scanScreen: (context) => const ScanScreen(),
        RouteName.notificationScreen: (context) => const NotificationScreen(),
        RouteName.notificationDetailScreen: (context) =>
            const NotificationDetailScreen(),
      },
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: BookDetailsScreen(),
        // child: NotificationScreen(),
      ),
    );
  }
}
