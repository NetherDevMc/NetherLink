import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({super.key, required this.broadcasting});

  final bool broadcasting;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: broadcasting
            ? const Color(0xFF065F46).withOpacity(0.6)
            : const Color(0xFF1F2937),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: broadcasting
              ? const Color(0xFF10B981)
              : const Color(0xFF4B5563),
          width: 1.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: broadcasting
                  ? const Color(0xFF10B981)
                  : const Color(0xFF6B7280),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            broadcasting ? 'Broadcasting' : 'Idle',
            style: TextStyle(
              color: broadcasting ? Colors.white : const Color(0xFFD1D5DB),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
