import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/study_store.dart';
import '../widgets/activity_card.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = context.watch<StudyStore>();
    final favorites = store.favoriteActivities;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Aktivitas Favorit', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: favorites.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.star_border, size: 64, color: Colors.amber),
                  const SizedBox(height: 12),
                  const Text(
                    'Belum ada aktivitas favorit.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Ketuk ikon bintang pada aktivitas untuk menambahkannya ke favorit.',
                    style: TextStyle(fontSize: 13, color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                return ActivityCard(activity: favorites[index]);
              },
            ),
    );
  }
}
