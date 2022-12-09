part of responsive_data_grid;

class GridGroupFooter<TItem extends Object> extends StatelessWidget {
  final GroupResult group;
  final GroupValueResult value;
  final int groupCount;
  final ResponsiveDataGridState gridState;
  final ThemeData theme;

  GridGroupFooter({
    required this.group,
    required this.groupCount,
    required this.value,
    required this.theme,
    required this.gridState,
  }) {
    assert(TItem != Object);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.black38),
      child: Padding(
        padding: EdgeInsets.only(
          left: 15.0 * groupCount,
          top: 3,
          bottom: 3,
          right: 3,
        ),
        child: BootstrapRow(
          crossAxisAlignment: gridState.widget.rowCrossAxisAlignment ==
                      CrossAxisAlignment.start ||
                  gridState.widget.rowCrossAxisAlignment ==
                      CrossAxisAlignment.stretch
              ? WrapCrossAlignment.start
              : gridState.widget.rowCrossAxisAlignment ==
                      CrossAxisAlignment.center
                  ? WrapCrossAlignment.center
                  : WrapCrossAlignment.end,
          children: getColumns(context),
          totalSegments: gridState.widget.reactiveSegments,
        ),
      ),
    );
  }

  List<BootstrapCol> getColumns(BuildContext context) {
    return gridState.widget.columns.map(
      (c) {
        final agg = value.aggregates
            .where((a) => a.fieldName == c.fieldName)
            .firstOrDefault();
        return BootstrapCol(
          child: agg?.result == null
              ? Container()
              : Text("${agg!.aggregation.toString()}: ${agg.result}"),
          lg: c.largeCols ?? c.mediumCols ?? c.smallCols ?? c.xsCols ?? 12,
          md: c.mediumCols ?? c.smallCols ?? c.xsCols ?? 12,
          sm: c.smallCols ?? c.xsCols ?? 12,
          xl: c.xlCols ??
              c.largeCols ??
              c.mediumCols ??
              c.smallCols ??
              c.xsCols ??
              12,
          xs: c.xsCols ?? 12,
        );
      },
    ).toList();
  }
}