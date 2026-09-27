// Tahap B: katalog dan pencarian sebelum navigasi.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/course_store.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (_) => CourseStore(),
  child: MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006633))),
    home: const CatalogPage(),
  ),
));

class CatalogPage extends StatelessWidget {
  const CatalogPage({super.key});
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CourseStore>();
    return Scaffold(
      appBar: AppBar(title: const Text('Katalog mata kuliah')),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        TextField(
          decoration: const InputDecoration(
              labelText: 'Cari mata kuliah', border: OutlineInputBorder()),
          onChanged: (value) => context.read<CourseStore>().setQuery(value),
        ),
        const SizedBox(height: 16),
        if (store.filtered.isEmpty) const Text('Mata kuliah tidak ditemukan.'),
        for (final course in store.filtered) Card(child: ListTile(
          title: Text(course.title), subtitle: Text(course.id),
        )),
      ]),
    );
  }
}
