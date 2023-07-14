import 'dart:async';

import 'package:draggable_notes/data/note.dart';
import 'package:draggable_notes/di/di_container.dart';
import 'package:draggable_notes/interactor/notes_interactor.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:mocktail/mocktail.dart';

import 'mock/mock_notes_interactor.dart';

Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  await loadAppFonts();
  _configureDependencies();
  return testMain();
}

void _configureDependencies() {
  final NotesInteractor notesInteractor = NotesInteractorMock();
  final notes = List<NoteDomain>.generate(
    7,
    (index) => NoteDomain(title: 'Note #$index', content: 'Content'),
  );
  when(
    notesInteractor.getNotes,
  ).thenAnswer(
    (_) => notes,
  );
  getIt.registerSingleton<NotesInteractor>(notesInteractor);
}
