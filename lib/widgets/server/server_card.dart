import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../util/server_entry.dart';
import '../../constants/app_constants.dart';

class ServerCard extends StatelessWidget {
  const ServerCard({
    super.key,
    required this.server,
    required this.onTap,
    this.isTop = false,
    this.rank,
  });

  final ServerEntry server;
  final VoidCallback onTap;
  final bool isTop;
  final int? rank;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF0A1419),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: isTop
              ? const Color(0xFF00D9FF).withOpacity(0.3)
              : const Color(0xFF152228),
          width: 1.5,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap:  onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: const Color(0xFF00D9FF).withOpacity(0.05),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isTop
                        ? const Color(0xFF152228)
                        : const Color(0xFF0F1419),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isTop
                          ? const Color(0xFF00D9FF).withOpacity(0.2)
                          : const Color(0xFF152228),
                    ),
                  ),
                  child: Icon(
                    Icons.dns_outlined,
                    color: isTop
                        ? const Color(0xFF00D9FF).withOpacity(0.8)
                        : const Color(0xFF00D9FF).withOpacity(0.4),
                    size: 22,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        server.address,
                        style: TextStyle(
                          color: const Color.fromARGB(255, 208, 209, 209)
                              .withOpacity(isTop ? 1.0 : 0.8),
                          fontSize: 14,
                          fontWeight: isTop ? FontWeight.w600 : FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        ': ${server.port}',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 208, 209, 209)
                              .withOpacity(0.5),
                          fontSize: 12,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0F1419),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(
                      color: const Color(0xFF152228),
                    ),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.content_copy_outlined,
                      size: 15,
                      color: const Color(0xFF00D9FF).withOpacity(0.6),
                    ),
                    tooltip: 'Copy',
                    onPressed: () {
                      Clipboard.setData(
                        ClipboardData(text: '${server.address}:${server.port}'),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.check_circle_outline,
                                color: const Color(0xFF00D9FF).withOpacity(0.8),
                                size: 16,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Copied',
                                style: TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                          backgroundColor: const Color(0xFF0A1419),
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                    },
                    padding: const EdgeInsets.all(7),
                    constraints: const BoxConstraints(),
                  ),
                ),
                const SizedBox(width: 10),
                Icon(
                  Icons.chevron_right,
                  size: 18,
                  color: const Color(0xFF00D9FF).withOpacity(0.3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}