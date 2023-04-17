import 'dart:convert';
import 'package:flutter/material.dart';
class Post{
  String content;
  String createdBy;
  String createdAt;
  int id;
  int score;
  bool state;
  List<Tag> tags;
  String title;
  String updatedAt;
  int views;

 Post({
    required this.content,
    required this.createdBy,
    required this.createdAt,
    required this.id,
    required this.score,
    required this.state,
    required this.tags,
    required this.title,
    required this.updatedAt,
    required this.views,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      content: json['content'],
      createdBy: json['create_by'],
      createdAt: json['created_at'],
      id: json['id'],
      score: json['score'],
      state: json['state'],
      tags: List<Tag>.from(json['tags'].map((x) => Tag.fromJson(x))),
      title: json['title'],
      updatedAt: json['updated_at'],
      views: json['views'],
    );
  }

  
  
}
class Tag {
  String createdAt;
  int id;
  String name;
  List<String> posts;
  String updatedAt;

  Tag({
    required this.createdAt,
    required this.id,
    required this.name,
    required this.posts,
    required this.updatedAt,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      createdAt: json['created_at'],
      id: json['id'],
      name: json['name'],
      posts: List<String>.from(json['posts']),
      updatedAt: json['updated_at'],
    );
  }
}