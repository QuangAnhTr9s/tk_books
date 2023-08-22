import 'package:flutter_bloc/flutter_bloc.dart';

import '../event/show_more_study_program_event.dart';

class IsShowMoreStudyProgramBloc extends Bloc<IsShowMoreStudyProgramEvent, bool> {
  static const initIsShowMore = false;

  IsShowMoreStudyProgramBloc() : super(false) {
    on<ShowMoreStudyProgramEvent>(
      (event, emit) => _showMore(emit),
    );
  }

  _showMore(Emitter<bool> emit) {
    emit(!state);
  }
}
