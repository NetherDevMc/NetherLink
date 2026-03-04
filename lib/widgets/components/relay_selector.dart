import 'package:flutter/material.dart';
import '../../constants/app_constants.dart';
import '../../theme/app_theme.dart';

class RelaySelector extends StatefulWidget {
  final String? selectedIp;
  final void Function(String?) onChanged;

  const RelaySelector({
    super.key,
    required this.selectedIp,
    required this.onChanged,
  });

  @override
  State<RelaySelector> createState() => _RelaySelectorState();
}

class _RelaySelectorState extends State<RelaySelector> {
  late String? _relayIp;

  @override
  void initState() {
    super.initState();
    _relayIp = widget.selectedIp ?? AppConstants.relayServers[0]['ip'];
  }

  @override
  void didUpdateWidget(covariant RelaySelector oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedIp != _relayIp && widget.selectedIp != null) {
      setState(() => _relayIp = widget.selectedIp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'NETHERLINK SERVER',
          style: TextStyle(
            color: AppTheme.textMuted,
            fontWeight: FontWeight.w600,
            fontSize: 11,
            letterSpacing: 1.2,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: AppTheme.surfaceLight,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: AppTheme.borderGray),
          ),
          child: Row(
            children: AppConstants.relayServers.map((srv) {
              final isSelected = srv['ip'] == _relayIp;
              final isFirst = AppConstants.relayServers.indexOf(srv) == 0;
              final isLast =
                  AppConstants.relayServers.indexOf(srv) ==
                  AppConstants.relayServers.length - 1;

              return Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() => _relayIp = srv['ip']);
                    widget.onChanged(srv['ip']);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeInOut,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppTheme.primaryAccent
                          : Colors.transparent,
                      borderRadius: BorderRadius.horizontal(
                        left: isFirst ? const Radius.circular(9) : Radius.zero,
                        right: isLast ? const Radius.circular(9) : Radius.zero,
                      ),
                    ),
                    child: Text(
                      srv['name']!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppTheme.textMuted,
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
