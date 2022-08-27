import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../app_variable/sign_in_condition.dart';
import '../../../screen/alert_dialog/data_model/drop_down_data.dart';
import '../../core/constants.dart';
import '../../screen/chat_details_screen/data_model/chat_detail_item_data.dart';
import '../../screen/chat_list_screen/data_model/chat_item_data.dart';

abstract class Repository{
  Future<User?> getUser();
  Future<List<AlertDialogDropDownData>> getUsrListForAlertDialog();
  Future<void> logout();
  Future<void> createChatRoomForCurrentUser(String targetUser);
  Stream<List<ChatItemData>> getStreamChatItemData();
  Stream<List<ChatDetailItemData>> getStreamChatDetailsItemData({required String chatRoomId});
  String? getCurrentUserStr();
  Future<void> sendCurrentData({required ChatDetailItemData curData, required String chatRoomId});
  Future<void> updateDelivery({required List<String> updateList, required String chatRoomId});
  Stream<ChatDetailItemData> getSingleStream({required String chatRoomId});
}

class RepositoryImp implements Repository{
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseInstance;
  final FirebaseFirestore fireStoreInstance;
  final Dio dio;
  User? user;

  RepositoryImp({
    required this.googleSignIn, 
    required this.firebaseInstance, 
    required this.fireStoreInstance,
    required this.dio,
  });

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

  @override
  String? getCurrentUserStr() => _userIdLocalStr;

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
       //_chatRoomCollectionCloud.doc(newChatRoomId).set({}),
     ]);
  }

  @override
  Stream<List<ChatItemData>> getStreamChatItemData() {
    return _userCollectionCloud.doc(_userIdLocalStr).collection('chatList')
        .snapshots().asyncMap((snapShot) async{
          final curData = snapShot.docs;
          final curList = <ChatItemData>[];
          for(var item in curData){
            final curMap = item.data();
            final chatRoomId = curMap['roomLocation'];
            final curUserData = (await _userCollectionCloud.doc(item.id).get()).data()!;
            curList.add(ChatItemData(
              lastChat: 'not set',
              imageUrl: curUserData['imageUrl'],
              name: curUserData['name'],
              lastTime: '10:11 pm',
              isDelivered: true,
              chatRoomId: chatRoomId
            ));
          }
          return curList;
    });
  }

  @override
  Stream<List<ChatDetailItemData>> getStreamChatDetailsItemData({required String chatRoomId}){
    return _chatRoomCollectionCloud.doc(chatRoomId).collection('chats')
        .snapshots().asyncMap((snapShot) {
          final curData = snapShot.docs;
          final curList = <ChatDetailItemData>[];
          for(var item in curData){
            final curMap = item.data();
            curList.add(ChatDetailItemData(
              userId: curMap['userId'],
              sendTime: curMap['sendTime'], //item.id,
              chatText: curMap['text'],
              isDelivered: curMap['isDelivered'],
              epocTime: curMap['epocTime'],
            ));
          }
          return curList;
        }
    );
  }

  @override
  Future<void> sendCurrentData({required ChatDetailItemData curData, required String chatRoomId}) async{
    //final response = await dio.get(kDhakaApi);
    final response = await dio.get(kEstNow);
    if(response.statusCode == 200){
      //final epocTime = jsonDecode(response.data)['unixtime'].toString();
      final epocTime = jsonDecode(response.data)['currentFileTime'].toString();
      final newData = _chatRoomCollectionCloud.doc(chatRoomId).collection('chats').doc(epocTime);
      await newData.set({
        'text': curData.chatText,
        'isDelivered': curData.isDelivered,
        'userId': curData.userId,
        'sendTime': curData.sendTime,
        'epocTime': epocTime,
      });
    }
  }

  @override
  Future<void> updateDelivery({required List<String> updateList, required String chatRoomId}) async{
    if(updateList.isNotEmpty){
      final curChats = _chatRoomCollectionCloud.doc(chatRoomId).collection('chats');
      for(var i = 0; i < updateList.length; ++i){
        final curListItem = updateList[i];
        final oldItem = curChats.doc(curListItem);
        final mp = (await oldItem.get()).data()!;
        mp['isDelivered'] = true;
        oldItem.update(mp);
      }
    }
  }

  @override
  Stream<ChatDetailItemData> getSingleStream({required String chatRoomId}) {
    return  _chatRoomCollectionCloud.doc(chatRoomId).collection('chats')
        .snapshots().asyncMap((snapShot){
          final curList = snapShot.docs;
          if(curList.isNotEmpty){
            final curMap = curList[curList.length - 1].data();
            return ChatDetailItemData(
              userId: curMap['userId'],
              sendTime: curMap['sendTime'], //item.id,
              chatText: curMap['text'],
              isDelivered: curMap['isDelivered'],
            );
          }
          else { return ChatDetailItemData.empty(); }
        });
  }
}