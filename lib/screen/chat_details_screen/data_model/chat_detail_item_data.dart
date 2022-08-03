class ChatDetailItemData{
  final String chatText, sendTime;
  final bool self, isDelivered;

  const ChatDetailItemData({
    required this.self,
    required this.sendTime,
    required this.chatText,
    required this.isDelivered,
  });
}