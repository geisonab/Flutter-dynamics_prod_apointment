import 'dart:io' show Platform;
import 'dart:math';
import 'package:dynamics_prod_apointment/Components/apointment_form.dart';
import 'package:dynamics_prod_apointment/Components/chart.dart';
import 'package:dynamics_prod_apointment/utils/productionorders_mock.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'Components/productionorder_list.dart';
import 'models/productionorder_model.dart';

main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    //SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    ThemeData themeData = ThemeData(
      brightness: Brightness.light,
      cupertinoOverrideTheme: const CupertinoThemeData(
        applyThemeToAll: true,
        primaryColor: Colors.purple,
        brightness: Brightness.light,
        textTheme: CupertinoTextThemeData(
          textStyle: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: MaterialStateProperty.all(
              const TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: MaterialStateProperty.resolveWith<Color?>((s) {
            if (s.contains(MaterialState.disabled)) {
              return Colors.grey[800]; // Disabled button color
            }
            return Colors.purple; // Enabled button color
          }),
          foregroundColor: MaterialStateProperty.resolveWith<Color?>((s) {
            if (s.contains(MaterialState.disabled)) {
              return Colors.grey[200]; // Disabled text color
            }
            return Colors.white; // Enabled text color
          }),
        ),
      ),
      primarySwatch: Colors.purple,
      fontFamily: 'Quicksand',
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeData.copyWith(
        colorScheme: themeData.colorScheme.copyWith(
          //primary: Colors.purple,
          secondary: const Color.fromARGB(255, 7, 255, 201),
        ),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 18.0 * mediaQuery.textScaleFactor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductionOrderModel> productionOrders = kReleaseMode
      ? List<ProductionOrderModel>.empty()
      : ProductionOrdersMock.getProductionOrders();

  bool _showChart = false;

  List<ProductionOrderModel> get _recentTransactions {
    return productionOrders
        .where((element) => element.date
            .isAfter(DateTime.now().subtract(const Duration(days: 7))))
        .toList();
  }

  _addTransaction(String order, double value, DateTime date) {
    ProductionOrderModel newTransaction = ProductionOrderModel(
      id: Random().nextDouble().toString(),
      value: value,
      date: date,
      title: order,
    );

    setState(() {
      productionOrders.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _removeTransaction(String id) {
    setState(() {
      productionOrders.removeWhere((element) => element.id == id);
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return ApointmentForm(_addTransaction);
      },
    );
  }

  Widget _getIconButton(IconData icon, Function() fn) {
    try {
      return Platform.isIOS
          ? GestureDetector(onTap: fn, child: Icon(icon))
          : IconButton(icon: Icon(icon), onPressed: fn);
    } catch (e) {
      return IconButton(icon: Icon(icon), onPressed: fn);
    }
  }

  Widget _getFloatingActionButton() {
    try {
      return Platform.isFuchsia
          ? Container()
          : FloatingActionButton(
              onPressed: () => _openTransactionFormModal(context),
              child: const Icon(Icons.add),
            );
    } catch (e) {
      return FloatingActionButton(
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(Icons.add),
      );
    }
  }

  IconData _getWidgetAdd() {
    try {
      return Platform.isIOS ? CupertinoIcons.add : Icons.add;
    } catch (e) {
      return Icons.add;
    }
  }

  IconData _getWidgetChart() {
    try {
      return Platform.isIOS
          ? _showChart
              ? CupertinoIcons.list_bullet
              : CupertinoIcons.chart_bar
          : _showChart
              ? Icons.list
              : Icons.bar_chart;
    } catch (e) {
      return _showChart ? Icons.list : Icons.bar_chart;
    }
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;

    final actions = [
      if (isLandscape)
        _getIconButton(_getWidgetChart(), () {
          setState(() {
            _showChart = !_showChart;
          });
        }),
      _getIconButton(
        _getWidgetAdd(),
        () => _openTransactionFormModal(context),
      ),
    ];

    final appBar = AppBar(
      title: const Text("Despesas pessoais"),
      actions: actions,
    );

    final cupertinoAppBar = CupertinoNavigationBar(
      middle: const Text('Despesas pessoais'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: actions,
      ),
    );

    var availableHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    if (availableHeight < 0) availableHeight = 0;

    final scafoldBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            /*if (isLandscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Exibir gráfico'),
                    Switch.adaptive(
                        value: _showChart,
                        onChanged: (value) {
                          setState(() {
                            _showChart = value;
                          });
                        }),
                  ],
                ),*/
            if (_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (!isLandscape ? 0.30 : 0.9),
                child: Chart(recentTransactions: _recentTransactions),
              ),
            if (!_showChart || !isLandscape)
              SizedBox(
                height: availableHeight * (!isLandscape ? 0.70 : 0.9),
                child: ProductionOrderList(productionOrders,
                    onRevome: _removeTransaction),
              ),
          ],
        ),
      ),
    );

    try {
      return Platform.isIOS
          ? CupertinoPageScaffold(
              navigationBar: cupertinoAppBar,
              child: scafoldBody,
            )
          : Scaffold(
              appBar: appBar,
              body: scafoldBody,
              floatingActionButton: _getFloatingActionButton(),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.miniEndFloat,
            );
    } catch (e) {
      return Scaffold(
        appBar: appBar,
        body: scafoldBody,
        floatingActionButton: _getFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      );
    }
  }
}
