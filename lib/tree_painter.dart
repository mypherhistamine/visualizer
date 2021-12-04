import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:visualizer/binary_tree.dart';
import 'package:visualizer/coordinate_Builder.dart';
import 'package:visualizer/tree_builder.dart';

class SearchIcon extends StatelessWidget {
  final factor;
  SearchIcon({this.factor});
  @override
  Widget build(BuildContext context) {
    final media = MediaQuery.of(context).size;
    return customSearchIcon(
      size: media.width,
      outerCircleColor: Colors.red,
      arcColor: Colors.amber,
      factor:factor
    );
  }
}

Widget customSearchIcon(
    {@required double? size,
    factor,
    outerCircleColor = const Color(0xff616161),
    innerCircleColor = const Color(0xff64b5f6),
    handlebarColor = const Color(0xff616161),
    outerHandleBarColor = const Color(0xff616161),
    arcColor = const Color(0xffbbdefb)}) {
  return Container(
    decoration: BoxDecoration(border: Border.all(color: Colors.red)),
    height: size,
    width: size,
    child: CustomPaint(
      foregroundPainter: MyPainter(
          factor:factor,
          outerCircleColor: outerCircleColor,
          innerCircleColor: innerCircleColor,
          arcColor: arcColor,
          handleBarColor: handlebarColor,
          outerHandleBarColor: outerHandleBarColor),
    ),
  );
}

// Color(0xff616161);

class MyPainter extends CustomPainter {
  var outerCircleColor;
  var innerCircleColor;
  var handleBarColor;
  var outerHandleBarColor;
  var arcColor;
  double factor;

  MyPainter({
    this.arcColor,
    this.outerCircleColor,
    this.innerCircleColor,
    this.handleBarColor,
    this.outerHandleBarColor,
    required this.factor
  });
  @override
  void paint(Canvas canvas, Size size) {
    Paint outerCirclePaint = Paint()
      ..color = outerCircleColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 10;

    Paint innerCirclePaint = Paint()
      ..color = innerCircleColor
      ..style = PaintingStyle.fill;

    Paint arcCirclePaint = Paint()
      ..color = arcColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12 * (size.width / 250)
      ..strokeCap = StrokeCap.round;

    Paint handleBarPaint = Paint()
      ..color = handleBarColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 5
      ..strokeCap = StrokeCap.square;

    Paint outerHandleBarPaint = Paint()
      ..color = outerHandleBarColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20 * (size.width / 250)
      ..strokeCap = StrokeCap.square;

    // canvas.drawLine(
    //   Offset(
    //     100 * (size.width / 250),
    //     100 * (size.height / 250),
    //   ),
    //   Offset(
    //     200 * (size.width / 250),
    //     300 * (size.height / 250),
    //   ),
    //   handleBarPaint,
    // );
    final double c = size.width / 5;
  
    // List<List<double>> arr = [
    //   [0, 0],
    //   [-4, 1],
    //   [-3, 2],
    //   [-2, 3],
    //   [-1, 4],
    //   [4, 1],
    //   [3, 2],
    //   [2, 3],
    //   [1, 4]
    // ];

    // for (int i = 0; i < 9; i++) {
    //   canvas.drawCircle(
    //     Offset(
    //       arr[i][0] * factor + c,
    //       arr[i][1] * factor,
    //     ),
    //     5,
    //     outerCirclePaint,
    //   );
    // }
    // 4,-7,#,#,-3,-9,9,6,0,#,-1,#,#,6,-4,#,#,#,#,-7,-6,5,#,#,#,-6,9,-2,#,#,#,#,-3,-4,#,#,#
    // 1,2,4,8,#,#,9,#,#,5,10,#,#,11,#,#,3,6,#,13,#,#,7,14,#,#,#
    TreeNode? root = deserialize("1,2,#,#,3,4,6,10,18,32,#,#,33,#,#,19,#,34,#,#,11,20,35,#,#,#,21,36,#,#,#,7,12,22,#,#,23,#,#,13,25,#,#,26,#,#,5,8,14,27,#,#,28,#,#,15,29,#,#,#,9,16,30,#,#,31,#,#,17,#,#");
    List<int> arr = getHeight(root);
    TreeNode? r = coordinate(arr[2],0 root,true);
    r?.x=0;
    r?.y=0;
  //   TreeNode? right=coordinate(arr[1], 1, root?.right);
  //    TreeNode r = new TreeNode(
  //   root?.val,
  //   x: 0,
  //   y: 0,
  // );
  // r.right=right;
  // r.left=left;
    treeBuilder(canvas, r, factor, c, outerCirclePaint, handleBarPaint);

    // canvas.drawCircle(
    //   Offset(
    //      (size.width/2),
    //     0,
    //   ),
    //   5,
    //   outerCirclePaint,
    // );
    //  canvas.drawCircle(
    //   Offset(
    //      (size.width/2)-50,
    //     40,
    //   ),
    //   5,
    //   outerCirclePaint,
    // );
    // canvas.drawCircle(
    //   Offset(
    //      (size.width/2)+100,
    //     40,
    //   ),
    //   5,
    //   outerCirclePaint,
    // );

    //  canvas.drawCircle(
    //   Offset(
    //      (size.width/2)-100,
    //     80,
    //   ),
    //   5,
    //   outerCirclePaint,
    // );

    // canvas.drawCircle(
    //   Offset(
    //      (size.width/2),
    //     80,
    //   ),
    //   5,
    //   outerCirclePaint,
    // );
  }

  TreeNode? treeBuilder(Canvas canvas, TreeNode? root, double factor, double c,
      Paint outerCirclePaint, Paint handleBarPaint) {
    if (root == null) {
      return null;
    }

   TreeNode? left = treeBuilder(
        canvas, root.left, factor, c, outerCirclePaint, handleBarPaint);
    TreeNode? right = treeBuilder(
        canvas, root.right, factor, c, outerCirclePaint, handleBarPaint);

    if (left != null)
      canvas.drawLine(
        Offset((root.x)! * factor + c, (root.y)! * factor),
        Offset((left.x)! * factor + c, (left.y)! * factor),
        handleBarPaint,
      );
    if (right != null)
      canvas.drawLine(
        Offset((root.x)! * factor + c, (root.y)! * factor),
        Offset((right.x)! * factor + c, (right.y)! * factor),
        handleBarPaint,
      );

    canvas.drawCircle(
      Offset(
        (root.x)! * factor + c,
        (root.y)! * factor,
      ),
      10,
      outerCirclePaint,
    );

    return root;
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
