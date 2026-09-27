import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../models/course.dart';
import '../state/course_store.dart';

class CourseCard extends StatelessWidget {
  const CourseCard({super.key, required this.course, required this.from});
  final Course course;
  final String from;
  @override
  Widget build(BuildContext context) {
    final favorite = context.select<CourseStore, bool>((s) => s.isFavorite(course.id));
    void openDetail() => context.pushNamed('course',
        pathParameters: {'id': course.id}, queryParameters: {'from': from});
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            const Icon(Icons.school, size: 36, color: Color(0xFF006633)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(course.title, style: Theme.of(context).textTheme.titleMedium),
              Text(course.id),
              Text(course.lecturer),
            ])),
            IconButton(
              tooltip: favorite ? 'Hapus dari favorit' : 'Tambah ke favorit',
              onPressed: () => context.read<CourseStore>().toggleFavorite(course.id),
              icon: Icon(favorite ? Icons.favorite : Icons.favorite_border),
            ),
          ]),
          const SizedBox(height: 12),
          FilledButton(onPressed: openDetail, child: const Text('Lihat materi')),
        ]),
      ),
    );
  }
}
