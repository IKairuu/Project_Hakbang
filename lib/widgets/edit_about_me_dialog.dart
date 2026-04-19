import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';

Future<String?> showEditAboutMeDialog(
	BuildContext context, {
	required String initialText,
}) async {
	final controller = TextEditingController(text: initialText);

	final editedText = await showDialog<String>(
		context: context,
		builder: (dialogContext) {
			return EditAboutMeDialog(controller: controller);
		},
	);

	controller.dispose();
	return editedText;
}

class EditAboutMeDialog extends StatelessWidget {
	final TextEditingController controller;

	const EditAboutMeDialog({
		super.key,
		required this.controller,
	});

	@override
	Widget build(BuildContext context) {
		return AlertDialog(
			backgroundColor: AppColors.surface,
			title: Text(
				'Edit About Me',
				style: GoogleFonts.dmSans(
					color: AppColors.textPrimary,
					fontWeight: FontWeight.w700,
				),
			),
			content: TextField(
				controller: controller,
				maxLines: 6,
				style: GoogleFonts.inter(
					color: AppColors.textPrimary,
					fontSize: 13,
				),
				decoration: InputDecoration(
					hintText: 'Tell people about yourself...',
					hintStyle: GoogleFonts.inter(color: AppColors.textSecondary),
					filled: true,
					fillColor: AppColors.surface2.withValues(alpha: 0.65),
					border: OutlineInputBorder(
						borderRadius: BorderRadius.circular(12),
						borderSide: BorderSide(color: AppColors.border),
					),
					enabledBorder: OutlineInputBorder(
						borderRadius: BorderRadius.circular(12),
						borderSide: BorderSide(color: AppColors.border),
					),
					focusedBorder: OutlineInputBorder(
						borderRadius: BorderRadius.circular(12),
						borderSide: BorderSide(color: AppColors.accent),
					),
				),
			),
			actions: [
				TextButton(
					onPressed: () => Navigator.pop(context),
					style: TextButton.styleFrom(
						foregroundColor: Colors.white,
					),
					child: const Text('Cancel'),
				),
				ElevatedButton(
					onPressed: () => Navigator.pop(context, controller.text.trim()),
					style: ElevatedButton.styleFrom(
						backgroundColor: AppColors.accent,
						foregroundColor: Colors.black,
					),
					child: const Text('Save'),
				),
			],
		);
	}
}
