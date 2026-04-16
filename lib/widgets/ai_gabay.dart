import 'package:flutter/material.dart';

class AiMessage {
  final String text;
  final bool isUser;

  AiMessage({required this.text, required this.isUser});
}

class AiGabay extends StatefulWidget {
  const AiGabay({super.key});

  @override
  State<AiGabay> createState() => _AiGabayState();
}

class _AiGabayState extends State<AiGabay> {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<AiMessage> _messages = [
    AiMessage(
      text:
          'Hi Maria! 👋 I\'m Gabay, your college planning assistant. I can help you choose the right school, find scholarships, understand entrance exams, and calculate your UPG. What would you like to explore today?',
      isUser: false,
    ),
    AiMessage(
      text: 'What\'s the difference between ACET and DCAT?',
      isUser: true,
    ),
    AiMessage(
      text:
          'Great question! Here\'s a quick comparison:\n\nACET (Ateneo College Entrance Test)\n• Offered by Ateneo de Manila\n• Tests verbal, math, and abstract reasoning\n• Strong focus on communication skills\n\nDCAT (De La Salle College Admissions Test)\n• Offered by DLSU\n• Covers English, math, and science\n• More STEM-focused structure\n\nBoth are competitive — your choice depends on which school fits your program and values best! 🎯',
      isUser: false,
    ),
  ];
  final List<String> _suggestionChips = [
    'What is UPCAT?',
    'Best STEM schools',
    'Scholarship tips',
    'UPG calculator help',
    'Review timetable',
  ];

  void sendMessage(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

    setState(() {
      _messages.add(AiMessage(text: trimmed, isUser: true));
      _inputController.clear();
    });

    _scrollToBottom();

    Future.delayed(const Duration(milliseconds: 1200), () {
      setState(() {
        _messages.add(
          AiMessage(text: 'Let me look that up for you... 🔍', isUser: false),
        );
      });
      _scrollToBottom();
    });
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Widget _buildBubble(AiMessage message) {
    final bubbleColor = message.isUser
        ? const Color(0xFFC8FF4D)
        : const Color(0xFF1C1E27);
    final textColor = message.isUser
        ? const Color(0xFF0C0D10)
        : const Color(0xFFF0F1F5);
    final borderRadius = message.isUser
        ? const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomLeft: Radius.circular(18),
            bottomRight: Radius.circular(5),
          )
        : const BorderRadius.only(
            topLeft: Radius.circular(18),
            topRight: Radius.circular(18),
            bottomRight: Radius.circular(18),
            bottomLeft: Radius.circular(5),
          );

    return Container(
      constraints: BoxConstraints(
        maxWidth: MediaQuery.of(context).size.width * 0.75,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: borderRadius,
        border: Border.all(
          color: message.isUser ? Colors.transparent : const Color(0x11FFFFFF),
        ),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          height: 1.5,
          fontWeight: message.isUser ? FontWeight.w500 : FontWeight.w400,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _inputController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const bgColor = Color(0xFF0C0D10);
    const surface2 = Color(0xFF1C1E27);
    const border2 = Color(0x1FFFFFFF);
    const accent = Color(0xFFC8FF4D);
    const accentDim = Color(0x1CC8FF4D);
    const textPrimary = Color(0xFFF0F1F5);
    const textSecondary = Color(0x8CF0F1F5);
    const textMuted = Color(0x4DF0F1F5);

    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 58, 24, 14),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: accentDim,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: accent, width: 1.5),
                  ),
                  child: const Center(
                    child: Text('🤖', style: TextStyle(fontSize: 22)),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'Gabay AI',
                        style: TextStyle(
                          color: textPrimary,
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            '●',
                            style: TextStyle(
                              color: accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Online · Ready to help',
                            style: TextStyle(
                              color: accent,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const Text(
                  '⋯',
                  style: TextStyle(color: textSecondary, fontSize: 20),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Today · 9:38 AM',
                      style: const TextStyle(color: textMuted, fontSize: 11),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.zero,
                      physics: const BouncingScrollPhysics(),
                      itemCount: _messages.length,
                      itemBuilder: (context, index) {
                        final message = _messages[index];
                        if (!message.isUser) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  width: 28,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: accentDim,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: accent, width: 1),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '🤖',
                                      style: TextStyle(fontSize: 14),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                _buildBubble(message),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              const Spacer(),
                              _buildBubble(message),
                              const Padding(
                                padding: EdgeInsets.only(left: 6, bottom: 4),
                                child: Text(
                                  '9:40',
                                  style: TextStyle(
                                    color: textMuted,
                                    fontSize: 10,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            height: 60,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              itemCount: _suggestionChips.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final chip = _suggestionChips[index];
                return GestureDetector(
                  onTap: () => sendMessage(chip),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: surface2,
                      borderRadius: BorderRadius.circular(100),
                      border: Border.all(color: border2),
                    ),
                    child: Text(
                      chip,
                      style: const TextStyle(
                        color: textPrimary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: surface2,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: border2),
                    ),
                    child: TextField(
                      controller: _inputController,
                      style: const TextStyle(color: textPrimary, fontSize: 14),
                      cursorColor: accent,
                      decoration: const InputDecoration(
                        hintText: 'Ask Gabay anything...',
                        hintStyle: TextStyle(color: textMuted),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 13,
                        ),
                      ),
                      onSubmitted: (_) => sendMessage(_inputController.text),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap: () => sendMessage(_inputController.text),
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: accent,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: const Center(
                      child: Text(
                        '➤',
                        style: TextStyle(
                          color: Color(0xFF0C0D10),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
