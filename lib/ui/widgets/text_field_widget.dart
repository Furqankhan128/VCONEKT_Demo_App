import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/colors.dart';
import '../../constants/style.dart';

class TextFieldWidget extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final bool obscureText;
  final keyboardType;
  final textInputAction;
  final void Function(String)? onChanged;
  final void Function()? onTap;
  final void Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final int maxLines;
  final maxLength;
  final TextAlign? textAlign;
  final text;
  TextEditingController textEditingController = TextEditingController();
  final width;
  final suffixIcon;
  final prefixIcon;
  final readonly;
  final inputFormatters;
  final bool isRight;
  final enabled;
  TextFieldWidget(
      {super.key, this.enabled = true,
      this.inputFormatters,
      this.isRight = false,
      this.prefixIcon,
      this.readonly = false,
      this.labelText,
      this.suffixIcon,
      this.width,
      this.textAlign,
      this.text,
      this.maxLength,
      this.maxLines = 1,
      this.hintText,
      this.obscureText = false,
      this.keyboardType,
      this.textInputAction,
      this.validator,
      this.onChanged,
      this.onTap,
      this.onSaved}) {
    textEditingController.text = text??"";
    textEditingController.selection = TextSelection.fromPosition(
        TextPosition(offset: textEditingController.text.length));
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      enabled: enabled,
      controller: textEditingController,
      inputFormatters: inputFormatters,
      obscureText: obscureText,
      style: kTextFieldStyle,
      textInputAction: textInputAction ?? TextInputAction.next,
      keyboardType: keyboardType,
      validator: validator,
      onTap: onTap,
      readOnly: readonly,
      onSaved: onSaved,
      cursorColor: kAccentColor,
      cursorHeight: 20.h,
      maxLines: maxLines,
      cursorWidth: 1.3,
      onChanged: onChanged,
      focusNode: onTap != null ? NeverFocusNode() : null,
      decoration: InputDecoration(
          contentPadding: maxLines > 1
              ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.w)
              : prefixIcon != null
                  ? EdgeInsets.symmetric(horizontal: 8.w).copyWith(top: 15.w)
                  : EdgeInsets.symmetric(horizontal: 8.w),
          hintText: hintText,
          labelText: labelText,
          hintStyle: kHintStyle,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          filled: true,
          fillColor: kWhiteColor,
          errorStyle: kErrorStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.8,color: kGreyColor
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.8,color: kBlackColor
            ),
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                width: 0.8,color: Colors.red
            ),
          ),
          labelStyle: kHintStyle),
    );
  }
}

class NeverFocusNode extends FocusNode {
  @override
  bool get hasFocus {
    return false;
  }
}
