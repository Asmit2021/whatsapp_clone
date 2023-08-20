enum MessageEnum {
  text('text'),
  image('image'),
  audio('audio'),
  video('video'),
  gif('gif');

  final String type;
  const MessageEnum(this.type);

  factory MessageEnum.fromString(String type) {
    return values.firstWhere((element) => element.type == type);
  }
}
