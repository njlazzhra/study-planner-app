import 'package:flutter/foundation.dart';
import '../models/course.dart';

class CourseStore extends ChangeNotifier {
  final Set<String> _favorites = {};
  String _name = 'Mahasiswa';
  String _query = '';
  String get name => _name;
  String get query => _query;
  int get favoriteCount => _favorites.length;
  bool isFavorite(String id) => _favorites.contains(id);
  List<Course> get favorites => courses.where((c) => isFavorite(c.id)).toList();
  List<Course> get filtered {
    final q = _query.trim().toLowerCase();
    return courses.where((c) => '${c.title} ${c.id}'.toLowerCase().contains(q)).toList();
  }
  void setQuery(String value) {
    if (_query == value) return;
    _query = value;
    notifyListeners();
  }
  void toggleFavorite(String id) {
    if (findCourse(id) == null) return;
    if (!_favorites.remove(id)) _favorites.add(id);
    notifyListeners();
  }
  void updateName(String value) {
    final clean = value.trim();
    if (clean.length < 2 || clean.length > 40 || clean == _name) return;
    _name = clean;
    notifyListeners();
  }
}
