import 'package:email_validator/email_validator.dart';
import 'dart:convert';

/// [Routes] defines URIs for the application
class Routes {
  /// Route to the base (or Home) of the app
  static const home = '/';

  static const loginRedirect = '/login/next/:next_url';

  // Generate the above URL
  static String generateLoginRedirect(String nextUrl) => '/login/next/${stringToBase(nextUrl)}';

  /// Route for forms page where new users, meals, and classes can be created
  static const createMember = '/new/member';

  /// Route used after a password reset
  static const resetContinue = '/pw_reset/:email_hash';

  static const dashboard = '/dashboard';

  static const viewMembers = '/view/members';

  static const editMember = '/edit/member/:user_uid';

  static String generateEditMemberURL(String uid) => '/edit/member/$uid';

  static const viewActivity = '/view/activities';
  static const viewMeal = '/view/meals';

  // TODO: Fill in more routes here

}

//Validates various data types across project
class InputValidator {
  //Validates names, only issue is if blank
  static bool nameValidator(String input) {
    if (input == "") {
      return false;
    }
    return true;
  }

  //Validates emails by using emailValidator function
  static bool emailValidator(String input) {
    return EmailValidator.validate(input);
  }

  //Validates phone numbers
  static bool phoneNumberValidator(String input) {
    //Splits string into a list
    List<String> temp = input.split('');
    //Counts digits in input string
    int count = 0;
    for (String x in temp) {
      if (int.tryParse(x) != null) {
        count++;
      }
    }
    if (count == 10 || count == 11) {
      return true;
    } else {
      return false;
    }
  }

  //Validates addresses TODO finish this
  static bool addressValidator(String input) {
    return true;
  }
}

class ExportHeader {
  static const user = [
    'ID',
    'Last',
    'First',
    'Email',
    'Address',
    'Phone',
    'Cell',
    'Position',
    'Role',
    'Dietary Restrictions',
    'Disabilities',
    'Medical Issues',
    'Membership Start Date',
    'Membership Renewal Date',
  ];

  static const activity = [
    'ID',
    'Name',
    'Instructor',
    'Capacity',
    'location',
    'Start',
    'End',
  ];

  static const meal = [
    'ID',
    'Start',
    'End',
    'Menu',
  ];
}

enum Role {
  ADMIN,
  VOLUNTEER,
  MEMBER,
}

/// The different authentication states the UI can be in.
/// This should not be used as a replacement for firebase
/// auth checks.
enum AuthState { LOADING, SUCCESS, INAUTHENTIC, PASS_RESET_SENT, ERR_PASSWORD, ERR_NOT_FOUND, ERR_EMAIL, ERR_OTHER }

String stringToBase(String email) => base64Encode(utf8.encode(email));

String baseToString(String base) => utf8.decode(base64Decode(base));
