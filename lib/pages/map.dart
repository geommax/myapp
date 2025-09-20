import 'package:flutter/material.dart';
import 'dart:math' as math;

/// A simple map page with a pan-able grid and one draggable point.
class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  // Grid pan offset (in screen pixels)
  Offset _gridOffset = Offset.zero;

  // Marker position in grid coordinates (logical coordinates)
  // (0,0) is the origin at the top-left of the logical grid.
  Offset _markerInGrid = const Offset(200, 150);

  // Internal gesture state
  bool _draggingMarker = false;
  Offset? _lastPanPosition;

  // Grid visual parameters
  final double _gridStep = 50.0; // pixels between major grid lines
  final Color _gridColor = const Color(0xFFBDBDBD);

  // Hit radius in screen pixels to start dragging the marker
  final double _markerHitRadius = 18.0;

  // Marker visual
  final double _markerSize = 22.0;

  // Helper: convert local (screen) coordinate -> grid coordinate
  Offset _screenToGrid(Offset screenLocal) => screenLocal - _gridOffset;

  // Helper: convert grid coordinate -> screen coordinate
  Offset _gridToScreen(Offset gridPos) => gridPos + _gridOffset;

  void _onPanStart(DragStartDetails details) {
    final local = details.localPosition;
    final markerScreen = _gridToScreen(_markerInGrid);
    final distance = (local - markerScreen).distance;

    if (distance <= _markerHitRadius) {
      // Start dragging the marker
      _draggingMarker = true;
    } else {
      // Start panning the grid
      _draggingMarker = false;
    }
    _lastPanPosition = local;
  }

  void _onPanUpdate(DragUpdateDetails details) {
    final local = details.localPosition;
    final delta = details.delta;

    if (_draggingMarker) {
      // Move marker in grid space by the screen delta
      setState(() {
        _markerInGrid = _markerInGrid + delta;
      });
    } else {
      // Pan grid offset (moves the visible grid and marker)
      setState(() {
        _gridOffset = _gridOffset + delta;
      });
    }

    _lastPanPosition = local;
  }

  void _onPanEnd(DragEndDetails details) {
    _draggingMarker = false;
    _lastPanPosition = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Use a unified gesture on the whole map area
      onPanStart: _onPanStart,
      onPanUpdate: _onPanUpdate,
      onPanEnd: _onPanEnd,
      child: Container(
        color: Theme.of(context).brightness == Brightness.dark
            ? Colors.black87
            : Colors.grey[200],
        child: CustomPaint(
          painter: _GridPainter(
            offset: _gridOffset,
            step: _gridStep,
            color: _gridColor,
            markerScreenPos: _gridToScreen(_markerInGrid),
            markerSize: _markerSize,
          ),
          // Let the CustomPaint take all available space
          child: LayoutBuilder(
            builder: (context, constraints) {
              // We draw marker via the painter, but we may overlay helpful UI if needed
              return SizedBox(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                child: Stack(
                  children: [
                    // Optional: show coordinates at top-left for debugging
                    Positioned(
                      left: 8,
                      top: 8,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 6),
                        decoration: BoxDecoration(
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.black54
                              : Colors.white70,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Marker: ${_markerInGrid.dx.toStringAsFixed(0)}, ${_markerInGrid.dy.toStringAsFixed(0)}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

/// Custom painter that draws a simple grid and the marker.
class _GridPainter extends CustomPainter {
  final Offset offset; // pan offset in screen pixels
  final double step;
  final Color color;
  final Offset markerScreenPos;
  final double markerSize;

  _GridPainter({
    required this.offset,
    required this.step,
    required this.color,
    required this.markerScreenPos,
    required this.markerSize,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint linePaint = Paint()
      ..color = color
      ..strokeWidth = 1.0;

    // Background subtle gradient
    final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height), const Radius.circular(0));
    canvas.drawRRect(
        r,
        Paint()
          ..shader = LinearGradient(
            colors: [Colors.transparent, Colors.transparent],
          ).createShader(r.outerRect));

    // Draw vertical lines
    // We want lines to appear continuously as the grid moves, so compute start based on offset.
    // offset.dx is how much the grid is shifted to the right.
    final double startX = -offset.dx % step;
    for (double x = startX; x <= size.width; x += step) {
      // thicker line every 5 steps
      final bool major = ((x + offset.dx) / step).round() % 5 == 0;
      canvas.drawLine(Offset(x, 0), Offset(x, size.height),
          linePaint..strokeWidth = major ? 1.4 : 0.8);
    }

    // Draw horizontal lines
    final double startY = -offset.dy % step;
    for (double y = startY; y <= size.height; y += step) {
      final bool major = ((y + offset.dy) / step).round() % 5 == 0;
      canvas.drawLine(Offset(0, y), Offset(size.width, y),
          linePaint..strokeWidth = major ? 1.4 : 0.8);
    }

    // Draw axes at grid logical origin (optional)
    final originScreen = offset;
    final Paint axisPaint = Paint()
      ..color = color.withOpacity(0.6)
      ..strokeWidth = 1.2;
    // x-axis
    canvas.drawLine(Offset(0, originScreen.dy),
        Offset(size.width, originScreen.dy), axisPaint);
    // y-axis
    canvas.drawLine(Offset(originScreen.dx, 0),
        Offset(originScreen.dx, size.height), axisPaint);

    // Draw marker (circle with border)
    final Paint markerPaint = Paint()..color = Colors.redAccent;
    final Paint markerBorder = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    canvas.drawCircle(markerScreenPos, markerSize * 0.6, markerPaint);
    canvas.drawCircle(markerScreenPos, markerSize * 0.6, markerBorder);

    // Draw marker label number
    final textPainter = TextPainter(
      text: TextSpan(
        text: '1',
        style: TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
        canvas,
        Offset(markerScreenPos.dx - textPainter.width / 2,
            markerScreenPos.dy - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.offset != offset ||
        oldDelegate.markerScreenPos != markerScreenPos ||
        oldDelegate.step != step;
  }
}
