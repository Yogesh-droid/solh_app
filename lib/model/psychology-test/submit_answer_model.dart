
class SubmitAnswerModel {
  String? question;
  String? questionId;
  String? answer;
  String? answerId;

  SubmitAnswerModel(
      {this.question, this.questionId, this.answer, this.answerId});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['questionId'] = this.questionId;
    data['answer'] = this.answer;
    data['answerId'] = this.answerId;
    return data;
  }
}
