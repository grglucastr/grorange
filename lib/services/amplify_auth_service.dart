import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:get/get.dart';
import 'package:grorange/controllers/user_controller.dart';
import 'package:grorange/models/user.dart';

class AmplifyAuthService {
  UserController userController = Get.find();

  Future<bool> isUserSignedId() async {
    final result = await Amplify.Auth.fetchAuthSession();
    return result.isSignedIn;
  }

  Future<AuthUser> getCurrentUser() async {
    final user = await Amplify.Auth.getCurrentUser();
    return user;
  }

  Future<void> signUpUser({
    required String username,
    required String password,
    required String email,
  }) async {
    try {
      final userAttributes = {AuthUserAttributeKey.email: email};

      final result = await Amplify.Auth.signUp(
        username: username,
        password: password,
        options: SignUpOptions(
          userAttributes: userAttributes,
        ),
      );

      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing up user: ${e.message}');
    }
  }

  Future<void> _handleSignUpResult(SignUpResult result) async {
    switch (result.nextStep.signUpStep) {
      case AuthSignUpStep.confirmSignUp:
        final codeDeliveryDetails = result.nextStep.codeDeliveryDetails!;
        _handleCodeDelivery(codeDeliveryDetails);
        break;
      case AuthSignUpStep.done:
        safePrint('Sign up is complete');
        break;
    }
  }

  void _handleCodeDelivery(AuthCodeDeliveryDetails codeDeliveryDetails) {
    safePrint(
      'A confirmation code has been sent to ${codeDeliveryDetails.destination}'
      'Please check your ${codeDeliveryDetails.deliveryMedium.name} for the code.',
    );
  }

  Future<void> confirmUser({
    required String username,
    required String confirmationCode,
  }) async {
    try {
      final result = await Amplify.Auth.confirmSignUp(
        username: username,
        confirmationCode: confirmationCode,
      );

      // Check if further confirmations are needed or if
      // the sign up is complete
      await _handleSignUpResult(result);
    } on AuthException catch (e) {
      safePrint('Error confirming user: ${e.message}');
    }
  }

  Future<void> signInUser(String username, String password) async {
    try {
      final result = await Amplify.Auth.signIn(
        username: username,
        password: password,
      );
      await _handleSignInResult(result);
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
  }

  Future<void> _handleSignInResult(SignInResult result) async {
    if (result.nextStep.signInStep == AuthSignInStep.done) {
      safePrint('Sign in is complete');

      const DateTime? dateTime = null;

      if (result.isSignedIn) {
        userController.userSignedIn = true;
        AuthUser authUser = await getCurrentUser();
        userController.user = User(
          authUser.userId,
          authUser.username,
          dateTime,
          dateTime,
        );
      }
    }
  }

  Future<SignInResult?> socialSignIn() async {
    try {
      final result = await Amplify.Auth.signInWithWebUI(
        provider: AuthProvider.google,
      );

      safePrint('Sign in result: $result');
      _handleSignInResult(result);

      return result;
    } on AuthException catch (e) {
      safePrint('Error signing in: ${e.message}');
    }
    return null;
  }

  Future<SignOutResult?> signOut() async {
    try {
      final result = await Amplify.Auth.signOut();
      _handleSignOut(result);
      return result;
    } on AuthException catch (e) {
      safePrint('Error signing out in: ${e.message}');
    }
  }

  Future<void> _handleSignOut(SignOutResult result) async {
    safePrint('Sign out result: $result');

    result as CognitoSignOutResult;
    if (result.signedOutLocally) {
      userController.userSignedIn = false;
    }
  }
}
