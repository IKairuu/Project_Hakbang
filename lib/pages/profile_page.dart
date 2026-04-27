import 'package:flutter/material.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/background_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/models/college.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/college_description.dart';
import 'package:hakbang/pages/login_page.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/widgets/edit_about_me_dialog.dart';
import 'package:hakbang/widgets/saved_school_card.dart';

class ProfilePage extends StatefulWidget {
	const ProfilePage({super.key});

	@override
	State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
	String _aboutMeText =
		'In in ut cupidatat qui officia. Magna pariatur dolore laboris occaecat ad nulla excepteur pariatur sint.';

  static const SizedBox _space8 = SizedBox(height: 8);
  static const SizedBox _space10 = SizedBox(height: 10);
  static const SizedBox _space20 = SizedBox(height: 20);

	Future<void> _showEditAboutMeDialog() async {
		final editedText = await showEditAboutMeDialog(
			context,
			initialText: _aboutMeText,
		);

		if (editedText == null) {
			return;
		}

		setState(() {
			_aboutMeText = editedText;
		});
	}

  String _withFallback(String? value, String fallback) {
    final trimmed = value?.trim() ?? '';
    return trimmed.isNotEmpty ? trimmed : fallback;
  }

  void _logout() {
    clearSessionState();
    
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => LoginPage(),
      ),
      (route) => false,
    );
  }

  Future<void> _confirmLogout() async {
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          backgroundColor: AppColors.surface,
          title: Text(
            'Log out?',
            style: FontStyles.logoutDialogTitle,
          ),
          content: Text(
            'Are you sure you want to log out of your account?',
            style: FontStyles.profileAboutBody,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.black,
              ),
              child: const Text('Log out'),
            ),
          ],
        );
      },
    );

    if (shouldLogout == true) {
      _logout();
    }
  }

  void _openCollegeDescription(College college) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CollegeDescription(college: college),
      ),
    );
  }

  Widget _buildProfileChip({
    required String text,
    required BoxDecoration decoration,
    bool ellipsis = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: decoration,
      child: Text(
        text,
        maxLines: ellipsis ? 1 : null,
        overflow: ellipsis ? TextOverflow.ellipsis : null,
        style: FontStyles.previewPillText,
      ),
    );
  }

	@override
	Widget build(BuildContext context) {
		return ValueListenableBuilder(
			valueListenable: userCredentials,
			builder: (context, userData, child) {
        final avatar = _withFallback(userData?.avatar, '🙂');
        final name = _withFallback(userData?.name, 'Unknown User');
        final email = _withFallback(userData?.email, 'No email available');
        final occupation = _withFallback(userData?.occupation, 'Occupation');
        final grade = _withFallback(userData?.grade, 'Grade Level');
        final school = _withFallback(userData?.institution, 'School');

				return Scaffold(
					backgroundColor: AppColors.bg,
          appBar: AppBar(
              backgroundColor: AppColors.bg,
              surfaceTintColor: Colors.transparent,
              elevation: 0,
            leading: IconButton(
              icon: const Icon(
                  Icons.chevron_left,
                color: Colors.white,
                  size: 28,
              ),
              onPressed: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                } else {
                  navigationBarIndex.value = 2;
                }
              },
            ),
            actions: [
              IconButton(
                onPressed: _confirmLogout,
                icon: const Icon(Icons.logout_rounded),
                color: Colors.white,
                tooltip: 'Log out',
              ),
            ],
          ),
					body: Container(
						decoration: const BoxDecoration(
							gradient: LinearGradient(
								begin: Alignment.topCenter,
								end: Alignment.bottomCenter,
								colors: [
									AppColors.bodyBg,
									AppColors.bg,
								],
							),
						),
						child: SafeArea(
							child: Stack(
								children: [
                  Positioned.fill(
                    child: Opacity(
                      opacity: 0.18,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            center: Alignment.topCenter,
                            radius: 1.3,
                            colors: [
                                BackgroundDesign.startPageColor.withValues(alpha: 0.0),
                              BackgroundDesign.startPageColor,
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _space8,
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: AppColors.surface.withValues(alpha: 0.95),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.border2),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.28),
                                blurRadius: 24,
                                offset: const Offset(0, 14),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 70,
                                    height: 70,
                                    decoration: BoxDecoration(
                                      color: AppColors.accent.withValues(alpha: 0.16),
                                      borderRadius: BorderRadius.circular(14),
                                      border: Border.all(color: AppColors.accent),
                                    ),
                                    child: Center(
                                      child: Text(
                                        avatar,
                                        style: const TextStyle(fontSize: 40),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyles.previewName,
                                        ),
                                        Text(
                                          email,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: FontStyles.previewEmail,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              _space10,
                              Row(
                                children: [
                                  _buildProfileChip(
                                    text: occupation,
                                    decoration: ContainerDesign.pillTagOccupation,
                                  ),
                                  const SizedBox(width: 8),
                                  _buildProfileChip(
                                    text: grade,
                                    decoration: ContainerDesign.pillTagGrade,
                                  ),
                                ],
                              ),
                              _space8,
                              Row(
                                children: [
                                  _buildProfileChip(
                                    text: school,
                                    decoration: ContainerDesign.pillTagGrade,
                                    ellipsis: true,
                                  ),
                                ],
                              ),
                              _space20,
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: AppColors.surface2.withValues(alpha: 0.9),
                                  borderRadius: BorderRadius.circular(18),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'About Me:',
                                          style: FontStyles.profileAboutTitle,
                                        ),
                                        TextButton.icon(
                                          onPressed: _showEditAboutMeDialog,
                                          icon: const Icon(Icons.edit_rounded, size: 16),
                                          label: const Text('Edit'),
                                          style: TextButton.styleFrom(
                                            foregroundColor: AppColors.accent,
                                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                            minimumSize: Size.zero,
                                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      _aboutMeText,
                                      style: FontStyles.profileAboutBody,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        _space20,
                        Text(
                          'Saved Schools',
                          style: FontStyles.profileSectionTitle,
                        ),
                        _space10,
                        Expanded(
                          child: ValueListenableBuilder(
                            valueListenable: savedSchools,
                            builder: (context, saved, child) {
                              if (saved.isEmpty) {
                                return Container(
                                  width: double.infinity,
                                  padding: const EdgeInsets.all(16),
                                  decoration: ContainerDesign.universitySections,
                                  child: Text(
                                    'No saved school yet.',
                                    style: FontStyles.profileEmptySavedSchools,
                                  ),
                                );
                              }

                              return ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemCount: saved.length,
                                separatorBuilder: (_, __) => const SizedBox(height: 12),
                                itemBuilder: (context, index) {
                                  final college = saved[index];
                                  return GestureDetector(
                                    onTap: () => _openCollegeDescription(college),
                                    child: SavedSchoolCard(college: college),
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
								],
							),
						),
					),
				);
			},
		);
	}
}
