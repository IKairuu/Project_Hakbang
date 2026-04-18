import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/design/background_design.dart';
import 'package:hakbang/design/font_styles.dart';

class ProfilePage extends StatelessWidget {
	const ProfilePage({super.key});

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
																	width: 50,
																	height: 50,
																	decoration: BoxDecoration(
																		color: AppColors.accent.withValues(alpha: 0.16),
																		borderRadius: BorderRadius.circular(14),
																		border: Border.all(color: AppColors.accent),
																	),
																	child: const Center(
																		child: Text(
																			'🙂',
																			style: TextStyle(fontSize: 25),
																		),
																	),
																),
																const SizedBox(width: 16),
																Expanded(
																	child: Column(
																		crossAxisAlignment: CrossAxisAlignment.start,
																		children: [
																			Text(
																				'Your Name',
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
																	decoration: BoxDecoration(
																		color: AppColors.accent.withValues(alpha: 0.18),
																		borderRadius: BorderRadius.circular(999),
																		border: Border.all(color: AppColors.accent.withValues(alpha: 0.45)),
																	),
																	child: Text(
																		'Identity',
																		style: GoogleFonts.inter(
																			color: AppColors.accent,
																			fontSize: 12,
																			fontWeight: FontWeight.w700,
																		),
																	),
																),
																const SizedBox(width: 8),
																Container(
																	padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
																	decoration: BoxDecoration(
																		color: AppColors.blueDim,
																		borderRadius: BorderRadius.circular(999),
																		border: Border.all(color: AppColors.blue.withValues(alpha: 0.45)),
																	),
																	child: Text(
																		'Grade Level',
																		style: GoogleFonts.inter(
																			color: AppColors.blue,
																			fontSize: 12,
																			fontWeight: FontWeight.w700,
																		),
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
																	Text(
																		'Placeholder base area',
																		style: GoogleFonts.inter(
																			color: Colors.white,
																			fontSize: 14,
																			fontWeight: FontWeight.w600,
																		),
																	),
																	const SizedBox(height: 6),
																	Text(
																		'Profile information will be placed here later.',
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
