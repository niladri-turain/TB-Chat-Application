import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/routes/app_router.dart';
import '../../../constant/app_pngs.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
     _navigate();
  }

  Future<void> _navigate() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacementNamed(context, AppRoutes.onboarding);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImagesPng.tbBackground,
            fit: BoxFit.cover,
          ),
          SafeArea(
            child: Column(
              children: [
                const Spacer(flex: 3),
                Center(
                  child: Container(
                    width: 200,
                    height: 170,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(44),
                    ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _LogoBlock('T', AppColors.pink),
                          const SizedBox(width: 6),
                          _LogoBlock('B', AppColors.indigo),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Container(
                        height: 45,
                        width: 150,
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.ink,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            'CHAT',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                              color: AppColors.white,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'TB Chat',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w700,
                  fontSize: 28,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Your workplace, one conversation away.',
                style: AppTextStyles.body.copyWith(color: AppColors.white),
              ),
              const Spacer(flex: 3),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     _Dot(active: true),
              //     const SizedBox(width: 6),
              //     _Dot(active: false),
              //     const SizedBox(width: 6),
              //     _Dot(active: false),
              //   ],
              // ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock_outline, color: AppColors.white, size: 14),
                  const SizedBox(width: 6),
                  Text(
                    'Secure team workspace · v1.0',
                    style: AppTextStyles.meta.copyWith(color: AppColors.white),
                  ),
                ],
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
        ],
      ),
    );
  }
}

class _LogoBlock extends StatelessWidget {
  final String letter;
  final Color color;

  const _LogoBlock(this.letter, this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          letter,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w800,
            fontSize: 40,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

// class _Dot extends StatelessWidget {
//   final bool active;
//   const _Dot({required this.active});
//
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: const Duration(milliseconds: 300),
//       width: active ? 20 : 8,
//       height: 8,
//       decoration: BoxDecoration(
//         color: active ? AppColors.white : AppColors.white.withValues(alpha: 0.4),
//         borderRadius: BorderRadius.circular(4),
//       ),
//     );
//   }
// }
