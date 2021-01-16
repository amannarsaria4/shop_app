import 'package:flutter/material.dart';

import '../widgets/drawerSlide.dart';

class FiltersScreen extends StatefulWidget {
  static const routeName = "/filter-screen";
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FiltersScreen(this.currentFilters, this.saveFilters);
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FiltersScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  initState() {
    _glutenFree = widget.currentFilters["gluten"];
    _lactoseFree = widget.currentFilters["lactose"];
    _vegetarian = widget.currentFilters["vegetarian"];
    _vegan = widget.currentFilters["vegan"];
    super.initState();
  }

  Widget _buildSwitchTile(
    String title,
    bool value,
    Function changeState,
    String subtitle,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: changeState,
      subtitle: Text(subtitle),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Your Filter"),
          actions: [
            IconButton(
              icon: Icon(Icons.save),
              onPressed: () {
                final selectedFilters = {
                  "gluten": _glutenFree,
                  "lactose": _lactoseFree,
                  "vegetarian": _vegetarian,
                  "vegan": _vegan,
                };
                widget.saveFilters(selectedFilters);
              },
            )
          ],
        ),
        drawer: DrawerSlide(),
        body: Column(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child: Text(
                "Adjust Your Meal Selection",
                style: Theme.of(context).textTheme.title,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  _buildSwitchTile("Gluten-Free", _glutenFree, (newValue) {
                    setState(() {
                      _glutenFree = newValue;
                    });
                  }, "Only show gluten free meals."),
                  _buildSwitchTile("Lactose-Free", _lactoseFree, (newValue) {
                    setState(() {
                      _lactoseFree = newValue;
                    });
                  }, "Only show lactose free meals."),
                  _buildSwitchTile("Vegetarian", _vegetarian, (newValue) {
                    setState(() {
                      _vegetarian = newValue;
                    });
                  }, "Only show gluten vegetarian meals."),
                  _buildSwitchTile("Vegan", _vegan, (newValue) {
                    setState(() {
                      _vegan = newValue;
                    });
                  }, "Only show vegan meals."),
                ],
              ),
            )
          ],
        ));
  }
}
