class ParcelContentModel {
  late String type;
  late String description;
  late int quantity;
  late int value;

  ParcelContentModel({
    required this.type,
    required this.description,
    required this.quantity,
    required this.value,
  });

  static ParcelContentModel emptyModel() {
    return ParcelContentModel(
      type: '',
      description: '',
      quantity: 1,
      value: 0,
    );
  }
}
