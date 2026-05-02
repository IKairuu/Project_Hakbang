import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hakbang/design/app_colors.dart';
import 'package:hakbang/models/ai_message.dart';
import 'package:hakbang/notifiers.dart';
import 'package:hakbang/server/services/ai_chat.dart';
import 'package:intl/intl.dart';

class AiGabay extends StatefulWidget {
  const AiGabay({super.key});

  @override
  State<AiGabay> createState() => _AiGabayState();
}

class _AiGabayState extends State<AiGabay> with AutomaticKeepAliveClientMixin {
  final TextEditingController _inputController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  final List<String> _suggestionChips = [
    'What is UPCAT?',
    'Best STEM schools',
    'Scholarship tips',
    'UPG calculator help',
    'Review chatTimetable',
  ];

  void sendMessage(String text) async {
    final trimmed = text.trim();
    if (trimmed.isEmpty || text.isEmpty) return;
    setState(() => chatLoading.value = true);

    var messageData = {"message": trimmed};
    setState(() {
      chatMessages.value.add(
        AiMessage(
          text: trimmed,
          role: "user",
          chatTime: DateFormat('hh:mm a').format(DateTime.now()),
        ),
      );
      _inputController.clear();
    });
    _scrollToBottom();

    await AiChat.sendUsermessage(messageData)
        .then((value) {
          setState(() {
            chatMessages.value.add(
              AiMessage(
                text: value,
                role: "model",
                chatTime: DateFormat('hh:mm a').format(DateTime.now()),
              ),
            );
          });

          _scrollToBottom();
        })
        .onError((error, stackTrace) {
          setState(() {
            chatMessages.value.add(
              AiMessage(
                text: 'Server Side error $error',
                role: "model",
                chatTime: DateFormat('hh:mm a').format(DateTime.now()),
              ),
            );
          });

          _scrollToBottom();
        });
    setState(() => chatLoading.value = false);
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
    final bubbleColor = message.role == "user"
        ? AppColors.accent
        : AppColors.surface2;
    final textColor = message.role == "user"
        ? AppColors.onAccent
        : AppColors.textPrimary;
    final borderRadius = message.role == "user"
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
          color: message.role == "user"
              ? Colors.transparent
              : const Color(0x11FFFFFF),
        ),
      ),
      child: Text(
        message.text,
        style: TextStyle(
          color: textColor,
          fontSize: 13,
          height: 1.5,
          fontWeight: message.role == "user"
              ? FontWeight.w500
              : FontWeight.w400,
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
    super.build(context);

    return ValueListenableBuilder(
      valueListenable: userCredentials,
      builder: (context, user, child) {
        return user == null
            ? Center(
                child: Text(
                  "Not Logged In",
                  style: GoogleFonts.dmSans(
                    color: AppColors.textMuted,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              )
            : Container(
                color: AppColors.bg,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 25),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 20, 24, 14),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.accentDim,
                              borderRadius: BorderRadius.circular(16),
                              border: Border.all(
                                color: AppColors.accent,
                                width: 1.5,
                              ),
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
                                    color: AppColors.textPrimary,
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
                                        color: AppColors.accent,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Text(
                                      'Online · Ready to help',
                                      style: TextStyle(
                                        color: AppColors.accent,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: ValueListenableBuilder(
                          valueListenable: chatMessages,
                          builder: (context, messages, child) {
                            return messages.isEmpty
                                ? SizedBox()
                                : Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: Center(
                                          child: Text(
                                            'Today · ${messages[0].chatTime} ',
                                            style: const TextStyle(
                                              color: AppColors.textMuted,
                                              fontSize: 11,
                                            ),
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 12),
                                      Expanded(
                                        child: ListView.builder(
                                          controller: _scrollController,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemCount: messages.length,
                                          itemBuilder: (context, index) {
                                            final message = messages[index];
                                            if (message.role != "user") {
                                              return Padding(
                                                padding: const EdgeInsets.only(
                                                  bottom: 12,
                                                ),
                                                child: Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width: 28,
                                                      height: 28,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            AppColors.accentDim,
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                              10,
                                                            ),
                                                        border: Border.all(
                                                          color:
                                                              AppColors.accent,
                                                          width: 1,
                                                        ),
                                                      ),
                                                      child: const Center(
                                                        child: Text(
                                                          '🤖',
                                                          style: TextStyle(
                                                            fontSize: 14,
                                                          ),
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
                                              padding: const EdgeInsets.only(
                                                bottom: 12,
                                              ),
                                              child: SizedBox(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    _buildBubble(message),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 4,
                                                          ),
                                                      child: Text(
                                                        messages[index]
                                                            .chatTime,
                                                        style: const TextStyle(
                                                          color: AppColors
                                                              .textMuted,
                                                          fontSize: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                          },
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 8,
                      ),
                      height: 50,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _suggestionChips.length,
                        separatorBuilder: (_, __) => const SizedBox(width: 8),
                        itemBuilder: (context, index) {
                          final chip = _suggestionChips[index];
                          return ValueListenableBuilder(
                            valueListenable: chatLoading,
                            builder: (context, loading, child) {
                              return GestureDetector(
                                onTap: () {
                                  if (user.role == "admin") {
                                    loading ? null : sendMessage(chip);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text("Admin only feature"),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 14,
                                    vertical: 8,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.surface2,
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(
                                      color: AppColors.border2,
                                    ),
                                  ),
                                  child: Text(
                                    chip,
                                    style: const TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              );
                            },
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
                                color: AppColors.surface2,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: AppColors.border2),
                              ),
                              child: TextField(
                                controller: _inputController,
                                style: const TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                ),
                                cursorColor: AppColors.accent,
                                decoration: const InputDecoration(
                                  hintText: 'Ask Gabay anything...',
                                  hintStyle: TextStyle(
                                    color: AppColors.textMuted,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 13,
                                  ),
                                ),
                                onSubmitted: (_) =>
                                    sendMessage(_inputController.text),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                          ValueListenableBuilder(
                            valueListenable: chatLoading,
                            builder: (context, loading, child) {
                              return GestureDetector(
                                onTap: () {
                                  if (user.role == "admin") {
                                    loading
                                        ? null
                                        : sendMessage(_inputController.text);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        behavior: SnackBarBehavior.floating,
                                        content: Text("Admin only feature"),
                                      ),
                                    );
                                  }
                                },
                                child: Container(
                                  width: 44,
                                  height: 44,
                                  decoration: BoxDecoration(
                                    color: AppColors.accent,
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      '➤',
                                      style: TextStyle(
                                        color: AppColors.onAccent,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
      },
    );
  }
}
