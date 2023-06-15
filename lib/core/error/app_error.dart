import 'package:equatable/equatable.dart';

abstract class AppError extends Equatable {
  @override
  List<Object?> get props => List.empty();
}

final class GenericError extends AppError {}
