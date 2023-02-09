import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/mangers/color.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData? iconData;
  final String hintText;
  final bool ispass;
  const CustomTextFormField(
      {super.key, required this.hintText, this.iconData, this.ispass = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: MediaQueryHelper(context).safeBlockVertical * 2,
          horizontal: MediaQueryHelper(context).safeBlockVertical * 2),
      child: TextFormField(
        obscureText: ispass,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "this field is required";
          }
          return null;
        },
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            prefixIcon: iconData != null ? Icon(iconData) : null,
            fillColor: ColorManger.textFormFieldFilled,
            filled: true,
            hintText: hintText,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
