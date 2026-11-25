import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/achievement.dart';
import 'package:myportofolio_mobile/services/api_client.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:myportofolio_mobile/widgets/left_drawer.dart';
import 'package:provider/provider.dart';

class AchievementFormScreen extends StatefulWidget {
  const AchievementFormScreen({super.key});

  @override
  State<AchievementFormScreen> createState() => _AchievementFormScreenState();
}

class _AchievementFormScreenState extends State<AchievementFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();

  String _title = '';
  String _description = '';
  String _scale = 'national';
  String _issuer = '';
  bool _isSubmitting = false;

  // Pilihan scale harus sama dengan ACHIEVEMENT_SCALE di models.py Django.
  static const _scales = {
    'international': 'International',
    'national': 'National',
    'provincial': 'Provincial',
    'district': 'District',
  };

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      // Django DateField menerima format "YYYY-MM-DD".
      _dateController.text = picked.toIso8601String().substring(0, 10);
    }
  }

  Future<void> _submit() async {
    // 1. Validasi form.
    if (!_formKey.currentState!.validate()) return;

    // 2. Pastikan user sudah login (kalau belum, buka LoginScreen).
    final loggedIn = await ensureLoggedIn(context);
    if (!loggedIn || !mounted) return;

    final token = context.read<AuthState>().token!;
    final newAchievement = Achievement(
      title: _title,
      description: _description,
      scale: _scale,
      dateAchieved: _dateController.text,
      issuer: _issuer,
    );

    setState(() {
      _isSubmitting = true;
    });

    try {
      // 3. Kirim POST ke Django.
      final created = await context.read<ApiClient>().createAchievement(
        newAchievement,
        token: token,
      );
      if (!mounted) return;

      // 4. Berhasil (201 Created): tampilkan dialog konfirmasi.
      await showDialog<void>(
        context: context,
        builder: (dialogContext) => AlertDialog(
          title: const Text('Achievement added successfully!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${created.title}'),
              Text('Issuer: ${created.issuer}'),
              Text('Scale: ${_scales[created.scale] ?? created.scale}'),
              Text('Date: ${created.dateAchieved}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      if (!mounted) return;
      _formKey.currentState!.reset();
      _dateController.clear();
    } on ApiException catch (e) {
      if (!mounted) return;

      if (e.statusCode == 401) {
        // Token tidak valid: logout lalu minta login ulang.
        await context.read<AuthState>().logout();
        if (!mounted) return;
        await ensureLoggedIn(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save achievement (${e.statusCode}).'),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isSubmitting = false;
        });
      }
    }
  }

  InputDecoration _decoration(String label) {
    return InputDecoration(
      labelText: label,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
    );
  }

  String? _required(String? value, String label) {
    if (value == null || value.trim().isEmpty) {
      return '$label cannot be empty!';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Achievement'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: _decoration('Title'),
                onChanged: (value) => _title = value.trim(),
                validator: (value) => _required(value, 'Title'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                maxLines: 4,
                decoration: _decoration('Description'),
                onChanged: (value) => _description = value.trim(),
                validator: (value) => _required(value, 'Description'),
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _scale,
                decoration: _decoration('Scale'),
                items: _scales.entries
                    .map(
                      (entry) => DropdownMenuItem(
                        value: entry.key,
                        child: Text(entry.value),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _scale = value);
                  }
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _dateController,
                readOnly: true,
                decoration: _decoration('Date Achieved')
                    .copyWith(suffixIcon: const Icon(Icons.calendar_today)),
                onTap: _pickDate,
                validator: (value) => _required(value, 'Date Achieved'),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: _decoration('Issuer'),
                onChanged: (value) => _issuer = value.trim(),
                validator: (value) => _required(value, 'Issuer'),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                onPressed: _isSubmitting ? null : _submit,
                child: _isSubmitting
                    ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
