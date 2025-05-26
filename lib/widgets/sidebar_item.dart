import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SidebarItem extends StatefulWidget {
  final IconData icon;
  final String label;
  final FocusNode focusNode;
  final VoidCallback onSelect;
  final bool isSelected;
  final bool isExpanded;

  // Define colors
  static const Color selectedColor = Color(0xFF6200EE);
  static const Color focusedColor = selectedColor;
  static const Color defaultColor = Colors.grey;

  const SidebarItem({
    super.key,
    required this.icon,
    required this.label,
    required this.focusNode,
    required this.onSelect,
    required this.isSelected,
    required this.isExpanded,
  });

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(SidebarItem oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      if (widget.isSelected) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Focus(
      focusNode: widget.focusNode,
      onKeyEvent: (node, event) {
        if (event is KeyDownEvent) {
          if (event.logicalKey == LogicalKeyboardKey.select ||
              event.logicalKey == LogicalKeyboardKey.enter ||
              event.logicalKey == LogicalKeyboardKey.space) {
            widget.onSelect();
            return KeyEventResult.handled;
          }
        }
        return KeyEventResult.ignored;
      },
      child: MouseRegion(
        onEnter: (_) => setState(() => _isHovered = true),
        onExit: (_) => setState(() => _isHovered = false),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final focused = Focus.of(context).hasFocus;
            return InkWell(
              onTap: widget.onSelect,
              child: TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 200),
                tween: Tween<double>(
                  begin: 0,
                  end: widget.isExpanded ? 1 : 0,
                ),
                builder: (context, value, child) {
                  return Container(
                    margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 8 + (8 * value), // Animate padding
                    ),
                    child: Row(
                      mainAxisAlignment: widget.isExpanded 
                          ? MainAxisAlignment.start 
                          : MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 28,  // Fixed width for icon container
                          child: Transform.scale(
                            scale: widget.isSelected || _isHovered ? _scaleAnimation.value : 1.0,
                            child: Icon(
                              widget.icon,
                              color: widget.isSelected 
                                  ? SidebarItem.selectedColor
                                  : (_isHovered || focused ? SidebarItem.focusedColor : SidebarItem.defaultColor),
                              size: (focused || widget.isSelected || _isHovered) ? 28 : 24,
                            ),
                          ),
                        ),
                        if (widget.isExpanded) ...[
                          const SizedBox(width: 12),
                          Expanded(
                            child: AnimatedDefaultTextStyle(
                              duration: const Duration(milliseconds: 200),
                              style: TextStyle(
                                color: widget.isSelected 
                                    ? SidebarItem.selectedColor
                                    : (_isHovered || focused ? SidebarItem.focusedColor : SidebarItem.defaultColor),
                                fontWeight: widget.isSelected ? FontWeight.bold : FontWeight.normal,
                                fontSize: (focused || widget.isSelected || _isHovered) ? 16 : 14,
                              ),
                              child: Text(
                                widget.label,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
} 