import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
void inputEmail() {
  final User user = auth.currentUser!;
  final email = user.email;
  print("UID == $email");
  // here you write the codes to input the data into firestore
}

getEmail() {
  final User user = auth.currentUser!;
  final email = user.email;

  return email;
}

void inputUid() {
  final User user = auth.currentUser!;
  final uid = user.uid;
  print("UID == $uid");
  // here you write the codes to input the data into firestore
}
