import 'package:pocket_wise/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.uid,
    required super.email,
    required super.name,
    required super.photoUrl,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      photoUrl: json['photoUrl'],
    );
  }

  Map<String, dynamic> toJson(){
    return{
      'uid': uid,
      'email': email,
      'name': name,
      'photoUrl': photoUrl
    };
  }

}
