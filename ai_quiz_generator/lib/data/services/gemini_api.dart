import 'dart:convert';

import 'package:ai_quiz_generator/constants/gemini_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Wrapper around the Gemini API with temperature control.
class GeminiApi {
  final String apiKey;
  late GenerativeModel _model;

  GeminiApi({this.apiKey = GeminiConstants.API_KEY}) {
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  }

  /// Send a prompt to Gemini with custom temperature.
  /// Temperature ranges from 0 (deterministic) to 2 (creative).
  Future<String> sendPrompt(String prompt, {double temperature = 0.7}) async {
    try {
      final safetySettings = [
        SafetySetting(HarmCategory.harassment, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.none),
        SafetySetting(HarmCategory.dangerousContent, HarmBlockThreshold.none),
      ];

      final generationConfig = GenerationConfig(
        temperature: temperature,
        topK: 40,
        topP: 0.95,
      );

      final content = [Content.text(prompt)];
      final response = await _model.generateContent(
        content,
        safetySettings: safetySettings,
        generationConfig: generationConfig,
      );

      return response.text ?? '';
    } catch (e) {
      throw Exception('Gemini API error: $e');
    }
  }

  /// Parse JSON response from Gemini.
  Future<Map<String, dynamic>> receiveJson(String response) async {
    try {
      // Remove markdown code block formatting if present
      String cleaned = response.trim();
      if (cleaned.startsWith('```json')) {
        cleaned = cleaned.substring(7); // Remove ```json
      }
      if (cleaned.startsWith('```')) {
        cleaned = cleaned.substring(3); // Remove ```
      }
      if (cleaned.endsWith('```')) {
        cleaned = cleaned.substring(0, cleaned.length - 3);
      }
      cleaned = cleaned.trim();

      final parsed = jsonDecode(cleaned) as Map<String, dynamic>;
      return parsed;
    } catch (e) {
      throw Exception('Failed to parse JSON response: $e');
    }
  }
}
