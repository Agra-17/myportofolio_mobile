import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/screens/achievement_form_screen.dart';
import 'package:myportofolio_mobile/screens/achievement_list_screen.dart';
import 'package:myportofolio_mobile/screens/experience_form.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/services/auth_state.dart';
import 'package:myportofolio_mobile/widgets/auth_guard.dart';
import 'package:provider/provider.dart';

class ItemCard extends StatelessWidget {
  final ItemHomepage item;

  const ItemCard(this.item, {super.key});

  Future<void> _onTap(BuildContext context) async {
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    // Menampilkan SnackBar dengan pesan interaktif (dari tutorial sebelumnya).
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!")),
      );

    if (item.name == "Lihat Achievement") {
      navigator.push(
        MaterialPageRoute(builder: (context) => const AchievementListScreen()),
      );
    } else if (item.name == "Tambah Achievement") {
      // Lindungi halaman form: wajib login dulu.
      final loggedIn = await ensureLoggedIn(context);
      if (!loggedIn) return;
      navigator.push(
        MaterialPageRoute(builder: (context) => const AchievementFormScreen()),
      );
    } else if (item.name == "Tambah Pengalaman") {
      navigator.push(
        MaterialPageRoute(builder: (context) => const ExperienceFormPage()),
      );
    } else if (item.name == "Logout") {
      final authState = context.read<AuthState>();
      if (!authState.isLoggedIn) {
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('You are not logged in.')),
          );
        return;
      }
      await authState.logout();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          const SnackBar(content: Text('You have been logged out.')),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menggunakan warna masing-masing tombol.
      color: item.color,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        // Aksi ketika kartu ditekan oleh pengguna.
        onTap: () => _onTap(context),
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(item.icon, color: Colors.white, size: 30.0),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
