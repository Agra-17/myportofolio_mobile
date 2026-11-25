import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/models/achievement.dart';

/// Menampilkan detail satu achievement yang dipilih dari daftar.
class AchievementDetailScreen extends StatelessWidget {
  const AchievementDetailScreen({required this.achievement, super.key});

  final Achievement achievement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(achievement.title),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              achievement.title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text('Issuer: ${achievement.issuer}'),
            const SizedBox(height: 8),
            Text('Scale: ${achievement.scale}'),
            const SizedBox(height: 8),
            Text('Date Achieved: ${achievement.dateAchieved}'),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(achievement.description),
          ],
        ),
      ),
    );
  }
}
