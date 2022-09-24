class PostModel{
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? postText;
  String? postImage;

  PostModel({
    this.name,
    this.uid,
    this.image,
    this.dateTime,
    this.postText,
    this.postImage,
    });

  PostModel.fromJson(Map<String,dynamic>? json){
    dateTime = json?['dateTime'];
    name = json?['name'];
    postText = json?['postText'];
    uid = json?['uid'];
    image = json?['image'];
    postImage = json?['postImage'];
  }

  Map<String,dynamic> toMap(){
    return {
      'dateTime' :dateTime,
      'name' :name,
      'postText' :postText,
      'uid' :uid,
      'image' :image,
      'postImage' :postImage,
    };
  }
}