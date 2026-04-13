import 'package:flutter/material.dart';

class AppColors {
  // ── Backgrounds
  static const bg           = Color(0xFF0C0D10);   // --bg
  static const bodyBg       = Color(0xFF07080C);   // body background
  static const surface      = Color(0xFF13141A);   // --surface (bottom nav, cards)
  static const surface2     = Color(0xFF1C1E27);   // --surface2 (list items, inputs)
  static const surface3     = Color(0xFF23263A);   // --surface3 (inactive dots, avatar bg)

  // ── Borders
  static const border       = Color(0x12FFFFFF);   // rgba(255,255,255,0.07)
  static const border2      = Color(0x1FFFFFFF);   // rgba(255,255,255,0.12)

  // ── Accent (Lime) — PRIMARY brand color
  static const accent       = Color(0xFFC8FF4D);   // #C8FF4D — buttons, active states
  static const accentDim    = Color(0x1FC8FF4D);   // rgba(200,255,77,0.12) — fills
  static const accentDim2   = Color(0x0FC8FF4D);   // rgba(200,255,77,0.06) — subtle fills
  static const onAccent     = Color(0xFF0C0D10);   // dark text ON accent button

  // ── Blue — state / info
  static const blue         = Color(0xFF4D8FFF);
  static const blueDim      = Color(0x264D8FFF);   // rgba(77,143,255,0.15)

  // ── Purple — scholarships
  static const purple       = Color(0xFFA855F7);
  static const purpleDim    = Color(0x26A855F7);   // rgba(168,85,247,0.15)

  // ── Coral — urgency / deadlines
  static const coral        = Color(0xFFFF6B4D);
  static const coralDim     = Color(0x26FF6B4D);   // rgba(255,107,77,0.15)

  // ── Teal — progress / success
  static const teal         = Color(0xFF4DFFB8);
  static const tealDim      = Color(0x1A4DFFB8);   // rgba(77,255,184,0.10)

  // ── Text
  static const textPrimary  = Color(0xFFF0F1F5);
  static const textSecondary= Color(0x8CF0F1F5);   // opacity 0.55
  static const textMuted    = Color(0x4DF0F1F5);   // opacity 0.30

  // ── Phone frame (if building a demo wrapper)
  static const frameBorder  = Color(0xFF1E2030);
  static const frameRing    = Color(0xFF2A2D42);
}