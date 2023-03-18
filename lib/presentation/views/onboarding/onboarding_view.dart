import 'package:flutter/services.dart';
import 'package:sehr/presentation/common/app_button_widget.dart';
import 'package:sehr/presentation/routes/routes.dart';
import 'package:sehr/presentation/src/index.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../../app/index.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late YoutubePlayerController _controller;
  late TextEditingController _idController;
  late TextEditingController _seekToController;

  // late PlayerState _playerState;
  // late YoutubeMetaData _videoMetaData;
  // final double _volume = 100;
  // final bool _muted = false;
  bool _isPlayerReady = false;

  final List<String> _videoIds = [
    YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=ho9kEuiB-pg&list=PLvQ2RGpesg2YG2ES7hsZ-nVI36NvKLxFO&ab_channel=SEHR')!,
    YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=KA69j9Z4JMs&list=PLvQ2RGpesg2YG2ES7hsZ-nVI36NvKLxFO&index=2&ab_channel=SEHR')!,
    YoutubePlayer.convertUrlToId(
        'https://www.youtube.com/watch?v=U87EzTr4IL4&list=PLvQ2RGpesg2YG2ES7hsZ-nVI36NvKLxFO&index=3&ab_channel=SEHR')!,

    // 'PLvQ2RGpesg2YG2ES7hsZ',
    // 'gQDByCdjUXw',
    // 'iLnmTe5Q2Qw',
    // '_WoCV4c6XOE',
    // 'KmzdUe0RSJo',
    // '6jZDSSZZxjQ',
    // 'p2lYr3vM_1w',
    // '7QUtEmBT_-w',
    // '34_PXCzGw1M',
  ];

  String? video1 = YoutubePlayer.convertUrlToId('url');

  // String? videoId(String url) {
  //   return YoutubePlayer.convertUrlToId(url);
  // }
  int index = 0;
  void next() {
    setState(() {
      index = index + 1;
    });
  }

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: _videoIds.first,
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    // _videoMetaData = const YoutubeMetaData();
    // _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        // _playerState = _controller.value.playerState;
        // _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
        SystemChrome.setPreferredOrientations(DeviceOrientation.values);
      },
      player: YoutubePlayer(
        controller: _controller,
        showVideoProgressIndicator: true,
        progressIndicatorColor: Colors.blueAccent,
        topActions: <Widget>[
          Expanded(
            child: Text(
              _controller.metadata.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: getProportionateScreenHeight(18),
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
        onReady: () {
          _isPlayerReady = true;
        },
        onEnded: (data) {
          _controller.load(_videoIds[
              (_videoIds.indexOf(data.videoId) + 1) % _videoIds.length]);
          // _showSnackBar('Next Video Started!');
        },
      ),
      builder: (context, player) => Scaffold(
        body: ListView(
          children: [
            player,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Expanded(
                  //   child: AppButtonWidget(
                  //     text: 'Back',
                  //     ontap: _isPlayerReady
                  //         ? () => _controller.load(_ids[
                  //             (_ids.indexOf(_controller.metadata.videoId) - 1) %
                  //                 _ids.length])
                  //         : null,
                  //   ),
                  // ),
                  // buildHorizontalSpace(100),
                  Expanded(
                    child: AppButtonWidget(
                      text: 'Next',
                      ontap: () {
                        index == 2
                            ? Get.offAndToNamed(Routes.loginRoute)
                            : (_isPlayerReady
                                ? _controller.load(_videoIds[(_videoIds.indexOf(
                                            _controller.metadata.videoId) +
                                        1) %
                                    _videoIds.length])
                                : null);
                        next();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
