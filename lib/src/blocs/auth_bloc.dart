import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';
import 'package:smartfarmer/src/models/user.dart';
import 'package:smartfarmer/src/services/firestore_service.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');

class AuthBloc {
  final _email = BehaviorSubject<String>();
  final _password = BehaviorSubject<String>();
  final _user = BehaviorSubject<User>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();


  Stream<String> get email => _email.stream.transform(validateEmail);
  Stream<String> get password => _password.stream.transform(validatePassword);
  Stream<bool> get isValid => CombineLatestStream.combine2(email, password, (email,password)=> true);
  Stream<User> get user => _user.stream;


  Function(String) get changeEmail => _email.sink.add;
  Function(String) get changePassword => _password.sink.add;

  dispose(){
    _email.close();
    _password.close();
    _user.close();
  }

 
  final validateEmail = StreamTransformer<String,String>.fromHandlers(handleData: (email, sink){
    if (regExpEmail.hasMatch(email.trim())){
      sink.add(email.trim());
    }else {
      sink.addError('Must Be Valid Email Address');
    }
  });

  final validatePassword = StreamTransformer<String,String>.fromHandlers(handleData: (password, sink){
    if (password.length >= 8){
      sink.add(password.trim());
    }else {
      sink.addError('8 Character Minimum');
    }
  });

  //Functions
  signupEmail() async{
    try{
      AuthResult authResult = await _auth.createUserWithEmailAndPassword(email: _email.value.trim(), password: _password.value.trim());
      var user = User(userId: authResult.user.uid, email: _email.value.trim());
      await _firestoreService.addUser(user);
      _user.sink.add(user);
    } catch (error){
      print(error);
    }
  }

  loginEmail() async{
    try{
      AuthResult authResult = await _auth.signInWithEmailAndPassword(email: _email.value.trim(), password: _password.value.trim());
      var user = await _firestoreService.fetchUser(authResult.user.uid);
      _user.sink.add(user);
    } catch (error){
      print(error);
    }
  }

  Future<bool> isLoggedIn() async {
    var firebaseUser = await _auth.currentUser();
    if (firebaseUser == null) return false;

    var user = await _firestoreService.fetchUser(firebaseUser.uid);
    if (user == null) return false;

    _user.sink.add(user);
    return true;
  }
  logout() async {
    await _auth.signOut();
    _user.sink.add(null);
  }
}