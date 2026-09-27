import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/course_store.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.location, required this.child});
  final String location;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final count = context.select<CourseStore, int>((s) => s.favoriteCount);
    final index = location.startsWith('/favorites') ? 1 :
    location.startsWith('/profile') ? 2 : 0;
    return Scaffold(
      appBar: AppBar(title: const Text('Mata Kuliah USU'),
          actions: [Padding(padding: const EdgeInsets.all(16),
              child: Text('$count favorit'))]),
      body: SafeArea(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (i) => context.go(['/home', '/favorites', '/profile'][i]),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorit'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
