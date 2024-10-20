class SignUpResponseModel {
  String? message;
  Token? token;

  SignUpResponseModel({this.message, this.token});

  SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    token = json['token'] != null ? Token.fromJson(json['token']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = message;
    if (token != null) {
      data['token'] = token!.toJson();
    }
    return data;
  }
}

class Token {
  String? access;
  Token({this.access});
  Token.fromJson(Map<String, dynamic> json) {
    access = json['access'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access'] = access;
    return data;
  }
}

