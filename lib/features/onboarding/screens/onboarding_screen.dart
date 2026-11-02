import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/routes/app_router.dart';
import '../../../widgets/gradient_button.dart';

// ─── Data ────────────────────────────────────────────────────────────────────

class _PageData {
  final Widget illustration;
  final List<String> titleParts; // [dark, pink, dark]
  final String subtitle;

  const _PageData({
    required this.illustration,
    required this.titleParts,
    required this.subtitle,
  });
}

const _pages = [
  _PageData(
    illustration: _ChatIllustration(),
    titleParts: ['Connect.', 'Collaborate.', 'Communicate.'],
    subtitle:
        'Chat one-to-one or in groups, and share files, photos and voice notes with your whole team.',
  ),
  _PageData(
    illustration: _ShareIllustration(),
    titleParts: ['Share.', 'Securely.', 'Instantly.'],
    subtitle:
        'Send files, photos, and documents of any size. End-to-end encryption keeps every conversation private.',
  ),
  _PageData(
    illustration: _TeamIllustration(),
    titleParts: ['Organize.', 'Together.', 'Effortlessly.'],
    subtitle:
        'Create channels, build your team, and stay in sync — whether you\'re in the office or across the globe.',
  ),
];

// ─── Screen ──────────────────────────────────────────────────────────────────

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _skip() {
    _controller.animateToPage(
      _pages.length - 1,
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeInOut,
    );
  }

  bool get _isLast => _page == _pages.length - 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildHeader(),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: _pages.length,
                onPageChanged: (i) => setState(() => _page = i),
                itemBuilder: (_, i) => _OnboardingPage(data: _pages[i]),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
              child: _DotIndicator(current: _page, total: _pages.length),
            ),
            const SizedBox(height: 20),
            AnimatedCrossFade(
              firstChild: const SizedBox(height: 104),
              secondChild: _buildButtons(),
              crossFadeState:
                  _isLast ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const _TbLogo(),
          AnimatedOpacity(
            opacity: _isLast ? 0.0 : 1.0,
            duration: const Duration(milliseconds: 200),
            child: GestureDetector(
              onTap: _isLast ? null : _skip,
              child: Text(
                'Skip',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.indigo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          GradientButton(
            label: 'Get Started  →',
            onPressed: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.register),
          ),
          const SizedBox(height: 16),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, AppRoutes.signIn),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Text(
                'I already have an account',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: AppColors.indigo,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Page ────────────────────────────────────────────────────────────────────

class _OnboardingPage extends StatelessWidget {
  final _PageData data;

  const _OnboardingPage({required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const ClampingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          data.illustration,
          const SizedBox(height: 28),
          RichText(
            text: TextSpan(
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w700,
                fontSize: 32,
                height: 1.25,
                color: AppColors.ink,
              ),
              children: [
                TextSpan(text: '${data.titleParts[0]}\n'),
                TextSpan(
                  text: '${data.titleParts[1]}\n',
                  style: const TextStyle(color: AppColors.pink),
                ),
                TextSpan(text: data.titleParts[2]),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Text(
            data.subtitle,
            style: GoogleFonts.inter(
              fontWeight: FontWeight.w400,
              fontSize: 15,
              color: AppColors.muted,
              height: 1.55,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Dot Indicator ───────────────────────────────────────────────────────────

class _DotIndicator extends StatelessWidget {
  final int current;
  final int total;

  const _DotIndicator({required this.current, required this.total});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(total, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          width: active ? 28 : 8,
          height: 8,
          margin: const EdgeInsets.only(right: 6),
          decoration: BoxDecoration(
            color: active ? AppColors.indigo : AppColors.line,
            borderRadius: BorderRadius.circular(4),
          ),
        );
      }),
    );
  }
}

// ─── TB Logo ─────────────────────────────────────────────────────────────────

class _TbLogo extends StatelessWidget {
  const _TbLogo();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _LogoBox(letter: 'T', decoration: const BoxDecoration(
          gradient: AppColors.brandGradient,
          borderRadius: BorderRadius.all(Radius.circular(9)),
        )),
        const SizedBox(width: 5),
        _LogoBox(letter: 'B', decoration: const BoxDecoration(
          color: AppColors.indigo,
          borderRadius: BorderRadius.all(Radius.circular(9)),
        )),
      ],
    );
  }
}

class _LogoBox extends StatelessWidget {
  final String letter;
  final BoxDecoration decoration;

  const _LogoBox({required this.letter, required this.decoration});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 38,
      height: 38,
      decoration: decoration,
      child: Center(
        child: Text(
          letter,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w700,
            fontSize: 19,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Shared helper widgets ───────────────────────────────────────────────────

class _InitialsAvatar extends StatelessWidget {
  final String initials;
  final Color color;
  final double size;

  const _InitialsAvatar({
    required this.initials,
    required this.color,
    this.size = 40,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: Text(
          initials,
          style: GoogleFonts.inter(
            fontWeight: FontWeight.w700,
            fontSize: size * 0.3,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}

// ─── Slide 1 — Chat Illustration ─────────────────────────────────────────────

class _ChatIllustration extends StatelessWidget {
  const _ChatIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBF8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Incoming message
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const _InitialsAvatar(
                initials: 'AK',
                color: Color(0xFFB0A8E0),
                size: 38,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 11,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(4),
                      topRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Amit Kumar',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                          color: AppColors.ink,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Standup in 10 min?',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                          color: AppColors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Outgoing gradient message
          Align(
            alignment: Alignment.centerRight,
            child: Container(
              constraints: const BoxConstraints(maxWidth: 230),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              decoration: const BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(4),
                  bottomLeft: Radius.circular(16),
                  bottomRight: Radius.circular(16),
                ),
              ),
              child: Text(
                'On my way! Sharing the deck now.',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // PDF file card
          Container(
            padding: const EdgeInsets.all(13),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: const Color(0xFFE5002B),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      'PDF',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Sprint-Plan-Q4.pdf',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: 13,
                        color: AppColors.ink,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '2.4 MB · 8 pages',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.muted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // Overlapping avatar chips
          Align(
            alignment: Alignment.centerRight,
            child: _AvatarStack(),
          ),
        ],
      ),
    );
  }
}

class _AvatarStack extends StatelessWidget {
  const _AvatarStack();

  static const _items = [
    ('PS', Color(0xFFFFAAC2)),
    ('RS', Color(0xFF7DD9A0)),
    ('NP', Color(0xFFFFCB7A)),
  ];
  static const _size = 32.0;
  static const _overlap = 20.0;
  // 3 coloured avatars + 1 "+9" chip
  static const _count = 4;

  @override
  Widget build(BuildContext context) {
    const width = _size + (_count - 1) * _overlap;
    return SizedBox(
      width: width,
      height: _size,
      child: Stack(
        children: [
          ..._items.asMap().entries.map((e) {
            return Positioned(
              left: e.key * _overlap,
              child: Container(
                width: _size,
                height: _size,
                decoration: BoxDecoration(
                  color: e.value.$2,
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFFEEEBF8), width: 2),
                ),
                child: Center(
                  child: Text(
                    e.value.$1,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: 10,
                      color: AppColors.ink,
                    ),
                  ),
                ),
              ),
            );
          }),
          Positioned(
            left: _items.length * _overlap,
            child: Container(
              width: _size,
              height: _size,
              decoration: BoxDecoration(
                color: AppColors.indigo,
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFEEEBF8), width: 2),
              ),
              child: Center(
                child: Text(
                  '+9',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 10,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Slide 2 — Share Illustration ────────────────────────────────────────────

class _ShareIllustration extends StatelessWidget {
  const _ShareIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBF8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _FileRow(
            iconWidget: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: const Color(0xFFE5002B),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  'PDF',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 11,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
            name: 'Q4-Report.pdf',
            meta: '3.1 MB · shared',
          ),
          const SizedBox(height: 10),
          _FileRow(
            iconWidget: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                gradient: AppColors.brandGradient,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.image_rounded, color: AppColors.white, size: 22),
            ),
            name: 'Team-Photo.jpg',
            meta: '1.8 MB · shared',
          ),
          const SizedBox(height: 10),
          _FileRow(
            iconWidget: Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.indigo,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.play_circle_fill_rounded, color: AppColors.white, size: 24),
            ),
            name: 'Demo-Recording.mp4',
            meta: '24 MB · shared',
          ),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 8,
                  ),
                ],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_rounded, size: 14, color: AppColors.indigo),
                  const SizedBox(width: 6),
                  Text(
                    'End-to-end encrypted',
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                      color: AppColors.indigo,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FileRow extends StatelessWidget {
  final Widget iconWidget;
  final String name;
  final String meta;

  const _FileRow({
    required this.iconWidget,
    required this.name,
    required this.meta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          iconWidget,
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  meta,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.check_circle_rounded, color: AppColors.online, size: 20),
        ],
      ),
    );
  }
}

// ─── Slide 3 — Team Illustration ─────────────────────────────────────────────

class _TeamIllustration extends StatelessWidget {
  const _TeamIllustration();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEBF8),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _ChannelRow(
            name: '# general',
            preview: 'Great work on the launch! 🎉',
            badge: '5',
            badgeGradient: false,
          ),
          const SizedBox(height: 10),
          _ChannelRow(
            name: '# design',
            preview: 'Figma file has been updated',
            badge: '2',
            badgeGradient: true,
          ),
          const SizedBox(height: 10),
          _ChannelRow(
            name: '# engineering',
            preview: 'Deployment to prod complete ✓',
            badge: null,
            badgeGradient: false,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  color: AppColors.online,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '12 members online',
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                  color: AppColors.muted,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ChannelRow extends StatelessWidget {
  final String name;
  final String preview;
  final String? badge;
  final bool badgeGradient;

  const _ChannelRow({
    required this.name,
    required this.preview,
    required this.badge,
    required this.badgeGradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: badgeGradient ? AppColors.indigo : AppColors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  preview,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: AppColors.muted,
                  ),
                ),
              ],
            ),
          ),
          if (badge != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                gradient: badgeGradient ? AppColors.brandGradient : null,
                color: badgeGradient ? null : AppColors.line,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                badge!,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: badgeGradient ? AppColors.white : AppColors.muted,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
