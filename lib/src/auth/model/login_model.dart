class LoginModel {
  // ignore: non_constant_identifier_names
  String? access_token;
  // ignore: non_constant_identifier_names
  String? refresh_token;

  // ignore: non_constant_identifier_names
  LoginModel({this.access_token, this.refresh_token});

  LoginModel.fromJson(Map<String, dynamic> json) {
    access_token = json['access_token'];
    refresh_token = json['refresh_token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['access_token'] = access_token;
    data['refresh_token'] = refresh_token;
    return data;
  }
}
