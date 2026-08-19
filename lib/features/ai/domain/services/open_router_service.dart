import 'package:fpdart/fpdart.dart';
import 'package:sakkoja/core/errors/failure.dart';

/// Result of an AI explanation request.
typedef ExplanationResult = Either<Failure, String>;

/// Abstract interface for cloud-based AI explanation services.
///
/// Implementations handle the HTTP communication and fallback logic.
abstract class OpenRouterService {
  /// Sends a structured prompt to the AI model and returns the explanation text.
  ///
  /// [apiKey] is the user's OpenRouter API key.
  /// [modelId] is the primary model to use (e.g. 'meta-llama/llama-3.3-70b-instruct:free').
  /// [prompt] is the full formatted prompt (system + payload).
  ///
  /// If the primary model fails, the implementation should try the fallback chain:
  /// 1. primary modelId
  /// 2. 'meta-llama/llama-3.2-3b-instruct:free'
  /// 3. 'openrouter/free'
  Future<ExplanationResult> getExplanation({
    required String apiKey,
    required String modelId,
    required String prompt,
  });
}
