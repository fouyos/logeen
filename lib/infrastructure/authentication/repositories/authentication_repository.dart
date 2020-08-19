import 'dart:async';

import 'package:awas/domain/authentication/models/authentication_user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:meta/meta.dart';

/// Repository which manages user authentication.
class AuthenticationRepository {
  AuthenticationRepository({
    FirebaseAuth firebaseAuth,
    GoogleSignIn googleSignIn,
  })  : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  /// Signs in with the provided [email] and [password].
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    @required String email,
    @required String password,
  }) async {
    assert(
      email != null && password != null,
    );

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on Exception {
      throw LogInWithEmailAndPasswordFailure();
    }
  }

  /// Starts the Sign In with Google Flow.
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<void> logInWithGoogle() async {
    try {
      final _googleUser = await _googleSignIn.signIn();
      final _googleAuth = await _googleUser.authentication;
      final _credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken,
        idToken: _googleAuth.idToken,
      );

      await _firebaseAuth.signInWithCredential(
        _credential,
      );
    } on Exception {
      throw LogInWithGoogleFailure();
    }
  }

  /// Signs out the current user which will emit
  /// [User.empty] from the [user] Stream.
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      await Future.wait(
        [
          _firebaseAuth.signOut(),
          _googleSignIn.signOut(),
        ],
      );
    } on Exception {
      throw LogOutFailure();
    }
  }

  /// Stream of [AuthenticationUserModel] which will emit the current user
  /// when the authentication state changes.
  /// Emits [AuthenticationUserModel.empty] if the user is not authenticated.
  Stream<AuthenticationUserModel> get user {
    return _firebaseAuth.authStateChanges().map((
        firebaseUser,
        ) {
      return firebaseUser == null
          ? AuthenticationUserModel.empty
          : firebaseUser.user;
    });
  }
}

/// Declare extension on Firebase Authentication [User].
extension on User {
  AuthenticationUserModel get user {
    return AuthenticationUserModel(
      id: uid,
      email: email,
      name: displayName,
      photo: photoURL,
    );
  }
}

/// TODO Thrown during the login process if a failure occurs.
class LogInWithEmailAndPasswordFailure implements Exception {}

/// TODO Thrown during the sign in with google process if a failure occurs.
class LogInWithGoogleFailure implements Exception {}

/// TODO Thrown during the logout process if a failure occurs.
class LogOutFailure implements Exception {}
