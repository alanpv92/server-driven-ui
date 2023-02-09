import 'package:eleverdev/helpers/media_query.dart';
import 'package:eleverdev/mangers/text.dart';
import 'package:eleverdev/ui/widgets/common/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AuthBox extends StatelessWidget {
  const AuthBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20), borderSide: BorderSide.none),
      child: Column(
        children: [
           CustomTextFormField(hintText: TextManger.instance.authEmailHint),
           CustomTextFormField(hintText: TextManger.instance.authPasswordHint,ispass: true,),
          Container(
              margin: EdgeInsets.symmetric(
                vertical: MediaQueryHelper(context).safeBlockVertical * 2,
              ),
              child: SizedBox(
                width: MediaQueryHelper(context).safeBlockHorizontal * 40,
                height: MediaQueryHelper(context).safeBlockVertical * 4,
                child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    onPressed: () {},
                    child: const Text("Sign In")),//add to text manger
              ))
        ],
      ),
    );
  }
}
