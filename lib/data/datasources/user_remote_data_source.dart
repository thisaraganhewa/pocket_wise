import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pocket_wise/firebase_options.dart';
import 'package:http/http.dart' as http;

abstract class UserRemoteDataSource {
  Future<User?> logOrRegister();
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final firebaseOptions = DefaultFirebaseOptions.currentPlatform;
  late final GoogleSignInAccount? googleUser;
  bool _isAuthorized = false;
  String _contactText = '';
  String _errorMessage = '';
  String _serverAuthCode = '';
  final List<String> scopes = <String>[
    'https://www.googleapis.com/auth/contacts.readonly',
  ];

  @override
  Future<User?> logOrRegister() async {
    String? clientId = firebaseOptions.iosClientId;
    String? serverClientId = firebaseOptions.iosClientId;
    try {
      unawaited(
        _googleSignIn
            .initialize(clientId: clientId, serverClientId: serverClientId)
            .then((_) {
              _googleSignIn.authenticationEvents.listen().onError();
              _googleSignIn.attemptLightweightAuthentication();
            }),
      );
    } catch (e) {
      print("Google Sign-In error: $e");
      return null;
    }
  }

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes(scopes);

    googleUser = user;
    _isAuthorized = authorization != null;
    _errorMessage = "";

    if (googleUser != null && authorization != null) {}
  }

  Future<void> _handleGetContact(GoogleSignInAccount user) async {
    final Map<String, String>? headers = await user.authorizationClient
        .authorizationHeaders(scopes); //get relevent permission headers

    if (headers == null) {
      //if headers are null it just return
      return;
    }

    final http.Response response = await http.get(
      Uri.parse(
        'https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names',
      ),
      headers: headers,
    );
  }

  Future<void> _handleAuthenticationError(Object e) async {
    googleUser = null;
    _isAuthorized = false;
    _errorMessage = e is GoogleSignInException
        ? _errorMessageFromSignInException(e)
        : "Uknown Error : $e";
  }

  String _errorMessageFromSignInException(GoogleSignInException e) {
    return switch (e.code) {
      GoogleSignInExceptionCode.canceled => 'Sign In Canceled',
      _ => 'GoogleSignInException ${e.code}: ${e.description}',
    };
  }

  Future<void> _handleContact(GoogleSignInAccount user) async {
    final Map<String, String>? headers = await user.authorizationClient
        .authorizationHeaders(scopes);

    if (headers == null) {
      //handle authrization failed events here
      return;
    }

    //get the list of people like contacts
    final http.Response response = await http.get(
      Uri.parse(
        'https://people.googleapis.com/v1/people/me/connections'
        '?requestMask.includeField=person.names',
      ),
      headers: headers,
    );

    if (response.statusCode != 200) {
      if (response.statusCode == 401 || response.statusCode == 403) {
        _isAuthorized =
            false; //if responce status not qualse to 200 and the status code is 401 or 403 is authorization will be set to false
        _errorMessage =
            'People API gave a ${response.statusCode} response. '
            'Please re-authorize access.'; //assign thses message to error message after the request is failed
      } else {
        print(
          'People API ${response.statusCode} response: ${response.body}',
        ); //if there is status code other than 401 or 403 .. like 500 this section will
        _contactText =
            'People API gave a ${response.statusCode} '
            'response. Check logs for details.';
      }
      return;
    }
    final Map<String, dynamic> data =
        json.decode(response.body) as Map<String, dynamic>;

    final String? namedContact = _pickFirstNameContact(
      data,
    ); //gets the first name of the contacts

    if (namedContact != null) {
      //if the name is null shows no contacts founf if not it ll show the contact
      _contactText = 'I see you know $namedContact!';
    } else {
      _contactText = 'No contacts to display.';
    }
  }

  String? _pickFirstNameContact(Map<String, dynamic> data) {
    final List<dynamic>? connections =
        data['connections']
            as List<
              dynamic
            >?; //extract the connection list which have the contacts from the JSON
    final Map<String, dynamic>? contact =
        connections?.firstWhere(
              (dynamic contact) =>
                  (contact as Map<Object?, dynamic>)['names'] != null,
              orElse: () => null,
            )
            as Map<String, dynamic>?;

    if (contact != null) {
      final List<dynamic> names = contact['names'] as List<dynamic>;
      final Map<String, dynamic>? name =
          names.firstWhere(
                (dynamic name) =>
                    (name as Map<Object?, dynamic>)['displayName'] != null,
                orElse: () => null,
              )
              as Map<String, dynamic>?;

      if (name != null) {
        return name['displayName'] as String?;
      }
    }
    return null;
  }

  Future<void> _handleAuthorizationScopes(GoogleSignInAccount user) async {
    try {
      final GoogleSignInClientAuthorization? authorization = await user
          .authorizationClient
          .authorizationForScopes(scopes);

      authorization;

      _isAuthorized = true;
      _errorMessage = '';
    } on GoogleSignInException catch (e) {
      _errorMessage = _errorMessageFromSignInException(e);
    }
  }

  Future<void> _handleGetAuthCode(GoogleSignInAccount user) async {
    try {
      final GoogleSignInServerAuthorization? serverAuth = await user
          .authorizationClient
          .authorizeServer(scopes);

      _serverAuthCode = serverAuth == null ? '' : serverAuth.serverAuthCode;
    } on GoogleSignInException catch (e) {
      _errorMessage = _errorMessageFromSignInException(e);
    }
  }
}
