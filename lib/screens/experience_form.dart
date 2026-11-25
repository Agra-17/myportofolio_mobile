import 'package:material_ui/material_ui.dart';

import '../widgets/left_drawer.dart';

class ExperienceFormPage extends StatefulWidget {
  const ExperienceFormPage({super.key});

  @override
  State<ExperienceFormPage> createState() => _ExperienceFormPageState();
}

class _ExperienceFormPageState extends State<ExperienceFormPage> {
  final _formKey = GlobalKey<FormState>();

  String _title = '';
  String _description = '';
  String _category = 'full-time';
  String _thumbnail = '';
  final _startDateKey = GlobalKey<FormFieldState<DateTime>>();
  final _endDateKey = GlobalKey<FormFieldState<DateTime>>();

  static const _categories = {
    'internship': 'Internship',
    'research': 'Research',
    'volunteer': 'Volunteer',
    'part-time': 'Part-Time',
    'full-time': 'Full-Time',
    'freelance': 'Freelance',
  };

  Widget _buildTextField({
    required String label,
    required ValueChanged<String> onChanged,
    int maxLines = 1,
    int? maxLength,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        maxLines: maxLines,
        onChanged: onChanged,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label tidak boleh kosong.';
          }
          if (maxLength != null && value.trim().runes.length > maxLength) {
            return '$label maksimal $maxLength karakter.';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildDateField({
    required GlobalKey<FormFieldState<DateTime>> fieldKey,
    required String label,
    String? Function(DateTime?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FormField<DateTime>(
        key: fieldKey,
        validator: validator,
        builder: (field) {
          final date = field.value;

          return InkWell(
            onTap: () async {
              FocusScope.of(context).unfocus();
              final picked = await showDatePicker(
                context: context,
                initialDate: date ?? DateTime.now(),
                firstDate: DateTime(1),
                lastDate: DateTime(9999, 12, 31),
              );

              if (field.mounted && picked != null) {
                field.didChange(picked);
              }
            },
            child: InputDecorator(
              decoration: InputDecoration(
                labelText: label,
                border: const OutlineInputBorder(),
                prefixIcon: const Icon(Icons.calendar_today),
                errorText: field.errorText,
                suffixIcon: date == null
                    ? null
                    : IconButton(
                        tooltip: 'Kosongkan tanggal',
                        icon: const Icon(Icons.clear),
                        onPressed: () => field.didChange(null),
                      ),
              ),
              child: Text(
                date == null
                    ? 'Pilih tanggal'
                    : MaterialLocalizations.of(context).formatShortDate(date),
              ),
            ),
          );
        },
      ),
    );
  }

  void _showSummary() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final startDate = _startDateKey.currentState?.value;
    final endDate = _endDateKey.currentState?.value;
    final dates = MaterialLocalizations.of(context);

    final startLabel = startDate == null
        ? 'Belum diisi'
        : dates.formatShortDate(startDate);
    final endLabel = endDate == null
        ? 'Belum diisi'
        : dates.formatShortDate(endDate);

    FocusScope.of(context).unfocus();

    showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text('Experience added successfully!'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Nama Experience: ${_title.trim()}'),
                Text('Deskripsi Experience: ${_description.trim()}'),
                Text('Kategori: ${_categories[_category]}'),
                Text(
                  'URL Gambar: ${_thumbnail.isEmpty ? 'Belum diisi' : _thumbnail}',
                ),
                Text('Tanggal Mulai: $startLabel'),
                Text('Tanggal Selesai: $endLabel'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Pengalaman'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildTextField(
                  label: 'Nama Experience',
                  maxLength: 255,
                  onChanged: (value) => _title = value,
                ),
                _buildTextField(
                  label: 'Deskripsi Experience',
                  maxLines: 4,
                  onChanged: (value) => _description = value,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: DropdownButtonFormField<String>(
                    initialValue: _category,
                    decoration: const InputDecoration(
                      labelText: 'Kategori',
                      border: OutlineInputBorder(),
                    ),
                    items: _categories.entries.map((entry) {
                      return DropdownMenuItem<String>(
                        value: entry.key,
                        child: Text(entry.value),
                      );
                    }).toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _category = value);
                      }
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'URL Gambar Experience (opsional)',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                    onChanged: (value) => _thumbnail = value.trim(),
                    validator: (value) {
                      final text = value?.trim() ?? '';
                      if (text.isEmpty) return null;
                      if (text.runes.length > 200) {
                        return 'URL gambar maksimal 200 karakter.';
                      }
                      final url = Uri.tryParse(text);
                      if (url == null ||
                          (url.scheme != 'http' && url.scheme != 'https') ||
                          url.host.isEmpty ||
                          RegExp(r'\s').hasMatch(text)) {
                        return 'Masukkan URL gambar yang valid.';
                      }
                      return null;
                    },
                  ),
                ),
                _buildDateField(
                  fieldKey: _startDateKey,
                  label: 'Tanggal Mulai (opsional)',
                ),
                _buildDateField(
                  fieldKey: _endDateKey,
                  label: 'Tanggal Selesai (opsional)',
                  validator: (endDate) {
                    final startDate = _startDateKey.currentState?.value;

                    if (startDate != null &&
                        endDate != null &&
                        endDate.isBefore(startDate)) {
                      return 'Tanggal selesai tidak boleh sebelum tanggal mulai.';
                    }

                    return null;
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: _showSummary,
                  child: const Text('Simpan'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
