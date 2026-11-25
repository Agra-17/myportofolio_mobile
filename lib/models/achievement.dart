import 'package:json_annotation/json_annotation.dart';

part 'achievement.g.dart';

/// Portfolio achievement synchronized with the Django REST Framework API.
///
/// Disesuaikan dengan AchievementSerializer di Django:
/// id, title, description, scale, date_achieved, issuer.
@JsonSerializable(fieldRename: FieldRename.snake)
class Achievement {
  const Achievement({
    required this.title,
    required this.description,
    required this.scale,
    required this.dateAchieved,
    required this.issuer,
    this.id,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  @JsonKey(includeToJson: false)
  final String? id;
  final String title;
  final String description;

  /// Salah satu dari: international, national, provincial, district.
  final String scale;

  /// Format tanggal dari Django: "YYYY-MM-DD" (JSON key: date_achieved).
  final String dateAchieved;
  final String issuer;

  Map<String, dynamic> toJson() => _$AchievementToJson(this);
}
