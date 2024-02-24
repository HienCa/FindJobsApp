import 'package:findjobs/constants/app_constants.dart';
import 'package:findjobs/views/common/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MessagingTextField extends StatelessWidget {
  const MessagingTextField(
      {super.key,
      required this.messageTextEditingController,
      required this.suffixIcon, this.onChanged, this.onEditingComplete, this.onTapOutside, this.onSubmitted});

  final TextEditingController messageTextEditingController;
  final Widget suffixIcon;
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final void Function()? onEditingComplete;
  final void Function(PointerDownEvent)? onTapOutside;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: messageTextEditingController,
      cursorColor: Color(kDarkGrey.value),
      keyboardType: TextInputType.multiline,
      style: appstyle(16, Color(kDark.value), FontWeight.w500),
      decoration: InputDecoration(
          isDense: true,
          filled: true,
          contentPadding: EdgeInsets.all(6.h),
          fillColor: Color(kLight.value),
          hintText: "Text your message here...",
          hintStyle: appstyle(14, Color(kDarkGrey.value), FontWeight.normal),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            borderSide: BorderSide(color: Color(kDarkGrey.value)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(12.h)),
            borderSide: BorderSide(color: Color(kDarkGrey.value)),
          ),
          suffixIcon: suffixIcon),
      onChanged: onChanged,
      onEditingComplete: onEditingComplete,
      onTapOutside: onTapOutside,
      onSubmitted: onSubmitted,
    );
  }
}
