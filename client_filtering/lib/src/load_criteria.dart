part of client_filtering;

class LoadCriteria with IJsonable {
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

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is LoadCriteria &&
        other.skip == skip &&
        other.take == take &&
        listEquals(other.filterBy, filterBy) &&
        listEquals(other.orderBy, orderBy);
  }

  @override
  int get hashCode {
    return skip.hashCode ^ take.hashCode ^ filterBy.hashCode ^ orderBy.hashCode;
  }

  LoadCriteria copyWith({
    int? skip,
    int? take,
    List<FilterCriteria>? filterBy,
    List<OrderCriteria>? orderBy,
  }) {
    return LoadCriteria(
      skip: skip ?? this.skip,
      take: take ?? this.take,
      filterBy: filterBy ?? this.filterBy,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'skip': skip,
      'take': take,
      'filterBy': filterBy.map((x) => x.toJson()).toList(),
      'orderBy': orderBy.map((x) => x.toJson()).toList(),
    };
  }

  factory LoadCriteria.fromJson(Map<String, dynamic> map) {
    return LoadCriteria(
      skip: map['skip'],
      take: map['take'],
      filterBy: List<FilterCriteria>.from(
          map['filterBy']?.map((x) => FilterCriteria.fromJson(x))),
      orderBy: List<OrderCriteria>.from(
          map['orderBy']?.map((x) => OrderCriteria.fromJson(x))),
    );
  }
}