import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class LabeledDivider extends LeafRenderObjectWidget {
  const LabeledDivider({
    super.key,
    required this.label,
    this.thickness = 1.0,
    this.color = Colors.black,
  });

  final String label;
  final double thickness;
  final Color color;

  @override
  RenderLabelDivider createRenderObject(
    BuildContext context,
  ) {
    return RenderLabelDivider(
      label: label,
      thickness: thickness,
      color: color,
    );
  }

  @override
  void updateRenderObject(
    BuildContext context,
    RenderLabelDivider renderObject,
  ) {
    renderObject
      ..label = label
      ..thickness = thickness
      ..color = color;
  }
}

class RenderLabelDivider extends RenderBox {
  String _label;
  double _thickness;
  Color _color;
  late TextPainter _textPainter;

  RenderLabelDivider({
    required String label,
    required double thickness,
    required Color color,
  })  : _label = label,
        _thickness = thickness,
        _color = color {
    _textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
  }

  set label(String value) {
    if (_label != value) {
      _label = value;
      markNeedsLayout();
      //Update semantics when label changes
      markNeedsSemanticsUpdate();
    }
  }

  String get label => _label;

  set thickness(double value) {
    if (_thickness != value) {
      _thickness = value;
      // Only layout needs to be updated for thickness changes
      markNeedsLayout();
    }
  }

  double get thickness => _thickness;

  set color(Color value) {
    if (_color != value) {
      _color = value;
      // Only painting needs to be updated for color changes
      markNeedsPaint();
    }
  }

  Color get color => _color;

  @override
  void performLayout() {
    _textPainter.text = TextSpan(
      text: _label,
      style: TextStyle(
        color: _color,
      ),
    );
    _textPainter.layout();

    final double textHeight = _textPainter.size.height;
    size = constraints.constrain(
      Size(
        double.infinity,
        _thickness + textHeight,
      ),
    );
  }

  @override
  void paint(PaintingContext context, Offset offset) {
    final Paint paint = Paint()
      ..color = _color
      // This change increases the thickness of the line according to the _thickness parameter.
      ..strokeWidth = _thickness;
    final double yCenter = offset.dy + size.height / 2;

    // Draw the line
    context.canvas.drawLine(
      offset,
      // Offset(offset.dx + size.width, yCenter),
      // This change maintains a straight line
      Offset(offset.dx + size.width, offset.dy),
      paint,
    );

    // Draw the text
    final double textStart =
        offset.dx + (size.width - _textPainter.size.width) / 2;
    _textPainter.paint(
      context.canvas,
      Offset(textStart, yCenter - _textPainter.size.height / 2),
    );
  }

  @override
  void describeSemanticsConfiguration(SemanticsConfiguration config) {
    super.describeSemanticsConfiguration(config);
    config
      ..isSemanticBoundary = true
      ..label = 'Divider with text: $_label';
  }
}
