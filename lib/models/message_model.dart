class MessageModel{
  String? senderId;
  String? receiverId;
  String? message;
  String? dateTime;
  String? messageImage;

  MessageModel({this.senderId, this.receiverId, this.message, this.dateTime,this.messageImage});

  MessageModel.fromJson(Map<String,dynamic>? json){
    dateTime = json?['dateTime'];
    senderId = json?['senderId'];
    receiverId = json?['receiverId'];
    message = json?['message'];
    messageImage = json?['messageImage'];

  }

  Map<String,dynamic> toMap(){
    return {
      'dateTime' :dateTime,
      'senderId' :senderId,
      'receiverId' :receiverId,
      'message' :message,
      'messageImage' :messageImage,
    };
  }
}


