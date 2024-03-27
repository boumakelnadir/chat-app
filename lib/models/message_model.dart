import 'package:chatapp1/helper/constans.dart';

class MessageModel {
  final String message;
  final String email;

  MessageModel({required this.email, required this.message});
  factory MessageModel.fromJson(json) {
    return MessageModel(
      message: json[kMessage],
      email: json[kEmail],
    );
  }
}
