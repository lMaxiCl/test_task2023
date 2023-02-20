import 'package:json_annotation/json_annotation.dart';

part 'local_user.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocalUser {
  final String login;
  final String password;

  LocalUser(this.login, this.password);

  factory LocalUser.fromJson(Map<String, dynamic> json) {
    return _$LocalUserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}
