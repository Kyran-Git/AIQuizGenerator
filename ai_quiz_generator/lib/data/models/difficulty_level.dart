enum DifficultyLevel { easy, medium, hard }

extension DifficultyLevelMapper on DifficultyLevel {
  String get value => name;

  static DifficultyLevel fromString(String? input) {
    switch (input) {
      case 'easy':
        return DifficultyLevel.easy;
      case 'hard':
        return DifficultyLevel.hard;
      case 'medium':
      default:
        return DifficultyLevel.medium;
    }
  }
}
