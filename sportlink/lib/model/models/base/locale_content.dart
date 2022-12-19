import 'package:sportlink/model/models/base/db_key.dart';

class LocaleContent {
  final String title;
  final String? subtitle;
  final String? description;
  final String? address;
  final String? inlineText;
  final String? userName;
  final String? teamName;

  const LocaleContent._(
      {required this.description,
      required this.subtitle,
      required this.address,
      required this.inlineText,
      required this.teamName,
      required this.userName,
      required this.title});

  factory LocaleContent(Map content) {
    return LocaleContent._(
        title: content[LocaleContentDBKey.title.key],
        teamName: content[LocaleContentDBKey.teamName.key],
        userName: content[LocaleContentDBKey.userName.key],
        description: content[LocaleContentDBKey.description.key],
        subtitle: content[LocaleContentDBKey.subtitle.key],
        address: content[LocaleContentDBKey.address.key],
        inlineText: content[LocaleContentDBKey.inlineText.key]);
  }

  Map<String, dynamic> json([Map? replacement]) => {
        LocaleContentDBKey.title.key:
            replacement?[LocaleContentDBKey.title.key] ?? title,
        LocaleContentDBKey.description.key:
            replacement?[LocaleContentDBKey.description.key] ?? description,
        LocaleContentDBKey.subtitle.key:
            replacement?[LocaleContentDBKey.subtitle.key] ?? subtitle,
        LocaleContentDBKey.address.key:
            replacement?[LocaleContentDBKey.address.key] ?? address,
        LocaleContentDBKey.inlineText.key:
            replacement?[LocaleContentDBKey.inlineText.key] ?? inlineText
      };
}
