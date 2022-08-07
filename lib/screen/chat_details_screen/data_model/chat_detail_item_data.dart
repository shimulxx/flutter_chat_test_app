class ChatDetailItemData{
  final String chatText, sendTime, userId;
  final bool isDelivered;

  const ChatDetailItemData({
    required this.userId,
    required this.sendTime,
    required this.chatText,
    required this.isDelivered,
  });
}