import '../../models/learning_node.dart';

List<LearningNode> buildConceptGraph(
    Map<String, List<String>> topics,
    ) {
  int idCounter = 0;
  final List<LearningNode> nodes = [];
  final Map<String, int> nodeIds = {};

  void addNode(String title, {String? parent}) {
    if (!nodeIds.containsKey(title)) {
      nodeIds[title] = idCounter;
      nodes.add(
        LearningNode(
          id: idCounter,
          title: title,
          parentId: parent != null ? nodeIds[parent] : null,
        ),
      );
      idCounter++;
    }
  }

  topics.forEach((parent, children) {
    addNode(parent);

    for (final child in children) {
      addNode(child, parent: parent);
    }
  });

  return nodes;
}
