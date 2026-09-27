class StudyActivity {
  final String id;
  final String title;
  final String category; // "Kuliah", "Tugas", "Ujian", "Pribadi"
  final DateTime dueDate;
  final String description;
  final bool isDone;
  final bool isFavorite;

  StudyActivity({
    required this.id,
    required this.title,
    required this.category,
    required this.dueDate,
    required this.description,
    this.isDone = false,
    this.isFavorite = false,
  });

  StudyActivity copyWith({
    String? id,
    String? title,
    String? category,
    DateTime? dueDate,
    String? description,
    bool? isDone,
    bool? isFavorite,
  }) {
    return StudyActivity(
      id: id ?? this.id,
      title: title ?? this.title,
      category: category ?? this.category,
      dueDate: dueDate ?? this.dueDate,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  static List<StudyActivity> get dummyActivities {
    final now = DateTime.now();
    return [
      StudyActivity(
        id: 'ACT-001',
        title: 'Pemrograman Mobile',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 1)),
        description: 'Mempelajari konsep pengembangan aplikasi mobile dengan Flutter.',
        isDone: true,
        isFavorite: true,
      ),
      StudyActivity(
        id: 'ACT-002',
        title: 'Grafika Komputer',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 3)),
        description: 'Mempelajari cara membuat, memproses, dan memanipulasi gambar atau konten visual secara digital menggunakan komputer',
        isDone: true,
        isFavorite: true,
      ),
      StudyActivity(
        id: 'ACT-003',
        title: 'Kriptografi',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 7)),
        description: 'Mempelajari ilmu dan seni untuk mengamankan data atau informasi agar tidak bisa dibaca atau diubah oleh pihak yang tidak berwenang',
        isDone: true,
        isFavorite: true,
      ),
      StudyActivity(
        id: 'ACT-004',
        title: 'Komputasi Paralel & Terdistribusi',
        category: 'Tugas',
        dueDate: now.add(const Duration(days: 2)),
        description: 'Melanjutkan tugas 6 di Kelas USU.',
        isDone: false,
        isFavorite: false,
      ),
      StudyActivity(
        id: 'ACT-005',
        title: 'Metodologi Penelitian',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 4)),
        description: 'Mempelajari cara merancang, melakukan, dan melaporkan sebuah penelitian secara ilmiah, khususnya untuk Tugas Akhir Skripsi.',
        isDone: true,
        isFavorite: true,
      ),
      StudyActivity(
        id: 'ACT-006',
        title: 'Business Intelligence',
        category: 'Tugas Kelompok',
        dueDate: now.add(const Duration(days: 5)),
        description: 'Menyusun presentasi analisis kasus BI di sebuah perusahaan.',
        isDone: false,
        isFavorite: false,
      ),
      StudyActivity(
        id: 'ACT-007',
        title: 'Kecerdasan Buatan',
        category: 'Pribadi',
        dueDate: now.add(const Duration(days: 6)),
        description: 'Mengikuti pembelajaran secara virtual melalui website Huawei.',
        isDone: false,
        isFavorite: true,
      ),
      StudyActivity(
        id: 'ACT-008',
        title: 'Lab Grafika Komputer',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 8)),
        description: 'Mengerjakan proyek yang berkaitan dengan Grafika Komputer.',
        isDone: false,
        isFavorite: false,
      ),
      StudyActivity(
        id: 'ACT-009',
        title: 'Lab Pemrograman Mobile',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 10)),
        description: 'Mengerjakan proyek AnimeVerse yang akan di develop setiap minggunya.',
        isDone: false,
        isFavorite: true,
      ),
      StudyActivity(
        id: 'ACT-010',
        title: 'Basic Listening',
        category: 'Kuliah',
        dueDate: now.add(const Duration(days: 14)),
        description: 'Salah satu mata kuliah MKWU yang focus on listening skill.',
        isDone: false,
        isFavorite: true,
      ),
    ];
  }
}
