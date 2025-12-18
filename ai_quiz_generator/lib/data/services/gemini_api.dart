import 'dart:convert';
import 'dart:async';
import 'dart:math';

import 'package:ai_quiz_generator/constants/gemini_constants.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

/// Wrapper around the Gemini API with temperature control.
class GeminiApi {
  final String apiKey;
  late GenerativeModel _model;

  GeminiApi({this.apiKey = GeminiConstants.API_KEY}) {
    _model = GenerativeModel(model: 'gemini-2.5-flash', apiKey: apiKey);
  }

  // Basic jittered exponential backoff for transient errors
  Future<T> _retry<T>(
    Future<T> Function() op, {
    int maxAttempts = 3,
    Duration baseDelay = const Duration(seconds: 1),
    FutureOr<void> Function(int attempt, Object error)? onRetry,
  }) async {
    Object? lastError;
    for (var attempt = 1; attempt <= maxAttempts; attempt++) {
      try {
        return await op();
      } catch (e) {
        lastError = e;
        // Decide if we should retry based on error type/message
        final msg = e.toString().toUpperCase();
        final retriable =
            msg.contains('503') || // Service Unavailable
            msg.contains('429') || // Too Many Requests / Quota
            msg.contains('UNAVAILABLE') ||
            msg.contains('RESOURCE_EXHAUSTED') ||
            msg.contains('OVERLOADED');

        if (!retriable || attempt == maxAttempts) break;

        if (onRetry != null) await onRetry(attempt, e);

        // Exponential backoff with jitter
        final delayMs = (baseDelay.inMilliseconds * pow(2, attempt - 1))
            .toInt();
        final jitter = Random().nextInt(250); // up to 250ms jitter
        await Future.delayed(Duration(milliseconds: delayMs + jitter));
      }
    }
    throw Exception('Gemini API error after retries: $lastError');
  }

  /// Send a prompt to Gemini with custom temperature.
  /// Temperature ranges from 0 (deterministic) to 2 (creative).
  Future<String> sendPrompt(
    String prompt, {
    double temperature = 0.7,
    void Function(int attempt, Object error)? onRetry,
  }) async {
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

    // Try with retries and optional fallback model on subsequent attempts
    var usedFallback = false;
    return _retry<String>(
      () async {
        final res = await _model
            .generateContent(
              content,
              safetySettings: safetySettings,
              generationConfig: generationConfig,
            )
            .timeout(const Duration(seconds: 30));
        return res.text ?? '';
      },
      maxAttempts: 3,
      onRetry: (attempt, error) async {
        // On the second attempt, switch to a lighter model to reduce overload
        if (!usedFallback && attempt >= 2) {
          usedFallback = true;
          _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
        }
        if (onRetry != null) onRetry(attempt, error);
      },
    );
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
