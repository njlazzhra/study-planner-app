class Course {
  const Course({required this.id, required this.title, required this.lecturer,
    required this.description});
  final String id;
  final String title;
  final String lecturer;
  final String description;
}

const courses = [
  Course(id: 'ILK3105', title: 'Pemrograman Mobile',
      lecturer: 'Nurrahmadayeni, M.Kom.',
      description: 'Pertemuan 5: interaksi pengguna, state, navigasi, dan data passing di Flutter.'),
  Course(id: 'DEMO02', title: 'Desain Antarmuka', lecturer: 'Dosen Contoh',
      description: 'Data latihan: hierarki visual, konsistensi, dan evaluasi antarmuka.'),
  Course(id: 'DEMO03', title: 'Proyek Aplikasi Kampus', lecturer: 'Dosen Contoh',
      description: 'Data latihan: pengembangan frontend aplikasi layanan kampus.'),
];

Course? findCourse(String id) {
  for (final course in courses) {
    if (course.id == id) return course;
  }
  return null;
}
