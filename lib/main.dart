import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';
import 'state/course_store.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (_) => CourseStore(), child: const CourseApp(),
));

class CourseApp extends StatelessWidget {
  const CourseApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    title: 'Mata Kuliah USU', debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006633)),
      scaffoldBackgroundColor: const Color(0xFFF1F7F1),
      inputDecorationTheme: const InputDecorationTheme(border: OutlineInputBorder()),
    ),
    routerConfig: appRouter,
  );
}

class StudyPlannerApp extends StatelessWidget {
  const StudyPlannerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Study Planner - Aplikasi Aktivitas Belajar',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1E88E5)),
        scaffoldBackgroundColor: const Color(0xFFF5F7FA),
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(),
        ),
      ),
      routerConfig: appRouter,
    );
  }
}
