class ChatItemData{
  final String imageUrl, name, lastChat, lastTime, chatRoomId;
  final bool isDelivered;

  const ChatItemData({
    required this.lastChat,
    required this.imageUrl,
    required this.lastTime,
    required this.isDelivered,
    required this.name,
    required this.chatRoomId,
  });
}