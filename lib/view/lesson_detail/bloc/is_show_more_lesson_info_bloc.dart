import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tk_books/view/lesson_detail/event/is_show_more_leeson_info_event.dart';

class IsShowMoreLessonInfoBloc extends Bloc<IsShowMoreLeesonInfoEvent, bool> {
  static const initIsShowMore = false;

  IsShowMoreLessonInfoBloc() : super(false) {
    on<ShowMoreLeesonInfoEvent>(
      (event, emit) => _showMore(emit),
    );
  }

  _showMore(Emitter<bool> emit) {
    emit(!state);
  }
}
