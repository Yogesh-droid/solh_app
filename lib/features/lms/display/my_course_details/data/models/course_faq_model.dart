
import 'package:solh/features/lms/display/my_course_details/domain/entities/course_faq_entity.dart';

class CourseFaqModel extends CourseFaqEntity{

  

  CourseFaqModel({super.success, super.faqs});

 factory CourseFaqModel.fromJson(Map<String, dynamic> json) {
   return CourseFaqModel(
    success : json["success"],
    faqs : json["faqs"] == null ? null : (json["faqs"] as List).map((e) => Faqs.fromJson(e)).toList()
   );
  }


}

class Faqs {
  String? question;
  String? answer;
  String? id;

  Faqs({this.question, this.answer, this.id});

  Faqs.fromJson(Map<String, dynamic> json) {
    question = json["question"];
    answer = json["answer"];
    id = json["_id"];
  }

 
}