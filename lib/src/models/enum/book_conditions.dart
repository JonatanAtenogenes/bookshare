enum BookCondition {
  excelent(name: 'Excelente', value: 5),
  likeNew(name: 'Como nuevo', value: 4),
  good(name: 'Bien', value: 3),
  acceptable(name: 'Aceptable', value: 2),
  poor(name: 'Mal estado', value: 1);

  final String name;
  final int value;

  const BookCondition({
    required this.name,
    required this.value,
  });
}