import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app_variable/sign_in_condition.dart';

abstract class LoginRepository{
  Future<User?> getUser();
  Future<void> logout();
}

class LoginRepositoryImp implements LoginRepository{
  final GoogleSignIn googleSignIn;
  User? user;

  LoginRepositoryImp({required this.googleSignIn});

  @override
  Future<User?> getUser() async{
    try{
      user = FirebaseAuth.instance.currentUser;
      if(user != null){
        isSignedIn = true;
        return user;
      }
      else{
        final googleUser = await googleSignIn.signIn();
        if(googleUser == null) {
          isSignedIn = false;
          return null;
        }
        else{
          final googleAuth = await googleUser.authentication;
          final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth.accessToken,
            idToken: googleAuth.idToken,
          );
          await FirebaseAuth.instance.signInWithCredential(credential);
          user = FirebaseAuth.instance.currentUser;
          isSignedIn = true;
          await _createFirebaseUser(user!);
          return user;
        }
      }
    }
    catch(e){ return Future.error(e.toString()); }
  }
  
  Future<void> _createFirebaseUser(User user) async{
    try{
      final appCollection = FirebaseFirestore.instance.collection('users');
      final users = appCollection.doc(user.uid);
      final curUser = (await users.get()).data();
      print('testwork: $curUser');
      if(curUser == null){
        final newData = {
          'name': user.displayName,
          'imageUrl': user.photoURL,
          'email': user.email,
          'chatList': []
        };
        await users.set(newData);
      }
    }catch(e){
      print(e.toString());
    }
  }

  @override
  Future<void> logout() async{
    //await googleSignIn.signOut();
    await googleSignIn.signOut();
    await FirebaseAuth.instance.signOut();
    //await googleSignIn.disconnect();
    isSignedIn = false;
  }

}