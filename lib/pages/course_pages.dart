import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../state/course_store.dart';
import '../widgets/course_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CourseStore>();
    final visible = store.filtered;
    return ListView(padding: const EdgeInsets.all(24), children: [
      Text('Halo, ${store.name}!', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      const Text('Pilih mata kuliah untuk belajar.'),
      const SizedBox(height: 16),
      TextFormField(
        initialValue: store.query,
        decoration: const InputDecoration(labelText: 'Cari mata kuliah',
            prefixIcon: Icon(Icons.search)),
        onChanged: (value) => context.read<CourseStore>().setQuery(value),
      ),
      const SizedBox(height: 16),
      if (visible.isEmpty) const Text('Mata kuliah tidak ditemukan. Coba kata lain.'),
      for (final course in visible) CourseCard(course: course, from: 'home'),
    ]);
  }
}

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    final items = context.watch<CourseStore>().favorites;
    return ListView(padding: const EdgeInsets.all(24), children: [
      Text('Favorit saya', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 16),
      if (items.isEmpty) const Text('Belum ada favorit. Tekan ikon hati pada kartu.'),
      for (final course in items) CourseCard(course: course, from: 'favorites'),
    ]);
  }
}

class CourseDetailPage extends StatelessWidget {
  const CourseDetailPage({super.key, required this.id, this.from});
  final String id;
  final String? from;
  @override
  Widget build(BuildContext context) {
    final course = findCourse(id);
    final favorite = context.select<CourseStore, bool>((s) => s.isFavorite(id));
    return Scaffold(
      appBar: AppBar(title: const Text('Detail mata kuliah'), leading: IconButton(
        tooltip: 'Kembali', icon: const Icon(Icons.arrow_back),
        onPressed: () { if (context.canPop()) { context.pop(); } else { context.go('/home'); } },
      )),
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(24), children: [
        if (course == null) ...[
          const Text('Mata kuliah tidak ditemukan.'),
          Text('ID: $id'),
        ] else ...[
          Text(course.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 8), Text(course.lecturer),
          const SizedBox(height: 16), Text(course.description),
          const SizedBox(height: 8), Text('Asal halaman: ${from ?? "tautan langsung"}'),
          const SizedBox(height: 16),
          FilledButton.icon(
            onPressed: () => context.read<CourseStore>().toggleFavorite(id),
            icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
            label: Text(favorite ? 'Hapus favorit' : 'Tambah favorit'),
          ),
        ],
      ])),
    );
  }
}
