import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../state/study_store.dart';

class ActivityDetailPage extends StatelessWidget {
  final String id;

  const ActivityDetailPage({super.key, required this.id});

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'Kuliah':
        return Colors.blue;
      case 'Tugas':
        return Colors.orange;
      case 'Ujian':
        return Colors.red;
      case 'Pribadi':
        return Colors.purple;
      default:
        return Colors.green;
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<StudyStore>();
    final activity = store.getActivityById(id);

    if (activity == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detail Aktivitas')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Aktivitas tidak ditemukan.'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => context.go('/home'),
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      );
    }

    final formattedDate =
        '${activity.dueDate.day.toString().padLeft(2, '0')}/${activity.dueDate.month.toString().padLeft(2, '0')}/${activity.dueDate.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text(activity.id),
        actions: [
          IconButton(
            icon: Icon(
              activity.isFavorite ? Icons.star : Icons.star_border,
              color: activity.isFavorite ? Colors.amber : null,
            ),
            onPressed: () => store.toggleFavorite(activity.id),
            tooltip: 'Favorit',
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => context.push('/activity/edit/${activity.id}'),
            tooltip: 'Edit',
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () {
              showDialog(
                context: context,
                builder: (dialogContext) => AlertDialog(
                  title: const Text('Hapus Aktivitas'),
                  content: Text('Apakah Anda yakin ingin menghapus "${activity.title}"?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(dialogContext),
                      child: const Text('Batal'),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(backgroundColor: Colors.red),
                      onPressed: () {
                        Navigator.pop(dialogContext);
                        store.deleteActivity(activity.id);
                        context.go('/activities');
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Aktivitas berhasil dihapus')),
                        );
                      },
                      child: const Text('Hapus'),
                    ),
                  ],
                ),
              );
            },
            tooltip: 'Hapus',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: _getCategoryColor(activity.category).withOpacity(0.15),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: _getCategoryColor(activity.category)),
                ),
                child: Text(
                  activity.category,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: _getCategoryColor(activity.category),
                  ),
                ),
              ),
              const Spacer(),
              Chip(
                avatar: Icon(
                  activity.isDone ? Icons.check_circle : Icons.hourglass_empty,
                  color: activity.isDone ? Colors.green : Colors.orange,
                  size: 18,
                ),
                label: Text(
                  activity.isDone ? 'Selesai' : 'Belum Selesai',
                  style: TextStyle(
                    color: activity.isDone ? Colors.green[850] : Colors.orange[850],
                    fontWeight: FontWeight.bold,
                  ),
                ),
                backgroundColor: activity.isDone
                    ? Colors.green.withOpacity(0.1)
                    : Colors.orange.withOpacity(0.1),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            activity.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 18, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                'Tenggat Waktu: $formattedDate',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const Divider(height: 32),
          const Text(
            'Deskripsi',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            activity.description.isNotEmpty
                ? activity.description
                : 'Tidak ada deskripsi yang ditambahkan.',
            style: const TextStyle(
              fontSize: 15,
              height: 1.4,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: () => store.toggleDone(activity.id),
              icon: Icon(activity.isDone ? Icons.undo : Icons.check),
              label: Text(activity.isDone ? 'Tandai Belum Selesai' : 'Tandai Selesai'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: activity.isDone ? Colors.orange : Colors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
