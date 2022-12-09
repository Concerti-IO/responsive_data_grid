part of responsive_data_grid;

class GridFooter<TItem extends Object> extends StatelessWidget {
  final ResponseCache<TItem> data;
  final ResponsiveDataGridState gridState;

  GridFooter(this.data, this.gridState) {
    assert(TItem != Object);
  }

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.black38),
      child: Padding(
        padding: EdgeInsets.only(
          top: 3,
          bottom: 3,
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
    return gridState.widget.columns
        .where((c) => data.aggregates
            .any((a) => a.fieldName == c.fieldName && a.result != null))
        .map((c) {
      final agg = data.aggregates
          .where((a) => a.fieldName == c.fieldName)
          .firstOrDefault();
      if (agg == null || agg.result == null)
        throw UnsupportedError(
            "An aggregate can't be found for the given field.");

      //TODO This needs to lookup all of the arrgregations and put in the right values if any, otherwise just a container.

      return BootstrapCol(
        child: Text(agg.result!),
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
    }).toList();
  }
}
