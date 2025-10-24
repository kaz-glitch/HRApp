import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color _darkBlue = Color(0xFF2E4A56);
const Color _beige = Color(0xFFE8DFC1);
const Color _mint = Color(0xFFA7C7A1);

/// Shows an animated success overlay modal that floats above the current screen.
/// Dismissible by outside tap, the X button, or auto-close after 2.2 seconds.
Future<void> showSuccessOverlay(
  BuildContext context, {
  String message = 'تم ارسال الطلب',
  Duration? autoCloseDuration = const Duration(milliseconds: 2200),
}) async {
  final navigator = Navigator.of(context);

  if (autoCloseDuration != null) {
    Future.delayed(autoCloseDuration, () {
      if (navigator.mounted && navigator.canPop()) {
        navigator.pop();
      }
    });
  }

  return showGeneralDialog<void>(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'success-overlay',
    barrierColor: Colors.black.withOpacity(0.45),
    transitionDuration: const Duration(milliseconds: 260),
    pageBuilder: (context, anim1, anim2) => const SizedBox.shrink(),
    transitionBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(parent: animation, curve: Curves.easeOutCubic);
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.95, end: 1.0).animate(curved),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 420),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SuccessDialog(message: message),
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}

class SuccessDialog extends StatelessWidget {
  const SuccessDialog({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(20, 28, 20, 26),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: const [
                BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                BoxShadow(color: _beige, blurRadius: 16, spreadRadius: -12),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    color: _mint,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 36),
                ),
                const SizedBox(height: 16),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.cairo(
                    color: Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.25,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: -14,
            left: -14,
            child: _CloseCircleButton(
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
        ],
      ),
    );
  }
}

class _CloseCircleButton extends StatelessWidget {
  const _CloseCircleButton({required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: _darkBlue, width: 1.5),
          ),
          child: const Icon(Icons.close, color: _darkBlue, size: 20),
        ),
      ),
    );
  }
}
