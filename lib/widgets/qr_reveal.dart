import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../theme/app_theme.dart';
import 'qr_code_tile.dart';

/// Compact QR trigger that reveals the app's scannable QR code.
///
/// Pointer devices show the popup on hover; touch devices toggle it with a
/// tap; keyboard focus shows it as well. The popup renders in the root
/// overlay above the trigger (or below when there is no room above),
/// clamped to the viewport, and closes when the pointer leaves, the trigger
/// loses focus, the page scrolls, or the visitor taps outside it.
class QrRevealButton extends StatefulWidget {
  const QrRevealButton({super.key, required this.url, required this.appName});

  /// Exact Google Play URL the QR code must encode.
  final String url;

  final String appName;

  @override
  State<QrRevealButton> createState() => _QrRevealButtonState();
}

class _QrRevealButtonState extends State<QrRevealButton> {
  static const double _popupWidth = 168;
  static const double _popupHeightReserve = 250;
  static const double _edgeInset = 8;
  static const double _gap = 12;

  final OverlayPortalController _overlay = OverlayPortalController();
  final FocusNode _focusNode = FocusNode(debugLabel: 'QR reveal');
  final GlobalKey _triggerKey = GlobalKey();

  ScrollPosition? _scrollPosition;

  bool _hovering = false;
  bool _pinned = false;
  bool _focused = false;

  bool get _visible => _hovering || _pinned || _focused;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final position = Scrollable.maybeOf(context)?.position;
    if (position == _scrollPosition) return;
    _scrollPosition?.removeListener(_handleScroll);
    _scrollPosition = position;
    _scrollPosition?.addListener(_handleScroll);
  }

  @override
  void dispose() {
    _scrollPosition?.removeListener(_handleScroll);
    _focusNode
      ..removeListener(_handleFocusChange)
      ..dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    final focused = _focusNode.hasFocus;
    if (focused == _focused) return;
    _focused = focused;
    _syncVisibility();
  }

  void _handleScroll() {
    if (!_visible) return;
    _hovering = false;
    _pinned = false;
    _focusNode.unfocus();
    _syncVisibility();
  }

  void _setHovering(bool value) {
    if (_hovering == value) return;
    _hovering = value;
    _syncVisibility();
  }

  void _togglePinned() {
    _pinned = !_pinned;
    _syncVisibility();
  }

  void _dismiss() {
    if (!_visible) return;
    _hovering = false;
    _pinned = false;
    _focusNode.unfocus();
    _syncVisibility();
  }

  void _syncVisibility() {
    if (!mounted) return;
    setState(() {
      if (_visible) {
        _overlay.show();
      } else {
        _overlay.hide();
      }
    });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent &&
        event.logicalKey == LogicalKeyboardKey.escape) {
      _dismiss();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    return OverlayPortal(
      controller: _overlay,
      overlayChildBuilder: _buildPopup,
      child: MouseRegion(
        onEnter: (_) => _setHovering(true),
        onExit: (_) => _setHovering(false),
        child: Focus(
          canRequestFocus: false,
          skipTraversal: true,
          onKeyEvent: _handleKeyEvent,
          child: IconButton.outlined(
            key: _triggerKey,
            focusNode: _focusNode,
            onPressed: _togglePinned,
            icon: Icon(
              Icons.qr_code_2,
              semanticLabel:
                  'Show QR code to open ${widget.appName} on Google Play',
            ),
            style: IconButton.styleFrom(
              minimumSize: const Size(48, 48),
              side: const BorderSide(color: AppColors.border),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              foregroundColor: AppColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPopup(BuildContext context) {
    final trigger =
        _triggerKey.currentContext?.findRenderObject() as RenderBox?;
    if (trigger == null || !trigger.hasSize) {
      return const SizedBox.shrink();
    }

    final screen = MediaQuery.sizeOf(context);
    final rect = trigger.localToGlobal(Offset.zero) & trigger.size;

    final left = _clamp(
      rect.left,
      _edgeInset,
      screen.width - _popupWidth - _edgeInset,
    );
    // Prefer opening above the trigger; open below when the space above is
    // too small, keeping the card on-screen either way.
    final fitsAbove = rect.top >= _popupHeightReserve + _gap;
    final belowTop = _clamp(
      rect.bottom + _gap,
      _edgeInset,
      screen.height - _popupHeightReserve - _edgeInset,
    );

    final card = Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.border),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: QrCodeTile(url: widget.url, appName: widget.appName, qrSize: 128),
    );

    final reduceMotion = MediaQuery.disableAnimationsOf(context);

    return SizedBox.expand(
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              excludeFromSemantics: true,
              onTap: _dismiss,
            ),
          ),
          Positioned(
            left: left,
            width: _popupWidth,
            top: fitsAbove ? null : belowTop,
            bottom: fitsAbove ? screen.height - rect.top + _gap : null,
            child: reduceMotion ? card : _PopupTransition(child: card),
          ),
        ],
      ),
    );
  }
}

double _clamp(double value, double min, double max) {
  if (value < min) return min;
  if (value > max) return max;
  return value;
}

/// Short fade/scale entrance for the popup; skipped under reduced motion.
class _PopupTransition extends StatelessWidget {
  const _PopupTransition({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: const Duration(milliseconds: 120),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.96 + 0.04 * value,
            alignment: Alignment.bottomLeft,
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
