import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tk_books/view/exercise_detail/event/is_show_video_sub_title_event.dart';
import '../event/is_show_audio_sub_title_event.dart';

class IsShowVideoSubTitleBloc extends Bloc<IsShowVideoSubTitleEvent, bool> {
  static const initIsShowMore = false;

  IsShowVideoSubTitleBloc() : super(false) {
    on<IsShowVideoSubTitleEvent>(
      (event, emit) => _showSubTitle(emit),
    );
  }

  _showSubTitle(Emitter<bool> emit) {
    emit(!state);
  }
}
