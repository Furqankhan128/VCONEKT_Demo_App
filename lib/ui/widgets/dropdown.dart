// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class Dropdown extends StatelessWidget {
//   final Function onChanged;
//   final String hint;
//   final List<DropdownMenuItem<dynamic>> items;
//   final value;
//
//   Dropdown({this.value, this.hint, this.items, this.onChanged});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 44.h,
//       decoration: BoxDecoration(
//           color: kLightBlueShade, borderRadius: kTextFieldBorderRadius),
//       alignment: Alignment.center,
//       padding: kBoxPadding,
//       child: DropdownButton(
//         style: kTextFieldStyle,
//         dropdownColor: Colors.white,
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         hint: Text(
//           hint ?? '',
//           style: kHintStyle,
//         ),
//         isExpanded: true,
//         elevation: 0,
//         underline: Container(),
//         onChanged: onChanged,
//         items: items,
//         value: value,
//       ),
//     );
//   }
// }
