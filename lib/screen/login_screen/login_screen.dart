import 'package:flutter/material.dart';
import 'package:flutter_chat_test_app/injection_work.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../api/login/use_cases/cases.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 45,
              width: 220,
              child: Material(
                borderRadius: BorderRadius.circular(5),
                color: Colors.black,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: MaterialButton(
                    onPressed: () async{
                      try{
                        final user = await di<GoogleLoginUseCase>().getUser();
                        print(user?.email);
                      }catch(e){ print(e.toString()); }

                    },
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
            ),
            const SizedBox(height: 10,),
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: (){
                di<GoogleLogoutUseCase>().logout();
              },
            )
          ],
        ),
      ),
    );
  }
}
