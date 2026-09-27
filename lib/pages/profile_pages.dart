import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/course_store.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    final name = context.select<CourseStore, String>((s) => s.name);
    return ListView(padding: const EdgeInsets.all(24), children: [
      Text(name, style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 16),
      FilledButton(
        onPressed: () async {
          final result = await context.push<String>('/edit-profile', extra: name);
          if (!context.mounted || result == null) return;
          context.read<CourseStore>().updateName(result);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Nama berhasil diperbarui.')));
        },
        child: const Text('Edit profil'),
      ),
      const SizedBox(height: 16),
      const Text('Data latihan tersimpan di memori. Refresh atau restart akan mereset data.'),
    ]);
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key, this.initialName});
  final String? initialName;
  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(
        text: widget.initialName ?? context.read<CourseStore>().name);
  }
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }
  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final name = _nameController.text.trim();
    if (context.canPop()) {
      context.pop(name); // Hasil diterima oleh pemanggil push<String>.
    } else {
      // Fallback jika halaman edit dibuka lewat URL langsung.
      context.read<CourseStore>().updateName(name);
      context.go('/profile');
    }
  }
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Edit profil'), leading: IconButton(
      tooltip: 'Batal', icon: const Icon(Icons.close),
      onPressed: () { if (context.canPop()) { context.pop(); } else { context.go('/profile'); } },
    )),
    body: SafeArea(child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(key: _formKey, child: Column(children: [
        TextFormField(
          controller: _nameController,
          maxLength: 40,
          decoration: const InputDecoration(labelText: 'Nama mahasiswa'),
          autovalidateMode: AutovalidateMode.onUserInteraction,
          validator: (value) {
            final name = (value ?? '').trim();
            if (name.length < 2) return 'Nama minimal 2 karakter.';
            if (name.length > 40) return 'Nama maksimal 40 karakter.';
            return null;
          },
          onFieldSubmitted: (_) => _save(),
        ),
        const SizedBox(height: 16),
        FilledButton(onPressed: _save, child: const Text('Simpan')),
      ])),
    )),
  );
}
