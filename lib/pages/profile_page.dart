import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/study_store.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void _showEditProfileDialog(BuildContext context, StudyStore store) {
    final nameController = TextEditingController(text: store.userName);
    final nimController = TextEditingController(text: store.userNim);
    final majorController = TextEditingController(text: store.userMajor);
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Edit Profil Mahasiswa'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Nama Lengkap'),
                  validator: (val) => val == null || val.trim().isEmpty ? 'Nama wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: nimController,
                  decoration: const InputDecoration(labelText: 'NIM'),
                  validator: (val) => val == null || val.trim().isEmpty ? 'NIM wajib diisi' : null,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: majorController,
                  decoration: const InputDecoration(labelText: 'Program Studi'),
                  validator: (val) => val == null || val.trim().isEmpty ? 'Program Studi wajib diisi' : null,
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                store.setUserName(
                  nameController.text.trim(),
                  nim: nimController.text.trim(),
                  major: majorController.text.trim(),
                );
                Navigator.pop(dialogContext);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil berhasil diperbarui')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = context.watch<StudyStore>();
    final total = store.totalCount;
    final done = store.doneCount;
    final percent = total > 0 ? (done / total * 100).toStringAsFixed(1) : '0.0';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Pengguna', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // Profile Card
          Center(
            child: Column(
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  child: Text(
                    store.userName.isNotEmpty ? store.userName[0].toUpperCase() : 'S',
                    style: const TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  store.userName,
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  'NIM: ${store.userNim}',
                  style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                ),
                const SizedBox(height: 2),
                Text(
                  store.userMajor,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  onPressed: () => _showEditProfileDialog(context, store),
                  icon: const Icon(Icons.edit),
                  label: const Text('Edit Profil'),
                ),
              ],
            ),
          ),
          const Divider(height: 40),
          // Statistics Section
          const Text(
            'Statistik Belajar',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Tingkat Penyelesaian'),
                    Text('$percent%', style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: total > 0 ? done / total : 0.0,
                    minHeight: 10,
                    backgroundColor: Colors.grey[300],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem('Total', '$total', Colors.blue),
                    _buildStatItem('Selesai', '$done', Colors.green),
                    _buildStatItem('Pending', '${store.pendingCount}', Colors.orange),
                    _buildStatItem('Favorit', '${store.favoriteCount}', Colors.amber),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          // App Info
          const Text(
            'Tentang Aplikasi',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            child: const Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Study Planner App v1.0',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  SizedBox(height: 6),
                  Text(
                    'Aplikasi Aktivitas Belajar untuk membantu mahasiswa mengelola jadwal kuliah, tugas, ujian, dan catatan pribadi secara efektif.',
                    style: TextStyle(color: Colors.grey, height: 1.3),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(fontSize: 13, color: Colors.grey[700]),
        ),
      ],
    );
  }
}
