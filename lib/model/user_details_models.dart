class UserModel {
  String? displayName;
  String? email;
  String? photoURL;

  //constructor
  UserModel({required this.displayName, required this.email, required this.photoURL});

  // we need to create map
  UserModel.fromJson(Map<String, dynamic> json) {
    displayName = json["displayName"];
    photoURL = json["photoUrl"];
    email = json["email"];
  }
  Map<String, dynamic> toJson() {
    // object - data
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['displayName'] = this.displayName;
    data['email'] = this.email;
    data['photoUrl]'] = this.photoURL;

    return data;
    
  }
}