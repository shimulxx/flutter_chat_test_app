import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButton extends StatelessWidget {
  const LoginButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 45,
      width: 220,
      child: Material(
        borderRadius: BorderRadius.circular(5),
        color: Colors.black,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: MaterialButton(
            onPressed: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text('Google Sign In', style: TextStyle(fontSize: 18)),
                  SizedBox(width: 10,),
                  FaIcon(FontAwesomeIcons.google, color: Colors.green, size: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}