import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app_variable/sign_in_condition.dart';
import '../../../screen/alert_dialog/data_model/drop_down_data.dart';

abstract class Repository{
  Future<User?> getUser();
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog();
  Future<void> logout();
  Future<void> createChatRoomForCurrentUser(String targetUser);
}

class RepositoryImp implements Repository{
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseInstance;
  final FirebaseFirestore fireStoreInstance;
  User? user;

  RepositoryImp({required this.googleSignIn, required this.firebaseInstance, required this.fireStoreInstance});

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
          await _createFirebaseUser();
          return user;
        }
      }
    }
    catch(e){ return Future.error(e.toString()); }
  }

  CollectionReference<Map<String, dynamic>> get _chatRoomCollectionCloud => fireStoreInstance.collection('chatRoom');
  
  CollectionReference<Map<String, dynamic>> get _userCollectionCloud => fireStoreInstance.collection('users');

  DocumentReference<Map<String, dynamic>> get _firebaseCurUserCloud => _userCollectionCloud.doc(_firebaseUserLocal?.uid);

  CollectionReference<Map<String, dynamic>> get _firebaseCurUserChatMapCloud => _firebaseCurUserCloud.collection('chatList');

  CollectionReference<Map<String, dynamic>> _targetUserChatMapCloud(String targetUserId){
    return _userCollectionCloud.doc(targetUserId).collection('chatList');
  }

  User? get _firebaseUserLocal => firebaseInstance.currentUser;
  
  String? get _userIdLocalStr => _firebaseUserLocal?.uid;
  
  Future<void> _createFirebaseUser() async{
    try{
      // collection read only
      // doc read + write only
      final curUserData = (await _firebaseCurUserCloud.get()).data();
      if(curUserData == null){
        final newData = {
          'name': _firebaseUserLocal?.displayName,
          'imageUrl': _firebaseUserLocal?.photoURL,
          'email': _firebaseUserLocal?.email,
        };
        await _firebaseCurUserCloud.set(newData);
      }
    }catch(e){
      final errorMessage = e.toString();
      return Future.error(errorMessage);
    }
  }

  @override
  Future<void> logout() async{
    await googleSignIn.signOut();
    await firebaseInstance.signOut();
    isSignedIn = false;
  }

  bool _userAlreadyInChatList(String targetId, List<QueryDocumentSnapshot<Map<String, dynamic>>> curUserChatMap){
    for(var item in curUserChatMap){ if(item.id == targetId) return true; }
    return false;
  }

  @override
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog() async{
    final curUserCollection = (await _userCollectionCloud.get()).docs;
    final curUserChatMap = (await _firebaseCurUserChatMapCloud.get()).docs;
    final list = <AlertDialogDropDownData>[];
    for (var element in curUserCollection) { 
      if(element.id != _userIdLocalStr && !(_userAlreadyInChatList(element.id, curUserChatMap))){
        final curData = element.data();
        list.add(AlertDialogDropDownData(
          id: element.id,
          name: curData['name'],
          imageUrl: curData['imageUrl'],
          email: curData['email'],
        ));
      }
    }
    return list;
  }

  @override
  Future<void> createChatRoomForCurrentUser(String targetUserId) async {
    final chatItemForCurrentUser = _firebaseCurUserChatMapCloud.doc(targetUserId);
    final chatItemForOtherUser = _targetUserChatMapCloud(targetUserId).doc(_userIdLocalStr);
    final newChatRoomId = '$targetUserId + $_userIdLocalStr';
    
    await Future.wait([
       chatItemForCurrentUser.set({'roomLocation' : newChatRoomId}),
       chatItemForOtherUser.set({'roomLocation' : newChatRoomId}),
       _chatRoomCollectionCloud.doc(newChatRoomId).set({}),
     ]);
  }
}