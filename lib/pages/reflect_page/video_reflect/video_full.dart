// import 'package:do_thi_thong_minh/pages/reflect/form_reflect_page/video_reflect/video_custom.dart';
// import 'package:flutter/material.dart';
// import 'package:lottie/lottie.dart';
//
//
// import 'package:video_player/video_player.dart';
//
//
// class VideoPlayerFullScreen extends StatefulWidget {
//   String link;
//   UniqueKey newKey;
//
//   VideoPlayerFullScreen(this.link, this.newKey) : super(key: newKey);
//
//   @override
//   VideoPlayerFullScreenState createState() =>
//       VideoPlayerFullScreenState(this.link);
// }
//
// class VideoPlayerFullScreenState extends State<VideoPlayerFullScreen> {
//   late VideoPlayerController _controller;
//   late String link;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   VideoPlayerFullScreenState(this.link);
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//       link,
//       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//     );
//
//     _controller.addListener(() {
//       setState(() {});
//     });
//     _controller.setLooping(true);
//     _initializeVideoPlayerFuture = _controller!.initialize();
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//         future: _initializeVideoPlayerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Container(
//               color: Colors.black,
//               // padding: EdgeInsets.only(top: context.paddingTop),
//               child: AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: <Widget>[
//                     Center(
//                       child: AspectRatio(
//                         aspectRatio: _controller.value.aspectRatio,
//                         child: VideoPlayer(_controller)
//                       ),
//                     ),
//                     ControlsOverlay(
//                       controller: _controller!,
//                       link: this.link,
//                     ),
//                     CustomVideoProgressIndicator(
//                       _controller!,
//                       allowScrubbing: true,
//                       timestamps: [],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Colors.white),
//                 child: Lottie.asset('assets/images/loading.json',
//                     width: 30, height: 30, frameRate: FrameRate.max));
//           }
//         });
//   }
// }
//
// class ControlsOverlay extends StatelessWidget {
//   String link = "";
//
//   ControlsOverlay({Key? key, required this.controller, required this.link})
//       : super(key: key);
//
//   static const _examplePlaybackRates = [
//     0.25,
//     0.5,
//     1.0,
//     1.5,
//     2.0,
//     3.0,
//     5.0,
//     10.0,
//   ];
//
//   final VideoPlayerController controller;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: <Widget>[
//         AnimatedSwitcher(
//           duration: Duration(milliseconds: 50),
//           reverseDuration: Duration(milliseconds: 200),
//           child: controller.value.isPlaying
//               ? SizedBox.shrink()
//               : Container(
//                   color: Colors.black26,
//                   child: Center(
//                     child: Icon(
//                       Icons.play_arrow,
//                       color: Colors.white,
//                       size: 100.0,
//                     ),
//                   ),
//                 ),
//         ),
//         GestureDetector(
//           onTap: () async {
//             controller.value.isPlaying
//                 ? await controller.pause()
//                 : await controller.play();
//           },
//         ),
//         Positioned(
//           top: 15,
//           right: 15,
//           child: InkWell(
//               onTap: () {
//                 Navigator.pop(context);
//               },
//               child: Icon(
//                 Icons.fullscreen_exit,
//                 color: Colors.white,
//                 size: 30,
//               )),
//         )
//       ],
//     );
//   }
// }
