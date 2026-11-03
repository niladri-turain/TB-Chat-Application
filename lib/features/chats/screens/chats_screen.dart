import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../widgets/gradient_button.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  int _selectedFilter = 0;
  final List<String> _filters = ['All', 'Unread', 'Groups', 'Favorites'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFilterRow(),
          Expanded(child: _buildEmptyState()),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 72,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16),
        child: Center(child: _buildUserAvatar()),
      ),
      title: Text(
        'Chats',
        style: AppTextStyles.header,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: GestureDetector(
            onTap: () {},
            child: Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.line,
                borderRadius: BorderRadius.circular(14),
              ),
              child: const Icon(Icons.search_rounded, color: AppColors.ink, size: 22),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildUserAvatar() {
    return Container(
      width: 44,
      height: 44,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: AppColors.brandGradient,
      ),
      child: Center(
        child: Text(
          'NR',
          style: AppTextStyles.nameLabel.copyWith(
            color: AppColors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  Widget _buildFilterRow() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(_filters.length, (i) {
            final selected = _selectedFilter == i;
            return Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () => setState(() => _selectedFilter = i),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: selected ? AppColors.ink : AppColors.line,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Text(
                    _filters[i],
                    style: AppTextStyles.meta.copyWith(
                      color: selected ? AppColors.white : AppColors.muted,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Spacer(),
          _buildChatIllustration(),
          const SizedBox(height: 32),
          Text(
            'No conversations yet',
            style: AppTextStyles.header.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Start a chat with a teammate or create a\ngroup to get your team talking.',
            textAlign: TextAlign.center,
            style: AppTextStyles.meta.copyWith(fontSize: 15),
          ),
          const SizedBox(height: 32),
          GradientButton(
            label: 'Start a chat',
            icon: Icons.chat_bubble_outline_rounded,
            onPressed: () {},
          ),
          const SizedBox(height: 12),
          _buildCreateGroupButton(),
          const SizedBox(height: 20),
          _buildColleaguesFooter(),
          const Spacer(),
        ],
      ),
    );
  }

  Widget _buildChatIllustration() {
    return SizedBox(
      width: 240,
      height: 170,
      child: Stack(
        children: [
          // Back bubble — pink-to-indigo gradient, rotated
          Positioned(
            left: 10,
            top: 10,
            child: Transform.rotate(
              angle: -0.12,
              child: Container(
                width: 165,
                height: 115,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFE5007D), Color(0xFF7B2FC9)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(26),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 9,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Container(
                        height: 9,
                        width: 70,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.5),
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // Front bubble — light lavender
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 128,
              height: 85,
              decoration: BoxDecoration(
                color: const Color(0xFFC5BCEE),
                borderRadius: BorderRadius.circular(22),
              ),
              child: Center(
                child: Container(
                  height: 9,
                  width: 64,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.75),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateGroupButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 52,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.line,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.person_add_outlined, color: AppColors.indigo, size: 20),
            const SizedBox(width: 8),
            Text(
              'Create a group',
              style: AppTextStyles.nameLabel.copyWith(color: AppColors.indigo),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColleaguesFooter() {
    return Text.rich(
      TextSpan(
        text: '12 colleagues are already on TB Chat · ',
        style: AppTextStyles.meta.copyWith(fontSize: 14),
        children: [
          TextSpan(
            text: 'See all',
            style: AppTextStyles.meta.copyWith(
              fontSize: 14,
              color: AppColors.pink,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _buildBottomNav() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      backgroundColor: AppColors.white,
      selectedItemColor: AppColors.pink,
      unselectedItemColor: AppColors.muted,
      selectedLabelStyle: AppTextStyles.meta.copyWith(
        color: AppColors.pink,
        fontWeight: FontWeight.w600,
      ),
      unselectedLabelStyle: AppTextStyles.meta,
      currentIndex: 0,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_outline_rounded),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group_outlined),
          label: 'Groups',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.contact_page_outlined),
          label: 'Contacts',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline_rounded),
          label: 'Profile',
        ),
      ],
    );
  }
}
