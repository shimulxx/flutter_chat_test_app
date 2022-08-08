import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app_variable/sign_in_condition.dart';
import '../../../screen/alert_dialog/data_model/drop_down_data.dart';

abstract class LoginRepository{
  Future<User?> getUser();
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog({required String userId});
  Future<void> logout();
}

class LoginRepositoryImp implements LoginRepository{
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseInstance;
  final FirebaseFirestore fireStoreInstance;
  User? user;

  LoginRepositoryImp({required this.googleSignIn, required this.firebaseInstance, required this.fireStoreInstance});

  @override
  Future<User?> getUser() async{
    try{
      user = firebaseInstance.currentUser;
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
          await firebaseInstance.signInWithCredential(credential);
          user = firebaseInstance.currentUser;
          isSignedIn = true;
          await _createFirebaseUser(user!);
          return user;
        }
      }
    }
    catch(e){ return Future.error(e.toString()); }
  }

  CollectionReference<Map<String, dynamic>> get _userCollection => fireStoreInstance.collection('users');

  Future<void> _createFirebaseUser(User user) async{
    try{
      final curUser = _userCollection.doc(user.uid);//collection read only //doc read + write only
      final curUserData = (await curUser.get()).data();
      if(curUserData == null){
        final newData = {
          'name': user.displayName,
          'imageUrl': user.photoURL,
          'email': user.email,
        };
        await curUser.set(newData);
      }
    }catch(e){
      final errorMessage = e.toString();
      return Future.error(errorMessage);
    }
  }

  @override
  Future<void> logout() async{
    //await googleSignIn.signOut();
    await googleSignIn.signOut();
    await firebaseInstance.signOut();
    //await googleSignIn.disconnect();
    isSignedIn = false;
  }

  @override
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog({required String userId}) async{
    //final curUserCollection = (await _userCollection.get()).docs[0].data();
    final curUserCollection = (await _userCollection.get()).docs;
    final list = curUserCollection.map((e){
      final curData = e.data();
      return AlertDialogDropDownData(
        id: e.id,
        name: curData['name'],
        imageUrl: curData['imageUrl'],
        email: curData['email'],
      );
    }).toList();
    return list;
  }

}