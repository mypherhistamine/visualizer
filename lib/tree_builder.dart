import 'package:visualizer/binary_tree.dart';
import 'dart:collection';

TreeNode? deserialize(String data) {
  Queue<String> queue = new Queue();
  List<String> arr = data.split(",");

  for (int i = 0; i < arr.length; i++) queue.add(arr[i]);
    // print(queue);
  return helper(queue);
}

TreeNode? helper(Queue<String> queue) {
  String s = queue.removeFirst();
  if (s == "#") return null;
  TreeNode root = new TreeNode(int.parse(s));
  root.left = helper(queue);
  root.right = helper(queue);
  return root;
}
