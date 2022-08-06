import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class LoginRepository{
  Future<GoogleSignInAccount?> getUser();
  Future<void> logout();
}

class LoginRepositoryImp implements LoginRepository{
  final GoogleSignIn googleSignIn;
  GoogleSignInAccount? googleUser;

  LoginRepositoryImp({required this.googleSignIn});

  @override
  Future<GoogleSignInAccount?> getUser() async{
    try{
      googleUser = googleSignIn.currentUser;
      googleUser = googleUser ?? await googleSignIn.signIn();
      if(googleUser == null) { return null; }
      else{
        final googleAuth = await googleUser?.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
        return googleUser;
      }
    }
    catch(e){ return Future.error(e.toString()); }
  }

  @override
  Future<void> logout() async{
    //await googleSignIn.signOut();
    await googleSignIn.signOut();

  }

}