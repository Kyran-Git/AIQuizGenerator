enum QuestionType { multipleChoice, shortAnswer }

extension QuestionTypeMapper on QuestionType {
  String get value => name;

  static QuestionType fromString(String? input) {
    switch (input) {
      case 'shortAnswer':
        return QuestionType.shortAnswer;
      case 'multipleChoice':
      default:
        return QuestionType.multipleChoice;
    }
  }
}
