import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:myportofolio_mobile/main.dart';
import 'package:myportofolio_mobile/screens/menu.dart';
import 'package:myportofolio_mobile/screens/project_form.dart';

Future<void> openForm(WidgetTester tester) async {
  await tester.pumpWidget(const MyApp());
  await tester.tap(find.text('Tambah Proyek'));
  await tester.pumpAndSettle();
  await tester.pump(const Duration(seconds: 4));
  await tester.pumpAndSettle();
}

Future<void> saveForm(WidgetTester tester) async {
  await tester.ensureVisible(find.text('Save'));
  await tester.pumpAndSettle();
  await tester.tap(find.text('Save'));
  await tester.pumpAndSettle();
}

void main() {
  testWidgets('Kartu membuka form dan Back kembali ke halaman utama', (
    tester,
  ) async {
    await openForm(tester);
    expect(find.byType(ProjectFormPage), findsOneWidget);
    final navigator = tester.state<NavigatorState>(
      find.byType(Navigator).first,
    );
    expect(navigator.canPop(), isTrue);
    navigator.pop();
    await tester.pumpAndSettle();
    expect(find.byType(MyHomePage), findsOneWidget);
    expect(find.byType(ProjectFormPage), findsNothing);
  });

  testWidgets('Nama dan deskripsi kosong atau spasi ditolak', (tester) async {
    await openForm(tester);
    await saveForm(tester);
    expect(find.text('Enter a project name.'), findsOneWidget);
    expect(find.text('Enter a project description.'), findsOneWidget);
    expect(find.byType(AlertDialog), findsNothing);
    await tester.enterText(find.byType(TextFormField).at(0), '   ');
    await tester.enterText(find.byType(TextFormField).at(1), '   ');
    await saveForm(tester);
    expect(find.text('Enter a project name.'), findsOneWidget);
    expect(find.text('Enter a project description.'), findsOneWidget);
  });

  testWidgets('Teknologi dan tautan boleh dikosongkan', (tester) async {
    await openForm(tester);
    await tester.enterText(find.byType(TextFormField).at(0), 'Portofolio');
    await tester.enterText(find.byType(TextFormField).at(1), 'Proyek pribadi');
    await saveForm(tester);
    expect(find.text('Project Name: Portofolio'), findsOneWidget);
    expect(find.text('Category: Web Development'), findsOneWidget);
    expect(find.text('Technologies: '), findsOneWidget);
    expect(find.text('Link: '), findsOneWidget);
  });

  testWidgets('Dialog memuat lima nilai dan OK mereset kolom teks', (
    tester,
  ) async {
    await openForm(tester);
    await tester.enterText(find.byType(TextFormField).at(0), 'CatatTani');
    await tester.enterText(
      find.byType(TextFormField).at(1),
      'Catatan curah hujan',
    );
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Data Science').last);
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField).at(2), 'Flutter, Django');
    await tester.enterText(
      find.byType(TextFormField).at(3),
      'https://example.com',
    );
    await saveForm(tester);
    expect(find.text('Project Name: CatatTani'), findsOneWidget);
    expect(find.text('Description: Catatan curah hujan'), findsOneWidget);
    expect(find.text('Category: Data Science'), findsOneWidget);
    expect(find.text('Technologies: Flutter, Django'), findsOneWidget);
    expect(find.text('Link: https://example.com'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();
    for (final field in tester.widgetList<EditableText>(
      find.byType(EditableText),
    )) {
      expect(field.controller.text, isEmpty);
    }
  });
}
