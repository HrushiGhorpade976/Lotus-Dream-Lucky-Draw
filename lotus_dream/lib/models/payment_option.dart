class PaymentOption {
  final String name;
  final String icon;
  final String description;

  const PaymentOption({
    required this.name,
    required this.icon,
    required this.description,
  });

  factory PaymentOption.fromJson(Map<String, dynamic> json) {
    return PaymentOption(
      name: json['name'] ?? '',
      icon: json['icon'] ?? '',
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'icon': icon,
        'description': description,
      };
}
