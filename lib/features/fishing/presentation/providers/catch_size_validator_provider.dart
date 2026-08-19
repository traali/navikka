import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sakkoja/features/fishing/domain/services/catch_size_validator.dart';

part 'catch_size_validator_provider.g.dart';

@riverpod
CatchSizeValidator catchSizeValidator(Ref ref) {
  return const CatchSizeValidator();
}
