import 'dart:math';
import 'package:ai_quiz_generator/data/models/quiz_question.dart';
import 'package:ai_quiz_generator/data/models/quiz_settings.dart';

class MockQuizGeneratorService {
  Future<List<Question>> generateQuiz(QuizSettings settings) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));

    String topic = settings.sourceText.toLowerCase();
    List<Question> selectedQuestions = [];

    // --- 1. Topic Matching ---
    if (_matches(topic, ['biology', 'cell', 'science', 'animal'])) {
      selectedQuestions = _getBiologyQuiz();
    } else if (_matches(topic, ['history', 'war', 'past', '1945'])) {
      selectedQuestions = _getHistoryQuiz();
    } else if (_matches(topic, ['tech', 'computer', 'code', 'flutter'])) {
      selectedQuestions = _getTechQuiz();
    } else if (_matches(topic, ['geo', 'earth', 'capital', 'country'])) {
      selectedQuestions = _getGeographyQuiz();
    } else if (_matches(topic, ['movie', 'film', 'actor', 'star'])) {
      selectedQuestions = _getMoviesQuiz();
    } else if (_matches(topic, ['sport', 'game', 'ball', 'soccer'])) {
      selectedQuestions = _getSportsQuiz();
    } else {
      // Fallback: Pick a random quiz if topic is unknown
      final allQuizzes = [
        _getBiologyQuiz(),
        _getHistoryQuiz(),
        _getTechQuiz(),
        _getGeographyQuiz(),
        _getMoviesQuiz(),
        _getSportsQuiz(),
      ];
      selectedQuestions = allQuizzes[Random().nextInt(allQuizzes.length)];
    }

    // --- 2. Adjust Length ---
    if (selectedQuestions.length > settings.numOfQuestions) {
      return selectedQuestions.sublist(0, settings.numOfQuestions);
    }
    
    // Fill if not enough questions (duplicate randomly)
    while (selectedQuestions.length < settings.numOfQuestions) {
        selectedQuestions.add(selectedQuestions[Random().nextInt(selectedQuestions.length)]);
    }

    return selectedQuestions;
  }

  bool _matches(String topic, List<String> keywords) {
    for (var word in keywords) {
      if (topic.contains(word)) return true;
    }
    return false;
  }

  // --- PRESET DATA ---

  List<Question> _getBiologyQuiz() {
    return [
      Question(id: "bio_1", questionText: "What is the powerhouse of the cell?", options: ["Mitochondria", "Nucleus", "Ribosome", "Cytoplasm"], correctAnswer: "Mitochondria", difficulty: "easy", explanation: "Mitochondria generate energy."),
      Question(id: "bio_2", questionText: "Which molecule carries genetic info?", options: ["DNA", "RNA", "Lipid", "Protein"], correctAnswer: "DNA", difficulty: "medium", explanation: "DNA contains instructions for life."),
      Question(id: "bio_3", questionText: "Photosynthesis uses which gas?", options: ["Carbon Dioxide", "Oxygen", "Nitrogen", "Helium"], correctAnswer: "Carbon Dioxide", difficulty: "medium", explanation: "Plants absorb CO2."),
    ];
  }

  List<Question> _getHistoryQuiz() {
    return [
      Question(id: "hist_1", questionText: "First US President?", options: ["George Washington", "Lincoln", "Jefferson", "Adams"], correctAnswer: "George Washington", difficulty: "easy", explanation: "Washington was the first."),
      Question(id: "hist_2", questionText: "Year WWII ended?", options: ["1945", "1939", "1918", "1960"], correctAnswer: "1945", difficulty: "medium", explanation: "Ended with Japan's surrender."),
      Question(id: "hist_3", questionText: "Who built the Pyramids?", options: ["Egyptians", "Romans", "Mayans", "Greeks"], correctAnswer: "Egyptians", difficulty: "easy", explanation: "Ancient Egyptians built them."),
    ];
  }

  List<Question> _getTechQuiz() {
    return [
      Question(id: "tech_1", questionText: "What does CPU stand for?", options: ["Central Processing Unit", "Computer Personal Unit", "Central Process Utility", "None"], correctAnswer: "Central Processing Unit", difficulty: "easy", explanation: "The brain of the computer."),
      Question(id: "tech_2", questionText: "Language used for Flutter?", options: ["Dart", "Java", "Python", "C++"], correctAnswer: "Dart", difficulty: "medium", explanation: "Flutter uses Dart."),
      Question(id: "tech_3", questionText: "Symbol for Python language?", options: ["Snake", "Cup of Coffee", "Gem", "Elephant"], correctAnswer: "Snake", difficulty: "easy", explanation: "The logo features snakes."),
    ];
  }

  List<Question> _getGeographyQuiz() {
    return [
      Question(id: "geo_1", questionText: "Capital of France?", options: ["Paris", "London", "Berlin", "Rome"], correctAnswer: "Paris", difficulty: "easy", explanation: "Paris is the capital."),
      Question(id: "geo_2", questionText: "Largest Ocean?", options: ["Pacific", "Atlantic", "Indian", "Arctic"], correctAnswer: "Pacific", difficulty: "easy", explanation: "The Pacific is the largest."),
      Question(id: "geo_3", questionText: "Longest river in the world?", options: ["Nile", "Amazon", "Yangtze", "Mississippi"], correctAnswer: "Nile", difficulty: "hard", explanation: "The Nile is generally considered the longest."),
    ];
  }

  List<Question> _getMoviesQuiz() {
    return [
      Question(id: "mov_1", questionText: "Who played Iron Man?", options: ["Robert Downey Jr.", "Chris Evans", "Chris Hemsworth", "Mark Ruffalo"], correctAnswer: "Robert Downey Jr.", difficulty: "easy", explanation: "He started the MCU."),
      Question(id: "mov_2", questionText: "Highest grossing movie of all time?", options: ["Avatar", "Avengers: Endgame", "Titanic", "Star Wars"], correctAnswer: "Avatar", difficulty: "hard", explanation: "James Cameron's Avatar."),
      Question(id: "mov_3", questionText: "Simba is from which movie?", options: ["The Lion King", "Aladdin", "Frozen", "Mulan"], correctAnswer: "The Lion King", difficulty: "easy", explanation: "Hakuna Matata."),
    ];
  }

  List<Question> _getSportsQuiz() {
    return [
      Question(id: "sport_1", questionText: "Sport played in World Cup?", options: ["Football (Soccer)", "Basketball", "Cricket", "Tennis"], correctAnswer: "Football (Soccer)", difficulty: "easy", explanation: "FIFA World Cup."),
      Question(id: "sport_2", questionText: "How many players in a basketball team?", options: ["5", "6", "11", "7"], correctAnswer: "5", difficulty: "medium", explanation: "5 players on court."),
      Question(id: "sport_3", questionText: "Usain Bolt is famous for?", options: ["Sprinting", "Swimming", "Boxing", "Cycling"], correctAnswer: "Sprinting", difficulty: "easy", explanation: "Fastest man on earth."),
    ];
  }
}