/*
import 'package:flick_video_player/flick_video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_video_progress/smooth_video_progress.dart';
import 'package:tk_books/component/custom_slider.dart';
import 'package:tk_books/shared/const/images.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String url;
  final DataSourceType dataSourceType;
  final String? title;
  final String? subTitle;
  final bool isShowSub;
  final VoidCallback? onTapOpenSubTitle;

  const VideoPlayerWidget({
    Key? key,
    required this.url,
    required this.dataSourceType,
    this.title,
    this.subTitle,
    this.isShowSub = false,
    this.onTapOpenSubTitle,
  }) : super(key: key);

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _videoPlayerController;
  late FlickManager _flickManager;
  bool isLooping = false;
  bool isPlaying = false;
  bool showControls = false;
  String? title;
  String? subTitle;
  bool isSliderBeingInteracted =
  false; //kiểm tra thanh Slider có đang được giữ hay không

  @override
  void initState() {
    super.initState();
    title = widget.title;
    subTitle = widget.subTitle;
    switch (widget.dataSourceType) {
      case DataSourceType.asset:
        _videoPlayerController = VideoPlayerController.asset(widget.url);
        break;
      case DataSourceType.network:
        _videoPlayerController =
            VideoPlayerController.networkUrl(Uri.parse(widget.url));
        break;
    */
/*
      case DataSourceType.file:
        _videoPlayerController = VideoPlayerController.file();
        break;*//*

      case DataSourceType.contentUri:
        _videoPlayerController =
            VideoPlayerController.contentUri(Uri.parse(widget.url));
    }
    */
/* _videoPlayerController.initialize().then(
      (value) {
        setState(() {});
      },
    );*//*

    _flickManager = FlickManager(
      videoPlayerController: _videoPlayerController,
      autoPlay: false,
      autoInitialize: true,
    );
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    _flickManager.dispose();
    super.dispose();
  }

  void toggleControls() {
    setState(() {
      showControls = !showControls;
    });

    if (!isSliderBeingInteracted && showControls) {
      Future.delayed(const Duration(seconds: 4), () {
        setState(() {
          showControls = false;
        });
      });
    }
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      splashColor: Colors.transparent,
      onTap: () => toggleControls(),
      child: Stack(
        children: [
          _videoPlayerController.value.isInitialized
              ? Positioned.fill(
            bottom: 10,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  */
/*AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        ),*//*

                  FlickVideoPlayer(
                    flickManager: _flickManager,
                    flickVideoWithControls: Column(
                      children: [
                        AspectRatio(
                          aspectRatio: _videoPlayerController.value.aspectRatio,
                          child: VideoPlayer(_videoPlayerController),
                        ),
                      ],
                    ),

                  ),
                  if (widget.isShowSub)
                    Positioned(
                      bottom: 30, // Adjust this value as needed
                      child: Center(
                        child: Container(
                          width: 303,
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Center(
                            child: Text(
                              'Với các từ có tận cùng là “e”, khi chuyển sang',
                              style:
                              Theme.of(context).textTheme.bodyLarge,
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          )
              : const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              )),
          AnimatedOpacity(
            opacity: showControls ? 1 : 0,
            duration: const Duration(milliseconds: 300),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        title ?? '',
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                      Text(
                        subTitle ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black54,
                          child: Center(
                            child: Icon(
                              Icons.skip_previous_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        onTap: () {
                          if (_videoPlayerController.value.isPlaying) {
                            _videoPlayerController.pause();
                          } else {
                            _videoPlayerController.play();
                          }
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.black54,
                          child: Center(
                            child: Icon(
                              _videoPlayerController
                                  .value.isPlaying //quan ly lai state//
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      GestureDetector(
                        child: const CircleAvatar(
                          radius: 16,
                          backgroundColor: Colors.black54,
                          child: Center(
                            child: Icon(
                              Icons.skip_next_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ValueListenableBuilder<VideoPlayerValue>(
                              valueListenable: _videoPlayerController,
                              builder:
                                  (context, VideoPlayerValue value, child) {
                                return Text(
                                  formatTime(value.position),
                                  style: GoogleFonts.quicksand(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    height: 1.57,
                                    color: const Color(0xff8b90a7),
                                  ),
                                );
                              },
                            ),
                            Text(
                              formatTime(_videoPlayerController.value.duration),
                              style: GoogleFonts.quicksand(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                height: 1.57,
                                color: const Color(0xff8b90a7),
                              ),
                            ),
                          ],
                        ),
                        SmoothVideoProgress(
                          controller: _videoPlayerController,
                          builder: (context, position, duration, _) =>
                              CustomSlider(
                                videoPlayerController: _videoPlayerController,
                                position: position,
                                duration: duration,
                                onSliderInteraction: (isInteracting) {
                                  setState(() {
                                    isSliderBeingInteracted = isInteracting;
                                  });
                                },
                              ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Image.asset(MyImages.icRepeat),
                              onTap: () {
                                _videoPlayerController.setLooping(isLooping);
                              },
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  child: Image.asset(widget.isShowSub
                                      ? MyImages.icSubtitleOpened
                                      : MyImages.icSubtitle),
                                  onTap: () {
                                    if (widget.onTapOpenSubTitle != null) {
                                      widget.onTapOpenSubTitle!();
                                    }
                                  },
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                GestureDetector(
                                  child: Image.asset(MyImages.icZoom),
                                  onTap: () {
                                    _flickManager.flickControlManager?.toggleFullscreen();
                                  },
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
*/
