import 'dart:collection';
import 'package:visualizer/binary_tree.dart';

//left
//right
//overall
int max(int x, int y) {
  return x > y ? x : y;
}
  HashMap<int?, List<int>> map = new HashMap();
List<int> getHeight(TreeNode? root) {
  if (root == null) {
    return [0, 0, 0];
  }
  List<int> left = getHeight(root.left);
  List<int> right = getHeight(root.right);

  List<int> arr = [left[2], right[2], left[2] + right[2] + 1];
  Map<int?,List<int>> map2 = {root.val:arr};
  map.addAll(map2);
  return arr;
}

TreeNode? coordinate(int? x, int? y, TreeNode? root, bool isRoot) {
  if (root == null) return null;
  TreeNode node = new TreeNode(
    root.val,
    x: x,
    y: y,
  );
  node.left = coordinate(isRoot ? -x! -3 : x! - map[root.val]![2], y! + 2, root.left, false);
  node.right = coordinate(isRoot?x+3:x +map[root.val]![2] , y + 2, root.right, false);

  return node;
}
