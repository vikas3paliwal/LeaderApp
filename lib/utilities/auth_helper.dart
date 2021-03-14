import 'http_exception.dart';
import 'api_helper.dart';

Future<bool> autoLogin() async {
  final status = await ApiHelper().isLoggedIn();
  //print(status);
  print('uID: ${ApiHelper().getUID()},');
  return status;
}

Future<void> SignUp(String email, String password) async {
  print('email: $email password: $password');
  Map<String, String> data = {
    'email': email,
    'username': email,
    'password1': password,
    'password2': password,
    'mobile': "",
    'first_name': "",
    'last_name': "",
  };
  try {
    await ApiHelper().SignUp(data);
  } on HttpException catch (error) {
    throw HttpException(message: error.toString());
  } catch (error) {
    throw error;
  }
}

Future<void> logIn(String email, String password) async {
  print('email: $email password: $password');
  Map<String, String> data = {
    'email': email,
    'password': password,
  };
  try {
    await ApiHelper().logIn(data);
  } on HttpException catch (error) {
    throw HttpException(message: error.toString());
  } catch (error) {
    throw error;
  }
}

Future<void> logOut() async {
  //Flush other variables if required
  await ApiHelper().logOut();
}
