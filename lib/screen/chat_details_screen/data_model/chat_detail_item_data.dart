class ChatDetailItemData{
  final String chatText, sendTime, userId, epocTime;
  final bool isDelivered;

  const ChatDetailItemData({
    required this.userId,
    required this.sendTime,
    required this.chatText,
    required this.isDelivered,
    this.epocTime = '',
  });

  factory ChatDetailItemData.empty(){
    return const ChatDetailItemData(
      userId: '',
      sendTime: '',
      chatText: '',
      isDelivered: false,
      epocTime: '',
    );
  }
}