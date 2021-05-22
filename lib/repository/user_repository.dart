import 'dart:async';
import 'package:adai/model/user_model.dart';
import 'package:meta/meta.dart';
import 'package:adai/model/api_model.dart';
import 'package:adai/api_connection/api_connection.dart';
import 'package:adai/dao/user_dao.dart';

class UserRepository {
  final userDao = UserDao();

  Future<User> authenticate({
    @required String username,
    @required String password,
  }) async {
    UserLogin userLogin = UserLogin(username: username, password: password);
    Token token = await getToken(userLogin);
    User user = User(
      id: 0,
      username: username,
      token: token.token,
    );
    return user;
  }

  Future<void> persistToken({@required User user}) async {
    // write token with the user to the database
    await userDao.createUser(user);
  }

  Future<void> deleteToken({@required int id}) async {
    await userDao.deleteUser(id);
  }

  Future<bool> hasToken() async {
    bool result = await userDao.checkUser(0);
    return result;
  }

  // Future<User> addno({@required String phoneno}) async {
  //   User user = User(
  //     id: 0,
  //     username: phoneno,
  //     token: "",
  //   );
  //   return user;
  // }
}
