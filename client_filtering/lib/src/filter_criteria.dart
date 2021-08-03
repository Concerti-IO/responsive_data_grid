part of client_filtering;

class FilterCriteria {
  final String fieldName;
  final Logic op;
  final Operators logicalOperator;
  final String? value;

  const FilterCriteria({
    required this.fieldName,
    required this.op,
    required this.value,
    required this.logicalOperator,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FilterCriteria &&
        other.fieldName == fieldName &&
        other.op == op &&
        other.logicalOperator == logicalOperator &&
        other.value == value;
  }

  @override
  int get hashCode {
    return fieldName.hashCode ^
        op.hashCode ^
        logicalOperator.hashCode ^
        value.hashCode;
  }

  FilterCriteria copyWith({
    String? fieldName,
    Logic? op,
    Operators? logicalOperator,
    dynamic value,
  }) {
    return FilterCriteria(
      fieldName: fieldName ?? this.fieldName,
      op: op ?? this.op,
      logicalOperator: logicalOperator ?? this.logicalOperator,
      value: value ?? this.value,
    );
  }

  @override
  String toString() {
    return 'FilterCriteria(fieldName: $fieldName, op: $op, logicalOperator: $logicalOperator, value: $value)';
  }

  Map<String, dynamic> toMap() {
    return {
      'fieldName': fieldName,
      'op': op.toString(),
      'logicalOperator': logicalOperator.toString(),
      'value': value,
    };
  }

  factory FilterCriteria.fromMap(Map<String, dynamic> map) {
    return FilterCriteria(
      fieldName: map['fieldName'],
      op: Logic.values.firstWhere((v) => v == map['op']),
      logicalOperator:
          Operators.values.firstWhere((v) => v == map['logicalOperator']),
      value: map['value'],
    );
  }

  String toJson() => jsonEncode(toMap());

  factory FilterCriteria.fromJson(String source) =>
      FilterCriteria.fromMap(json.decode(source));
}
