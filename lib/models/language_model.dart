// ignore_for_file: public_member_api_docs, sort_constructors_first
class LanguageModel {
  final String flag;
  final String name;
  final String languageCode;
  LanguageModel(
    this.flag,
    this.name,
    this.languageCode,
  );

  static List<LanguageModel> languageList() {
    return <LanguageModel>[
      LanguageModel("US", "English", "en"),
      LanguageModel("IN", "हिंदी", "hi"),
    ];
  }
}
