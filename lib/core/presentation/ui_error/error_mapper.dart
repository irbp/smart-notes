import 'package:smart_notes/core/error/app_error.dart';
import 'package:smart_notes/core/error/domain_error.dart';
import 'package:smart_notes/core/presentation/ui_error/domain_error_mapper.dart';
import 'package:smart_notes/core/presentation/ui_error/error_strings.dart';

class ErrorMapper {
  ErrorMapper({this.domainErrorMapper});

  final DomainErrorMapper? domainErrorMapper;

  String fromAppError(AppError error) {
    return switch (error) {
      DomainError() =>
        domainErrorMapper?.fromDomainError(error) ?? _mapGenericError(),
      _ => _mapGenericError()
    };
  }

  String _mapGenericError() {
    return ErrorStrings.genericError;
  }
}
