import 'package:flutter/material.dart';

Color backgroundColor1 = Color.fromARGB(255, 52, 51, 51);
Color backgroundColor2 = Color.fromRGBO(96, 165, 244, 0.89);
final String post_url = 'http://course-fourm.ian-shen.live/api/v1/posts';
final String tag_url = 'http://course-fourm.ian-shen.live/api/v1/tags';


class Userdata{
  String identity;
  String token;
  String department;

  Userdata({ required this.identity,required this.token, required this.department});

  factory Userdata.fromJson(Map<String, dynamic> json) {
    return Userdata(
      identity: json['identity'] as String,
      token: json['token'] as String,
      department: json['department'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['identity'] = this.identity;
    data['token'] = this.token;
    data['department'] = this.department;
    return data;
  }
}

class Post{
  String content;
  String create_by;
  String created_at;
  int id;
  int score;
  bool? state;
  List<Tag> tags;
  String title;
  String? updated_at;
  int? views;

 Post({
    required this.content,
    required this.create_by,
    required this.created_at,
    required this.id,
    required this.score,
     this.state,
    required this.tags,
    required this.title,
     this.updated_at,
     this.views,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      content: json['content'],
      create_by: json['create_by'],
      created_at: json['created_at'],
      id: json['id'],
      score: json['score'],
      state: json['state'],
      tags: List<Tag>.from(json['tags'].map((x) => Tag.fromJson(x))),
      title: json['title'],
      updated_at: json['updated_at'],
      views: json['views'],
    );
  }
  Map<String, dynamic> toJson() => {
        'content': content,
        'create_by': create_by,
        'created_at': created_at,
        'id': id,
        'score': score,
        'state': state,
        'tags': tags.map((tag) => tag.toJson()).toList(),
        'title': title,
        'updated_at': updated_at,
        'views': views,
      }; 
}
class Tag {
  String? created_at;
  int id;
  String name;
  String? updated_at;

  Tag({
     this.created_at,
     required this.id,
     required this.name,
     this.updated_at,
  });
  List<dynamic> jsonList=[];
  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'created_at': created_at,
        'updated_at': updated_at,
      };
      Map<String, dynamic> toJsonname() => {
        'name': name,
      };
}

class CreatPost{
  String content;
  String create_by;
  String created_at;
  int? id;
  int score;
  bool? state;
  List<int> tags;
  String title;
  String? updated_at;
  int? views;

 CreatPost({
    required this.content,
    required this.create_by,
    required this.created_at,
     this.id,
    required this.score,
     this.state,
    required this.tags,
    required this.title,
     this.updated_at,
     this.views,
  });

  factory CreatPost.fromJson(Map<String, dynamic> json) {
    return CreatPost(
      content: json['content'],
      create_by: json['create_by'],
      created_at: json['created_at'],
      id: json['id'],
      score: json['score'],
      state: json['state'],
      tags: List<int>.from(json['tags'].map((x) => Tag.fromJson(x))),
      title: json['title'],
      updated_at: json['updated_at'],
      views: json['views'],
    );
  }
  Map<String, dynamic> toJson() => {
        'content': content,
        'create_by': create_by,
        'created_at': created_at,
        'id': id,
        'score': score,
        'state': state,
        'tags': tags.map((tag) => tag).toList(),
        'title': title,
        'updated_at': updated_at,
        'views': views,
      }; 
}
class User {
  String email;
  String password;

  User({required this.email, required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      email: json['email'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['email'] = this.email;
    data['password'] = this.password;
    return data;
  }
}


class UpdatePost {
  bool state;
  UpdatePost({required this.state});

  factory UpdatePost.fromJson(Map<String, dynamic> json) {
    return UpdatePost(
      state: json['state'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    return data;
  }
}
class CreateTag {
  String name;
  
  CreateTag(this.name);
  
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    return data;
  }
}