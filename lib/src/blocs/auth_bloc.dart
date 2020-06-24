import 'dart:async';

import 'package:rxdart/streams.dart';
import 'package:rxdart/subjects.dart';

final RegExp regExpEmail = RegExp(
    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
class AuthBloc{
  final _email=BehaviorSubject<String>();
  final _password=BehaviorSubject<String>();

  //It's for get data
  Stream<String> get email=>_email.stream.transform(validateEmail);
  Stream<String> get password=>_password.stream.transform(validatePassword);
  Stream<bool> get isValid=>CombineLatestStream.combine2(email, password, (email,password) => true);


  //Set the data
  Function(String) get changeEmail =>_email.sink.add;
  Function(String) get changePassword =>_password.sink.add;

  dispose(){
    _email.close();
    _password.close();
  }
  final validateEmail=StreamTransformer<String,String>.fromHandlers(handleData: (email,sink){
    if(regExpEmail.hasMatch(email.trim())){
      sink.add(email.trim());
    }else{
      sink.addError('Enter Valid Email Address');
    }
  });

  final validatePassword=StreamTransformer<String,String>.fromHandlers(handleData: (password,sink){
    if(password.length>=8){
      sink.add(password.trim());
    }else{
      sink.addError('your password should be Minimum 8 characters');
    }
  });
}