import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'pages/course_pages.dart';
import 'pages/profile_pages.dart';
import 'widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Halaman tidak ditemukan')),
    body: Center(child: FilledButton(
        onPressed: () => context.go('/home'), child: const Text('Ke beranda'))),
  ),
  routes: [
    ShellRoute(
      builder: (context, state, child) => AppShell(
          location: state.uri.path, child: child),
      routes: [
        GoRoute(path: '/home', builder: (_, __) => const HomePage()),
        GoRoute(path: '/favorites', builder: (_, __) => const FavoritesPage()),
        GoRoute(path: '/profile', builder: (_, __) => const ProfilePage()),
      ],
    ),
    // Detail di luar shell: bottom navigation tidak ikut tampil.
    GoRoute(path: '/course/:id', name: 'course', builder: (context, state) =>
        CourseDetailPage(id: state.pathParameters['id'] ?? '',
            from: state.uri.queryParameters['from'])),
    GoRoute(path: '/edit-profile', builder: (context, state) =>
        EditProfilePage(initialName: state.extra is String ? state.extra as String : null)),
  ],
);
