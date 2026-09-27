import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/study_activity.dart';
import '../state/study_store.dart';

class ActivityCard extends StatelessWidget {
  final StudyActivity activity;

  const ActivityCard({super.key, required this.activity});

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
    final store = context.read<StudyStore>();
    final formattedDate =
        '${activity.dueDate.day.toString().padLeft(2, '0')}/${activity.dueDate.month.toString().padLeft(2, '0')}/${activity.dueDate.year}';

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => context.push('/activity/${activity.id}'),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Checkbox(
                value: activity.isDone,
                onChanged: (_) => store.toggleDone(activity.id),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: _getCategoryColor(activity.category)
                                .withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: _getCategoryColor(activity.category),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            activity.category,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: _getCategoryColor(activity.category),
                            ),
                          ),
                        ),
                        const Spacer(),
                        Icon(Icons.calendar_today,
                            size: 14, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      activity.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        decoration: activity.isDone
                            ? TextDecoration.lineThrough
                            : TextDecoration.none,
                        color: activity.isDone ? Colors.grey : Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (activity.description.isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        activity.description,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  activity.isFavorite ? Icons.star : Icons.star_border,
                  color: activity.isFavorite ? Colors.amber : Colors.grey,
                ),
                onPressed: () => store.toggleFavorite(activity.id),
                tooltip: 'Favorit',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
