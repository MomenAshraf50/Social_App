class UserDataModel{
  String? email;
  String? name;
  String? phone;
  String? uid;
  String? image;
  String? coverImage;
  String? bio;

  UserDataModel({this.email, this.name, this.phone, this.uid,this.image,this.bio,this.coverImage});

  UserDataModel.fromJson(Map<String,dynamic>? json){
    email = json?['email'];
    name = json?['name'];
    phone = json?['phone'];
    uid = json?['uid'];
    image = json?['image'];
    bio = json?['bio'];
    coverImage = json?['coverImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'email' :email,
      'name' :name,
      'phone' :phone,
      'uid' :uid,
      'image' :image,
      'bio' :bio,
      'coverImage' :coverImage,
    };
  }
}