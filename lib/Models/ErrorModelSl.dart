class DeleteModel {
  int? code;
  String? message;
  DeleteModel({this.code, this.message});

  factory DeleteModel.fromJson(dynamic jsons, stsCode) {
    return DeleteModel(code: stsCode, message: jsons['message']);
  }
factory DeleteModel.error(dynamic jsons, stsCode) {
    return DeleteModel(code: stsCode, message: jsons['error']);
  }

}

//  class Message{
//   String ?lang;
//   String ? value; 
//  Message({
//    this.lang,
//    this.value,
//  });

//   factory Message.fromJson(dynamic jsons) {
//     return Message(
//     //  groupCode: jsons['GroupCode'] as int, 
//       lang: jsons['lang']as String,
//       value: jsons['value'] as String,
   
//        );
//  }
//  }