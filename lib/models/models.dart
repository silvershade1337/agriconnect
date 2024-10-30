class Message {
  String from;
  String content;

  Message({required this.from, required this.content});
}

class MessageStore {
  final List<Message> _messages = [];
  List<Message> getMessages() {
    return _messages;
  }
  void addMessage(Message message) {
    _messages.add(message);
  }
}

class ProdServViewDetails {
  final String headline;
  final String postedby;
  final String description;
  final String city;

  const ProdServViewDetails({
    required this.headline,
    required this.postedby,
    required this.description,
    required this.city,
  });

  @override
  String toString() {
    return 'ProdServViewDetails(headline: $headline, posted by: $postedby, description: $description, city: $city)';
  }
}