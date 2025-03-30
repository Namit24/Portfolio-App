import 'package:flutter/material.dart';

class AnimatedText extends StatefulWidget {
  final List<String> texts;
  final TextStyle textStyle;
  final Duration animationDuration;
  final Duration pauseDuration;

  const AnimatedText({
    Key? key,
    required this.texts,
    required this.textStyle,
    this.animationDuration = const Duration(milliseconds: 300),
    this.pauseDuration = const Duration(seconds: 3),
  }) : super(key: key);

  @override
  State<AnimatedText> createState() => _AnimatedTextState();
}

class _AnimatedTextState extends State<AnimatedText> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacity;
  late Animation<double> _scale;
  int _currentIndex = 0;
  String _currentText = '';
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _currentText = widget.texts.first;
    
    _controller = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    
    _opacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
    
    _scale = Tween<double>(begin: 0.95, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );
    
    _controller.forward();
    
    _startAnimation();
  }

  void _startAnimation() async {
    while (!_disposed) {
      await Future.delayed(widget.pauseDuration);
      if (_disposed) return;
      
      await _controller.reverse();
      if (_disposed) return;
      
      setState(() {
        _currentIndex = (_currentIndex + 1) % widget.texts.length;
        _currentText = widget.texts[_currentIndex];
      });
      
      await _controller.forward();
    }
  }

  @override
  void dispose() {
    _disposed = true;
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: ScaleTransition(
        scale: _scale,
        child: Text(
          _currentText,
          style: widget.textStyle,
        ),
      ),
    );
  }
}

