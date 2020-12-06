import 'package:firebase_auth/firebase_auth.dart';
import 'package:vita_instant/models/user.dart';

// AUTH INSTANCE
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

// PULL USER MODEL AND CREATE A USER OUT OF IT 
  User _userFromFirebaseUser(FirebaseUser user){
    return user != null ? User(uid:  user.uid) : null;
  }

// GET AUTH STREAM
  Stream<User> get user{
    return _auth.onAuthStateChanged
      .map((FirebaseUser user) => _userFromFirebaseUser(user));
  }

  // GET UID
  Future<String> getCurrentUID() async {
    return (await _auth.currentUser()).uid;
  }

// REGISTER ACCOUNT
  Future registerWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.createUserWithEmailAndPassword(email:email, password: password);
      FirebaseUser user = result.user;
      // Create a new firebase doc for the user
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }


  // sign in email and pass
  Future signInWithEmailAndPassword(String email, String password) async {
    try{
      AuthResult result = await _auth.signInWithEmailAndPassword(email:email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    }
    catch(e){
      print(e.toString());
      return null;
    }
  }

  // Sign Out
  Future signOut() async {
    try{
      return await _auth.signOut();
    }
    catch(e){
      print(e.toString());
      return null; 
    }
  }

  // Reset Password
  // Future sendPasswordResetEmail(String email) async {
  //   return _firebaseAuth.sendPasswordResetEmail(email: email);
  // }

  // Create Anonymous User
  // Future singInAnonymously() {
  //   return _firebaseAuth.signInAnonymously();
  // }


}

