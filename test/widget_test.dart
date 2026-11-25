import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/achievement_form_screen.dart';
import 'package:myportofolio_mobile/screens/achievement_list_screen.dart';
import 'package:myportofolio_mobile/screens/login_screen.dart';
import 'package:myportofolio_mobile/services/api_client.dart';

/// MockClient berpura-pura menjadi server Django, jadi test tidak butuh internet.
MockClient fakeServer() {
  return MockClient((request) async {
    if (request.url.path == '/api/v1/achievements/' &&
        request.method == 'GET') {
      return http.Response(
        jsonEncode([
          {
            'id': '11111111-1111-1111-1111-111111111111',
            'title': 'Juara 1 Hackathon',
            'description': 'Membuat aplikasi mobile.',
            'scale': 'national',
            'date_achieved': '2026-11-01',
            'issuer': 'Fasilkom UI',
          },
        ]),
        200,
      );
    }
    if (request.url.path == '/api/v1/auth/token/') {
      return http.Response(jsonEncode({'token': 'abc123'}), 200);
    }
    return http.Response('Not found', 404);
  });
}

Future<void> openApp(WidgetTester tester) async {
  final apiClient = ApiClient(client: fakeServer(), baseUrl: 'http://test');
  await tester.pumpWidget(MyApp(apiClient: apiClient));
}

Future<void> tapMenu(WidgetTester tester, String name) async {
  await tester.tap(find.text(name));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Halaman utama menampilkan tombol menu', (tester) async {
    await openApp(tester);

    expect(find.text('Lihat Achievement'), findsOneWidget);
    expect(find.text('Tambah Achievement'), findsOneWidget);
    expect(find.text('Logout'), findsOneWidget);
  });

  testWidgets('Daftar achievement diambil dari API', (tester) async {
    await openApp(tester);
    await tapMenu(tester, 'Lihat Achievement');

    expect(find.byType(AchievementListScreen), findsOneWidget);
    expect(find.text('Juara 1 Hackathon'), findsOneWidget);
  });

  testWidgets('Tambah Achievement saat belum login membuka LoginScreen', (
    tester,
  ) async {
    await openApp(tester);
    await tapMenu(tester, 'Tambah Achievement');

    expect(find.byType(LoginScreen), findsOneWidget);
    expect(find.byType(AchievementFormScreen), findsNothing);
  });

  testWidgets('Setelah login, form achievement terbuka', (tester) async {
    await openApp(tester);
    await tapMenu(tester, 'Tambah Achievement');

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), 'password');
    await tester.tap(find.widgetWithText(ElevatedButton, 'Login'));
    await tester.pumpAndSettle();

    expect(find.byType(AchievementFormScreen), findsOneWidget);

    // Form kosong tidak boleh dikirim.
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(find.text('Title cannot be empty!'), findsOneWidget);
  });
}
