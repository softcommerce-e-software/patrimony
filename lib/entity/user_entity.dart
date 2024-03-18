import 'dart:convert';

List<UserEntity> listUserEntityFromJson(String str) => List<UserEntity>
    .from(json.decode(str).map((model)=> UserEntity.fromJson(model)));
UserEntity userFromJson(String str) => UserEntity.fromJson(json.decode(str));
String userToJson(UserEntity data) => json.encode(data.toJson());
class UserEntity {
  UserEntity({
      String? id, 
      String? name, 
      String? email, 
      String? photo,}){
    _id = id;
    _name = name;
    _email = email;
    _photo = photo;
}

  UserEntity.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _email = json['email'];
    _photo = json['photo_url'];
  }
  String? _id;
  String? _name;
  String? _email;
  String? _photo;
  UserEntity copyWith({  bool? isAdmin,
  String? id,
  String? name,
  String? email,
  String? photo,
}) => UserEntity(
  id: id ?? _id,
  name: name ?? _name,
  email: email ?? _email,
  photo: photo ?? _photo,
);
  String? get id => _id;
  String? get name => _name;
  String? get email => _email;
  String? get photo => _photo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['email'] = _email;
    map['photo'] = _photo;
    return map;
  }

}