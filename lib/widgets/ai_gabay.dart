import 'package:flutter/material.dart';
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
  bool chatLoading = false;

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
    chatLoading = true;
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;

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
    chatLoading = false;
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
        ? const Color(0xFFC8FF4D)
        : const Color(0xFF1C1E27);
    final textColor = message.role == "user"
        ? const Color(0xFF0C0D10)
        : const Color(0xFFF0F1F5);
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
    const bgColor = Color(0xFF0C0D10);
    const surface2 = Color(0xFF1C1E27);
    const border2 = Color(0x1FFFFFFF);
    const accent = Color(0xFFC8FF4D);
    const accentDim = Color(0x1CC8FF4D);
    const textPrimary = Color(0xFFF0F1F5);
    const textMuted = Color(0x4DF0F1F5);

    return Container(
      color: bgColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 20, 24, 14),
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
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ValueListenableBuilder(
                valueListenable: chatMessages,
                builder: (context, messages, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Center(
                          child: Text(
                            'Today · ${messages[0].chatTime} ',
                            style: const TextStyle(
                              color: textMuted,
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
                          physics: const BouncingScrollPhysics(),
                          itemCount: messages.length,
                          itemBuilder: (context, index) {
                            final message = messages[index];
                            if (message.role != "user") {
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
                                        border: Border.all(
                                          color: accent,
                                          width: 1,
                                        ),
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
                              child: SizedBox(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    _buildBubble(message),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        messages[index].chatTime,
                                        style: const TextStyle(
                                          color: textMuted,
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
                  onTap: () => chatLoading ? null : sendMessage(chip),
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
                  onTap: () =>
                      chatLoading ? null : sendMessage(_inputController.text),
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
