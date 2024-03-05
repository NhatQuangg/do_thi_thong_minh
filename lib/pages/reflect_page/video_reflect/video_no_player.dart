// import 'package:flutter/material.dart';
// import 'package:video_player/video_player.dart';
//
// class VideoNoPlayer extends StatefulWidget {
//   String link;
//   UniqueKey newKey;
//
//   VideoNoPlayer(this.link, this.newKey) : super(key: newKey);
//
//   @override
//   VideoNoPlayerState createState() => VideoNoPlayerState(this.link);
// }
//
// class VideoNoPlayerState extends State<VideoNoPlayer> {
//   VideoPlayerController? _controller;
//   String link;
//   Future<void>? _initializeVideoPlayerFuture;
//
//   VideoNoPlayerState(this.link);
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = VideoPlayerController.network(
//       link,
//       videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
//     );
//
//     _controller!.addListener(() {
//       if (_controller!.value.hasError) {
//         print(_controller!.value.errorDescription);
//       }
//       setState(() {});
//     });
//     _controller!.setLooping(true);
//     _initializeVideoPlayerFuture = _controller!.initialize();
//   }
//
//   @override
//   void dispose() {
//     _controller!.dispose();
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
//                 borderRadius: BorderRadius.circular(10),
//                 // border: Border.all(color: Colors.black),
//               ),
//               child: AspectRatio(
//                 aspectRatio: _controller!.value.aspectRatio,
//                 child: Stack(
//                   alignment: Alignment.bottomCenter,
//                   children: <Widget>[
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: 400,
//                       child: ClipRect(
//                         child: OverflowBox(
//                           child: FittedBox(
//                             fit: BoxFit.fitWidth,
//                             child: _controller!.value.hasError
//                                 ? Container(
//                                     color: Colors.black,
//                                     width: MediaQuery.of(context).size.width,
//                                     height: 400,
//                                     child: Icon(
//                                       Icons.error_outline,
//                                       size: 50,
//                                       color: Colors.grey[700],
//                                     ),
//                                   )
//                                 : SizedBox(
//                                     width: _controller!.value.size?.width ?? 0,
//                                     height:
//                                         _controller!.value.size?.height ?? 0,
//                                     child: VideoPlayer(_controller!),
//                                   ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     ControlsOverlay(
//                       controller: _controller!,
//                       link: this.link,
//                     ),
//                     // VideoProgressIndicator(_controller, allowScrubbing: true),
//                   ],
//                 ),
//               ),
//             );
//           } else {
//             return Container(
//                 width: MediaQuery.of(context).size.width,
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
//     return SizedBox();
//   }
// }
