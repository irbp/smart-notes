import 'package:equatable/equatable.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:smart_notes/core/error/app_error.dart';

abstract class SaveNoteUseCase {
  Future<Result<void, AppError>> call(NoteParams params);
}

class NoteParams extends Equatable {
  const NoteParams({required this.title, required this.description});

  final String title;
  final String description;

  @override
  List<Object?> get props => [title, description];
}
