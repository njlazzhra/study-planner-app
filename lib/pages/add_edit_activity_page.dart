import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../models/study_activity.dart';
import '../state/study_store.dart';

class AddEditActivityPage extends StatefulWidget {
  final String? id; // if null, it's add mode; otherwise edit mode

  const AddEditActivityPage({super.key, this.id});

  @override
  State<AddEditActivityPage> createState() => _AddEditActivityPageState();
}

class _AddEditActivityPageState extends State<AddEditActivityPage> {
  final _formKey = GlobalKey<FormState>();

  late String _title;
  late String _category;
  late DateTime _dueDate;
  late String _description;
  late bool _isFavorite;
  late bool _isDone;

  bool _isInitialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isInitialized) {
      if (widget.id != null) {
        final store = context.read<StudyStore>();
        final activity = store.getActivityById(widget.id!);
        if (activity != null) {
          _title = activity.title;
          _category = activity.category;
          _dueDate = activity.dueDate;
          _description = activity.description;
          _isFavorite = activity.isFavorite;
          _isDone = activity.isDone;
        } else {
          _initDefaults();
        }
      } else {
        _initDefaults();
      }
      _isInitialized = true;
    }
  }

  void _initDefaults() {
    _title = '';
    _category = 'Kuliah';
    _dueDate = DateTime.now().add(const Duration(days: 1));
    _description = '';
    _isFavorite = false;
    _isDone = false;
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 5)),
    );
    if (picked != null) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  void _saveForm() {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();
      final store = context.read<StudyStore>();

      if (widget.id == null) {
        // Add new
        final newId = 'ACT-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
        final newActivity = StudyActivity(
          id: newId,
          title: _title,
          category: _category,
          dueDate: _dueDate,
          description: _description,
          isDone: _isDone,
          isFavorite: _isFavorite,
        );
        store.addActivity(newActivity);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas berhasil ditambahkan')),
        );
      } else {
        // Update existing
        final updatedActivity = StudyActivity(
          id: widget.id!,
          title: _title,
          category: _category,
          dueDate: _dueDate,
          description: _description,
          isDone: _isDone,
          isFavorite: _isFavorite,
        );
        store.updateActivity(updatedActivity);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Aktivitas berhasil diperbarui')),
        );
      }

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.id != null;
    final formattedDate =
        '${_dueDate.day.toString().padLeft(2, '0')}/${_dueDate.month.toString().padLeft(2, '0')}/${_dueDate.year}';

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Aktivitas' : 'Tambah Aktivitas Baru'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // Title
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(
                labelText: 'Judul Aktivitas *',
                hintText: 'Misal: Belajar Flutter & Provider',
                prefixIcon: Icon(Icons.title),
              ),
              maxLength: 80,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Judul wajib diisi';
                }
                if (value.trim().length < 3) {
                  return 'Judul minimal 3 karakter';
                }
                if (value.trim().length > 80) {
                  return 'Judul maksimal 80 karakter';
                }
                return null;
              },
              onSaved: (value) => _title = value?.trim() ?? '',
            ),
            const SizedBox(height: 16),
            // Category
            DropdownButtonFormField<String>(
              value: _category,
              decoration: const InputDecoration(
                labelText: 'Kategori *',
                prefixIcon: Icon(Icons.category),
              ),
              items: ['Kuliah', 'Tugas', 'Ujian', 'Pribadi'].map((cat) {
                return DropdownMenuItem(value: cat, child: Text(cat));
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() => _category = val);
                }
              },
              onSaved: (val) => _category = val ?? 'Kuliah',
            ),
            const SizedBox(height: 20),
            // Due Date Picker
            InputDecorator(
              decoration: const InputDecoration(
                labelText: 'Tenggat Waktu (Due Date) *',
                prefixIcon: Icon(Icons.calendar_today),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(formattedDate, style: const TextStyle(fontSize: 16)),
                  TextButton.icon(
                    onPressed: _pickDueDate,
                    icon: const Icon(Icons.edit_calendar),
                    label: const Text('Pilih Tanggal'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Description
            TextFormField(
              initialValue: _description,
              decoration: const InputDecoration(
                labelText: 'Deskripsi (Opsional)',
                hintText: 'Tambahkan catatan atau detail tugas...',
                prefixIcon: Icon(Icons.description),
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              maxLength: 300,
              validator: (value) {
                if (value != null && value.length > 300) {
                  return 'Deskripsi maksimal 300 karakter';
                }
                return null;
              },
              onSaved: (value) => _description = value?.trim() ?? '',
            ),
            const SizedBox(height: 16),
            // Favorite Switch / Checkbox
            SwitchListTile(
              title: const Text('Tandai sebagai Favorit'),
              subtitle: const Text('Aktivitas akan muncul di tab Favorit'),
              value: _isFavorite,
              secondary: const Icon(Icons.star, color: Colors.amber),
              onChanged: (val) => setState(() => _isFavorite = val),
            ),
            const SizedBox(height: 32),
            // Buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => context.pop(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Text('Batal'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: FilledButton(
                    onPressed: _saveForm,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(isEditing ? 'Simpan Perubahan' : 'Tambah'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
