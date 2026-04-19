import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/background_design.dart';
import 'package:hakbang/design/font_styles.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/pages/login_page.dart';
import 'package:hakbang/design/container_design.dart';
import 'package:hakbang/widgets/edit_about_me_dialog.dart';

class ProfilePage extends StatefulWidget {
	const ProfilePage({super.key});

	@override
	State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
	String _aboutMeText =
		'In in ut cupidatat qui officia. Magna pariatur dolore laboris occaecat ad nulla excepteur pariatur sint. Id dolore quis pariatur irure. Amet culpa anim elit sunt. Dolore labore quis aute proident. Esse nostrud commodo ex consectetur ut.';

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

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			backgroundColor: AppColors.bg,
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
							Positioned(
								top: -90,
								left: -90,
								child: _GlowOrb(
									  color: AppColors.accent.withValues(alpha: 0.16),
									size: 400,
								),
							),
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
							SingleChildScrollView(
								child: Padding(
									padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
									child: Column(
										crossAxisAlignment: CrossAxisAlignment.start,
										children: [
											Row(
												children: [
													Expanded(
														child: Column(
															crossAxisAlignment: CrossAxisAlignment.start,
															children: [
																Text(
																	'Your Profile',
																	style: FontStyles.header,
																),
															],
														),
													),
													IconButton(
														onPressed: () {
															token.value = null;
															userCredentials.value = null;
															navigationBarIndex.value = 0;
															Navigator.pushAndRemoveUntil(
																context,
																MaterialPageRoute(
																	builder: (context) => LoginPage(),
																),
																(route) => false,
															);
														},
														icon: const Icon(Icons.logout_rounded),
														color: AppColors.textPrimary,
														tooltip: 'Log out',
													),
												],
											),
											const SizedBox(height: 28),
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
																	width:70,
																	height: 70,
																	decoration: BoxDecoration(
																		color: AppColors.accent.withValues(alpha: 0.16),
																		borderRadius: BorderRadius.circular(14),
																		border: Border.all(color: AppColors.accent),
																	),
																	child: const Center(
																		child: Text(
																			'🙂',
																			style: TextStyle(fontSize: 40),
																		),
																	),
																),
																const SizedBox(width: 16),
																Expanded(
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				'Joachim Nicholo Dela Cruz Rivera Martinez ',
																				style: FontStyles.previewName,
																				),
																			Text(
																				'you@example.com',
																				style: FontStyles.previewEmail,
																			),
																		],
																	),
																),
															],
														),
														const SizedBox(height: 10),
														Row(
															children: [
																Container(
																	padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
																	decoration: ContainerDesign.pillTagIdentity,
																	child: Text(
																		'Identity',
																		style: FontStyles.previewPillText,
																	),
																),
																const SizedBox(width: 8),
																Container(
																	padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
																	decoration: ContainerDesign.pillTagGrade,
																	child: Text(
																		'Grade Level',
																		style: FontStyles.previewPillText,
																	),
																),
															],
														),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                  decoration: ContainerDesign.pillTagGrade,
                                  child: Text(
                                    'De La Salle University',
                                    style: FontStyles.previewPillText,
                                  ),
                                ),
                              ],
                            ),
														const SizedBox(height: 20),
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
																				style: GoogleFonts.dmSans(
																					color: AppColors.textPrimary,
																					fontSize: 14,
																					fontWeight: FontWeight.w600,
																				),
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
																		style: GoogleFonts.inter(
																			color: AppColors.textMuted,
																			fontSize: 12,
																			fontWeight: FontWeight.w500,
																		),
																	),
																],
															),
														),
													],
												),
											),
										],
									),
								),
							),
						],
					),
				),
			),
		);
	}
}

class _GlowOrb extends StatelessWidget {
	final Color color;
	final double size;

	const _GlowOrb({
		required this.color,
		required this.size,
	});

	@override
	Widget build(BuildContext context) {
		return Container(
			width: size,
			height: size,
			decoration: BoxDecoration(
				shape: BoxShape.circle,
				gradient: RadialGradient(
					colors: [
						color,
						color.withValues(alpha: 0.0),
					],
				),
			),
		);
	}
}
