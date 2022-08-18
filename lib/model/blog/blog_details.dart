class BlogDetails {
  int? id;
  String? name;
  String? description;
  String? status;
  int? isFeatured;
  int? views;
  String? image;
  String? content;

  BlogDetails(
      {this.id,
      this.name,
      this.description,
      this.status,
      this.isFeatured,
      this.views,
      this.image,
      this.content});

  BlogDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    status = json['status'];
    isFeatured = json['is_featured'];
    views = json['views'];
    image = json['image'];
    content = json['content'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['status'] = this.status;
    data['is_featured'] = this.isFeatured;
    data['views'] = this.views;
    data['image'] = this.image;
    data['content'] = this.content;
    return data;
  }
}
