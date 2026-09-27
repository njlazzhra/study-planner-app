import 'package:flutter/foundation.dart';
import '../models/study_activity.dart';

class StudyStore extends ChangeNotifier {
  final List<StudyActivity> _activities = StudyActivity.dummyActivities;

  String _searchQuery = '';
  String? _categoryFilter; // null or "Semua" or "Kuliah", "Tugas", "Ujian", "Pribadi"
  String? _statusFilter; // null or "Semua", "Belum Selesai", "Selesai"

  String _userName = 'Najla Az Zahra Tanjung';
  String _userNim = '241401136';
  String _userMajor = 'S1 Ilmu Komputer';

  // Getters
  List<StudyActivity> get activities => List.unmodifiable(_activities);

  String get searchQuery => _searchQuery;
  String? get categoryFilter => _categoryFilter;
  String? get statusFilter => _statusFilter;

  String get userName => _userName;
  String get userNim => _userNim;
  String get userMajor => _userMajor;

  void setUserName(String name, {String? nim, String? major}) {
    _userName = name;
    if (nim != null) _userNim = nim;
    if (major != null) _userMajor = major;
    notifyListeners();
  }

  void setQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategoryFilter(String? category) {
    _categoryFilter = (category == 'Semua' || category == null || category.isEmpty) ? null : category;
    notifyListeners();
  }

  void setStatusFilter(String? status) {
    _statusFilter = (status == 'Semua' || status == null || status.isEmpty) ? null : status;
    notifyListeners();
  }

  // Filtered activities computed getter
  List<StudyActivity> get filteredActivities {
    return _activities.where((activity) {
      // Search query filter
      final matchesSearch = _searchQuery.isEmpty ||
          activity.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          activity.description.toLowerCase().contains(_searchQuery.toLowerCase());

      // Category filter
      final matchesCategory = _categoryFilter == null || activity.category == _categoryFilter;

      // Status filter
      bool matchesStatus = true;
      if (_statusFilter == 'Selesai') {
        matchesStatus = activity.isDone;
      } else if (_statusFilter == 'Belum Selesai') {
        matchesStatus = !activity.isDone;
      }

      return matchesSearch && matchesCategory && matchesStatus;
    }).toList();
  }

  List<StudyActivity> get favoriteActivities {
    return _activities.where((a) => a.isFavorite).toList();
  }

  int get totalCount => _activities.length;
  int get doneCount => _activities.where((a) => a.isDone).length;
  int get pendingCount => totalCount - doneCount;
  int get favoriteCount => favoriteActivities.length;

  // CRUD Operations
  void addActivity(StudyActivity activity) {
    _activities.insert(0, activity);
    notifyListeners();
  }

  void updateActivity(StudyActivity updated) {
    final index = _activities.indexWhere((a) => a.id == updated.id);
    if (index != -1) {
      _activities[index] = updated;
      notifyListeners();
    }
  }

  void deleteActivity(String id) {
    _activities.removeWhere((a) => a.id == id);
    notifyListeners();
  }

  void toggleDone(String id) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      final current = _activities[index];
      _activities[index] = current.copyWith(isDone: !current.isDone);
      notifyListeners();
    }
  }

  void toggleFavorite(String id) {
    final index = _activities.indexWhere((a) => a.id == id);
    if (index != -1) {
      final current = _activities[index];
      _activities[index] = current.copyWith(isFavorite: !current.isFavorite);
      notifyListeners();
    }
  }

  StudyActivity? getActivityById(String id) {
    try {
      return _activities.firstWhere((a) => a.id == id);
    } catch (_) {
      return null;
    }
  }
}
