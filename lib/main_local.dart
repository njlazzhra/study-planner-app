// Tahap A: latihan state lokal sebelum Provider dan routing.
import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(
  theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF006633))),
  home: const LocalCoursePage(),
));
class LocalCoursePage extends StatefulWidget {
  const LocalCoursePage({super.key});
  @override
  State<LocalCoursePage> createState() => _LocalCoursePageState();
}
class _LocalCoursePageState extends State<LocalCoursePage> {
  String name = 'Najla Az Zahra';
  bool favorite = false;
  int opened = 0;
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Pertemuan 5 · State lokal')),
    body: ListView(padding: const EdgeInsets.all(24), children: [
      TextField(decoration: const InputDecoration(labelText: 'Nama mahasiswa'),
          onChanged: (value) => setState(() => name = value)),
      const SizedBox(height: 16),
      Text('Halo, ${name.trim().isEmpty ? "mahasiswa" : name.trim()}!'),
      const SizedBox(height: 16),
      Card(child: Padding(padding: const EdgeInsets.all(16), child: Column(children: [
        const Text('Pemrograman Mobile', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        const Text('ILK3105 · Nurrahmadayeni, M.Kom.'),
        IconButton(tooltip: 'Ubah favorit',
            onPressed: () => setState(() => favorite = !favorite),
            icon: Icon(favorite ? Icons.favorite : Icons.favorite_border)),
        Text(favorite ? 'Ditandai favorit' : 'Belum favorit'),
        FilledButton(onPressed: () {
          setState(() => opened++);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Materi dipilih.')));
        }, child: const Text('Lihat materi')),
        Text('Materi dibuka $opened kali'),
      ]))),
    ]),
  );
}
