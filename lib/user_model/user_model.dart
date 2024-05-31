class shopLoginModel {
  late bool status;
  String? message;
  UserData? data;

  shopLoginModel.fromjson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromjson(json['data']) : null;
  }
}

class UserData {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? message;
  String? image;
  int? points;
  int? credit;
  String? token;

//   UserModel({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.message,
//     this.image,
//     this.points,
//     this.credit,
//     this.token,
// });

  UserData.fromjson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    message = json['message'];
    image = json['image'];
    points = json['points'];
    credit = json['credit'];
    token = json['token'];
  }
}
