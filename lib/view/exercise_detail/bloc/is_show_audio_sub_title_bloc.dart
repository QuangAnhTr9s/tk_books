import 'package:flutter_bloc/flutter_bloc.dart';
import '../event/is_show_audio_sub_title_event.dart';

class IsShowAudioSubTitleBloc extends Bloc<IsShowAudioSubTitleEvent, bool> {
  static const initIsShowMore = false;

  IsShowAudioSubTitleBloc() : super(false) {
    on<IsShowAudioSubTitleEvent>(
      (event, emit) => _showSubTitle(emit),
    );
  }

  _showSubTitle(Emitter<bool> emit) {
    emit(!state);
  }
}
