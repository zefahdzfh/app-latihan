// ignore: empty_constructor_bodies
class User1 {
  final String kantor;
  final String email;

  User1(this.email,this.kantor);
}

class User {
  String email;
  String password;

  User(this.email, this.password);
}

List<User> dataUser = [
  User("user123@gmail.com", "abc"),
  User("user456@gmail.com", "def"),
  User("user789@gmail.com", "ghi")
];