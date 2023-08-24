import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/productionorder_model.dart';

class ProductionOrderList extends StatelessWidget {
  const ProductionOrderList(
    this.orders, {
    super.key,
    required this.onRevome,
  });

  final List<ProductionOrderModel> orders;
  final void Function(String) onRevome;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return orders.isEmpty
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                SizedBox(
                  height: constraints.maxHeight * 0.1,
                  child: Text(
                    "Nenhuma transação cadastrada!",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.05,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.5,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            );
          })
        : ListView.builder(
            itemCount: orders.length,
            itemBuilder: (ctx, index) {
              final op = orders[index];
              return Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text('R\$${op.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    op.title,
                    style: theme.textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    DateFormat('d MM y').format(op.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton.icon(
                          onPressed: () => onRevome(op.id),
                          icon: const Icon(Icons.delete),
                          label: const Text("Excluir"),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.resolveWith<Color?>((s) {
                              return theme.colorScheme
                                  .error; // Disabled text color // Enabled text color
                            }),
                          ),
                        )
                      : IconButton(
                          icon: const Icon(Icons.delete),
                          color: theme.colorScheme.error,
                          onPressed: () => onRevome(op.id),
                        ),
                ),
              );
            },
          );
  }
}
