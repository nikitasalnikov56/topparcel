class ServerErrorException implements Exception {
  final String text;
  final String side;
  final int code;

  ServerErrorException(
      {required this.text, required this.side, required this.code});

  factory ServerErrorException.fromJson(Map json) {
    if (json['description'] != null) {
      return ServerErrorException(
        text: json['description'],
        side: '',
        code: json['status'],
      );
    }
    if (json['text'] != null) {
      return ServerErrorException(
        text: json['text'],
        side: json['side'],
        code: json['code'],
      );
    } else if (json['message'] != null) {
      return ServerErrorException(
        text: json['message'] as String,
        side: (json['data'] as Map)['side'],
        code: json['code'],
      );
    } else {
      return ServerErrorException(
        text: 'Неизвестная ошибка, попробуйте выполнить запрос позже.',
        side: 'Неизвестно',
        code: 0,
      );
    }
  }
}
