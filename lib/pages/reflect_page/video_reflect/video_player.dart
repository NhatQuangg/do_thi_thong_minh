// import 'package:do_thi_thong_minh/pages/reflect/form_reflect_page/video_reflect/video_full.dart';
// import 'package:flutter/material.dart';
//
// import 'package:video_player/video_player.dart';
//
// class VideoPlayerCustom extends StatefulWidget {
//   String link;
//   UniqueKey newKey;
//
//   VideoPlayerCustom(this.link, this.newKey) : super(key: newKey);
//
//   @override
//   VideoPlayerCustomState createState() => VideoPlayerCustomState(this.link);
// }
//
// class VideoPlayerCustomState extends State<VideoPlayerCustom> {
//   late VideoPlayerController _controller;
//   late String link;
//   late Future<void> _initializeVideoPlayerFuture;
//
//   VideoPlayerCustomState(this.link);
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
//     _initializeVideoPlayerFuture = _controller.initialize();
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
//               decoration: BoxDecoration(
//                   // color: Colors.black
//                   // border: Border.all(color: Colors.black),
//                   ),
//               child: AspectRatio(
//                 aspectRatio: _controller.value.aspectRatio,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: <Widget>[
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width * 2 / 3,
//                       child: ClipRect(
//                         child: OverflowBox(
//                           child: FittedBox(
//                             fit: BoxFit.fitWidth,
//                             child: SizedBox(
//                                 width: _controller!.value.size?.width ?? 0,
//                                 height: _controller!.value.size?.height ?? 0,
//                                 child: VideoPlayer(_controller)),
//                           ),
//                         ),
//                       ),
//                     ),
//                     ControlsOverlay(
//                       controller: _controller,
//                       link: this.link,
//                     ),
//                     // VideoProgressIndicator(_controller, allowScrubbing: true),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Container(
//                 width: MediaQuery.of(context).size.width * 2 / 3,
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(5),
//                     color: Colors.black),
//                 child: Center(child: CircularProgressIndicator()));
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
//         Align(
//           alignment: Alignment.topRight,
//           child: InkWell(
//               onTap: () async {
//                 await controller.pause();
//                 Navigator.of(context, rootNavigator: true)
//                     .push(MaterialPageRoute(
//                   builder: (context) =>
//                       VideoPlayerFullScreen(link, UniqueKey()),
//                 ));
//               },
//               child: Icon(
//                 Icons.fullscreen,
//                 color: Colors.white,
//               )),
//         )
//       ],
//     );
//   }
// }
