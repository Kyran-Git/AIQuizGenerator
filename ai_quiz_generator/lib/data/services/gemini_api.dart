import 'package:ai_quiz_generator/constants/gemini_constants.dart';

/// Thin wrapper around the Gemini API. Currently stubbed.
class GeminiApi {
  final String apiKey;

  GeminiApi({this.apiKey = GeminiConstants.API_KEY});

  Future<String> sendPrompt(String prompt) async {
    // TODO: Integrate with google_generative_ai and handle auth/errors.
    return 'Stub response for: $prompt';
  }

  Future<Map<String, dynamic>> receiveJson(String response) async {
    // TODO: Parse and validate the AI response JSON.
    return {'response': response};
  }
}
