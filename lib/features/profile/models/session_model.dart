import 'package:equatable/equatable.dart';

class SessionModel with EquatableMixin {
  final String accessToken;
  final String refreshToken;

  const SessionModel({
    required this.accessToken,
    required this.refreshToken,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) => SessionModel(
    accessToken: json["accessToken"] as String,
    refreshToken: json["refreshToken"] as String
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "refreshToken": refreshToken
  };

  @override
  List<Object?> get props => [refreshToken, accessToken];
}
