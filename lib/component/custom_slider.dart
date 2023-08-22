import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:video_player/video_player.dart';

class CustomSlider extends StatelessWidget {
  final VideoPlayerController? videoPlayerController;
  final AudioPlayer? audioPlayer;
  final Duration position;
  final Duration duration;
  final ValueChanged<bool>?
      onSliderInteraction; //kiểm tra thanh Slider có đang được giữ hay không
  const CustomSlider({
    super.key,
    this.videoPlayerController,
    this.audioPlayer,
    this.onSliderInteraction,
    required this.position,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: SliderTheme(
        data: SliderThemeData(
          thumbShape: const RoundSliderThumbShape(
            enabledThumbRadius: 10,
          ),
          trackShape: CustomTrackShape(),
        ),
        child: Slider(
          activeColor: const Color(0xff4db5b6),
          inactiveColor: const Color(0xffe0f2f3),
          onChanged: (value) {
            videoPlayerController == null
                ? audioPlayer!.seek(Duration(milliseconds: value.toInt()))
                : videoPlayerController!
                    .seekTo(Duration(milliseconds: value.toInt()));
            onSliderInteraction?.call(true);
          },
          onChangeStart: (_) {
            videoPlayerController == null
                ? audioPlayer!.pause()
                : videoPlayerController!.pause();
            onSliderInteraction?.call(true);
          },
          onChangeEnd: (_) {
            videoPlayerController == null
                ? audioPlayer!.play()
                : videoPlayerController!.play();
            onSliderInteraction?.call(false);
          },
          value: position.inMilliseconds.toDouble(),
          min: 0,
          max: duration.inMilliseconds.toDouble(),
        ),
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final trackHeight = sliderTheme.trackHeight;
    final trackLeft = offset.dx;
    final trackTop = offset.dy + (parentBox.size.height - trackHeight!) / 2;
    final trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}
