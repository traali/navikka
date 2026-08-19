/// Constants for traffic sign types and identifiers.
///
/// Per AGENTS.md Section 11: No magic strings. All constants go in `lib/core/constants/`.
class SignConstants {
  SignConstants._(); // Private constructor prevents instantiation

  /// Finnish name for speed limit sign type.
  /// Used when a sign has a `rajoitusarvo` (speed limit value).
  static const String kSpeedLimitTypeName = 'Nopeusrajoitus';

  /// Unknown sign type fallback.
  static const String kUnknownTypeName = 'Unknown';
}
