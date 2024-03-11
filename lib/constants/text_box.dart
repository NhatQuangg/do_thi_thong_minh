// import 'package:flutter/material.dart';
//
// class MyTextBox extends StatelessWidget {
//   final String text;
//   final String sectionName;
//   final void Function()? onPressed;
//   const MyTextBox(
//       {super.key,
//       required this.text,
//       required this.sectionName,
//       required this.onPressed});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.grey[200], borderRadius: BorderRadius.circular(8)),
//       padding: EdgeInsets.only(left: 15, bottom: 15),
//       margin: EdgeInsets.only(left: 20, right: 20, top: 20),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // section name
//               Text(
//                 sectionName,
//                 style: TextStyle(color: Colors.grey[500]),
//               ),
//               // edit button
//               IconButton(
//                   onPressed: onPressed,
//                   icon: Icon(
//                     Icons.settings,
//                     color: Colors.grey[800],
//                   ))
//             ],
//           ),
//           // text
//           Text(text),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class MyTextBox extends StatelessWidget {
  final String text;
  final String sectionName;
  final void Function()? onPressed;
  final bool obscureText; // Thêm thuộc tính mới để quyết định liệu có hiển thị text hay không

  const MyTextBox({
    Key? key,
    required this.text,
    required this.sectionName,
    required this.onPressed,
    required this.obscureText, // Gán giá trị mặc định là false
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.only(left: 15, bottom: 15),
      margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // section name
              Text(
                sectionName,
                style: TextStyle(color: Colors.grey[500]),
              ),
              // edit button
              IconButton(
                onPressed: onPressed,
                icon: Icon(
                  Icons.settings,
                  color: Colors.grey[800],
                ),
              )
            ],
          ),
          // text
          // Sử dụng TextFormField để có thể điều chỉnh thuộc tính obscureText
          TextFormField(
            readOnly: true, // Đảm bảo rằng nó chỉ đọc
            initialValue: text,
            obscureText: obscureText, // Sử dụng giá trị từ thuộc tính
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }
}