class LearningNode {
  final int id;
  final String title;
  final int? parentId;

  LearningNode({
    required this.id,
    required this.title,
    this.parentId,
  });

  factory LearningNode.fromJson(Map<String, dynamic> json) {
    return LearningNode(
      id: json['id'],
      title: json['title'],
      parentId: json['parentId'],
    );
  }
}
