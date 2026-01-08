import 'package:flutter/material.dart';

class StatusIndicator extends StatefulWidget {
  const StatusIndicator({super.key, required this.broadcasting});

  final bool broadcasting;

  @override
  State<StatusIndicator> createState() => _StatusIndicatorState();
}

class _StatusIndicatorState extends State<StatusIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.6, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: widget.broadcasting
            ? const Color(0xFF00D9FF).withOpacity(0.15)
            : const Color(0xFF152228),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: widget.broadcasting
              ? const Color(0xFF00D9FF).withOpacity(0.5)
              : const Color(0xFF152228),
          width: 1.5,
        ),
        boxShadow: widget.broadcasting
            ? [
                BoxShadow(
                  color: const Color(0xFF00D9FF).withOpacity(0.3),
                  blurRadius: 12,
                  spreadRadius: 0,
                ),
              ]
            : null,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              if (widget.broadcasting)
                AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Container(
                      width: 16 * _pulseAnimation.value,
                      height: 16 * _pulseAnimation.value,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF00D9FF)
                              .withOpacity(0.3 * _pulseAnimation.value),
                          width: 2,
                        ),
                      ),
                    );
                  },
                ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 10,
                height: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: widget.broadcasting
                      ? const Color(0xFF00D9FF)
                      : const Color(0xFF152228).withOpacity(0.5),
                  boxShadow: widget.broadcasting
                      ? [
                          BoxShadow(
                            color: const Color(0xFF00D9FF).withOpacity(0.6),
                            blurRadius: 8,
                            spreadRadius: 1,
                          ),
                        ]
                      : null,
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 300),
            style: TextStyle(
              color: widget.broadcasting
                  ? const Color(0xFF00D9FF)
                  : const Color.fromARGB(255, 208, 209, 209).withOpacity(0.6),
              fontWeight: FontWeight.w600,
              fontSize: 13,
              letterSpacing: 0.5,
            ),
            child: Text(
              widget.broadcasting ? 'LIVE' : 'IDLE',
            ),
          ),
        ],
      ),
    );
  }
}