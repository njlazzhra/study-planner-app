// Tahap C: satu store untuk dua tampilan sebelum routing.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'state/course_store.dart';

void main() => runApp(ChangeNotifierProvider(
  create: (_) => CourseStore(),
  child: MaterialApp(
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006633))),
    home: const FavoriteLab(),
  ),
));
class FavoriteLab extends StatefulWidget {
  const FavoriteLab({super.key});
  @override
  State<FavoriteLab> createState() => _FavoriteLabState();
}
class _FavoriteLabState extends State<FavoriteLab> {
  bool onlyFavorites = false;
  @override
  Widget build(BuildContext context) {
    final store = context.watch<CourseStore>();
    final items = onlyFavorites ? store.favorites : store.filtered;
    return Scaffold(
      appBar: AppBar(title: Text('${store.favoriteCount} favorit')),
      body: ListView(padding: const EdgeInsets.all(24), children: [
        SwitchListTile(title: const Text('Hanya favorit'), value: onlyFavorites,
            onChanged: (value) => setState(() => onlyFavorites = value)),
        if (items.isEmpty) const Text('Belum ada favorit.'),
        for (final course in items) Card(child: ListTile(
          title: Text(course.title), subtitle: Text(course.id),
          trailing: IconButton(
            tooltip: 'Ubah favorit ${course.id}',
            onPressed: () => context.read<CourseStore>().toggleFavorite(course.id),
            icon: Icon(store.isFavorite(course.id) ? Icons.favorite : Icons.favorite_border),
          ),
        )),
      ]),
    );
  }
}
