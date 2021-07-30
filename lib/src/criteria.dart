part of responsive_data_grid;

class FilterCriteria {
  final String fieldName;
  final FilterOperators op;
  final LogicalOperators logicalOperator;
  final dynamic value;

  const FilterCriteria({
    required this.fieldName,
    required this.op,
    required this.value,
    required this.logicalOperator,
  });
}

class OrderCriteria {
  final String fieldName;
  final OrderDirections direction;

  const OrderCriteria(this.fieldName, this.direction);
}

class LoadCriteria {
  final int? skip;
  final int? take;
  final List<FilterCriteria> filterBy;
  final List<OrderCriteria> orderBy;

  LoadCriteria({
    this.skip,
    this.take,
    List<FilterCriteria>? filterBy,
    List<OrderCriteria>? orderBy,
  })  : this.filterBy = filterBy ?? List<FilterCriteria>.empty(growable: true),
        this.orderBy = orderBy ?? List<OrderCriteria>.empty(growable: true);
}