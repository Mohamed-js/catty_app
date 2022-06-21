import 'package:PetsMating/models/businessLayer/baseRoute.dart';
import 'package:PetsMating/models/businessLayer/global.dart' as g;
import 'package:PetsMating/services/app_state.dart';
import 'package:PetsMating/widgets/bottomNavigationBarWidgetLight.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:select_form_field/select_form_field.dart';

class FilterOptionsScreen extends BaseRoute {
  FilterOptionsScreen({a, o}) : super(a: a, o: o, r: 'FilterOptionsScreen');
  @override
  _FilterOptionsScreenState createState() => _FilterOptionsScreenState();
}

class _FilterOptionsScreenState extends BaseRouteState {
  var _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController _noVaccinationNeeded = TextEditingController();
  TextEditingController _sameBreed = TextEditingController();

  dynamic appStaty;

  final List<Map<String, dynamic>> _breedOpts = [
    {
      'value': true,
      'label': "the same breed.",
      // 'icon': Icon(Icons.check),
      'textStyle': TextStyle(color: Color.fromARGB(255, 0, 25, 107)),
    },
    {
      'value': false,
      'label': "any of it's type.",
      // 'icon': Icon(Icons.close),
      'textStyle': TextStyle(color: Color.fromARGB(255, 0, 25, 107)),
    },
  ];

  final List<Map<String, dynamic>> _vaccinationOpts = [
    {
      'value': true,
      'label': "No.",
      // 'icon': Icon(Icons.check),
      'textStyle': TextStyle(color: Color.fromARGB(255, 0, 25, 107)),
    },
    {
      'value': false,
      'label': "Yes.",
      // 'icon': Icon(Icons.close),
      'textStyle': TextStyle(color: Color.fromARGB(255, 0, 25, 107)),
    },
  ];

  RangeValues _currentRangeValues;

  _FilterOptionsScreenState() : super();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: g.scaffoldBackgroundGradientColors,
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Scaffold(
          appBar: _appBarWidget(),
          resizeToAvoidBottomInset: false,
          key: _scaffoldKey,
          body: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppLocalizations.of(context).lbl_filter_options,
                      textAlign: TextAlign.left,
                      style: Theme.of(context).primaryTextTheme.headline1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        AppLocalizations.of(context)
                            .lbl_filter_options_subtitle,
                        textAlign: TextAlign.left,
                        style: Theme.of(context).primaryTextTheme.subtitle2,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Search only among",
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown, // or can be dialog
                      // initialValue:
                      //     appStaty.filter_options['same_breed'].toString(),
                      icon: Icon(Icons.search),
                      items: _breedOpts,
                      // onChanged: (val) => setState(
                      //     () => {_sameBreed = val == 'true' ? true : false}),
                      controller: _sameBreed,
                      onSaved: (val) => print(val),
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Text(
                        "Vaccination is required ?",
                        style: Theme.of(context).accentTextTheme.headline5,
                      ),
                    ),
                    SelectFormField(
                      type: SelectFormFieldType.dropdown, // or can be dialog
                      // initialValue: appStaty
                      //     .filter_options['no_vaccination_needed']
                      //     .toString(),
                      controller: _noVaccinationNeeded,
                      icon: Icon(Icons.vaccines),
                      items: _vaccinationOpts,
                      // onChanged: (val) => setState(() => {
                      //       _noVaccinationNeeded = val == 'true' ? true : false
                      //     }),
                      onSaved: (val) => print(val),
                      style: Theme.of(context).primaryTextTheme.subtitle2,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Age range: ",
                            style: Theme.of(context).accentTextTheme.headline5,
                          ),
                          Text(
                            "${_currentRangeValues.start.round().toString()} - ${_currentRangeValues.end.round().toString()}",
                            style: Theme.of(context).accentTextTheme.headline5,
                          ),
                        ],
                      ),
                    ),
                    RangeSlider(
                      values: _currentRangeValues,
                      max: 25,
                      divisions: 10,
                      labels: RangeLabels(
                        _currentRangeValues.start.round().toString(),
                        _currentRangeValues.end.round().toString(),
                      ),
                      onChanged: (RangeValues values) {
                        setState(() {
                          _currentRangeValues = values;
                        });
                      },
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.all(20),
                        height: 50,
                        width: 180,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: g.gradientColors,
                          ),
                        ),
                        child: TextButton(
                          onPressed: () async {
                            await appStaty.changeFilters(
                              _noVaccinationNeeded.text == "true"
                                  ? true
                                  : false,
                              _sameBreed.text == "true" ? true : false,
                              _currentRangeValues.start,
                              _currentRangeValues.end,
                            );

                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) =>
                                    BottomNavigationWidgetLight(
                                        currentIndex: 0)));
                          },
                          child: Text(
                            AppLocalizations.of(context).btn_apply_filters,
                            style: Theme.of(context)
                                .textButtonTheme
                                .style
                                .textStyle
                                .resolve({
                              MaterialState.pressed,
                            }),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    final appState = Provider.of<AppState>(context, listen: false);
    print(appState.filter_options);
    setState(() {
      appStaty = Provider.of<AppState>(context, listen: false);
      _noVaccinationNeeded.text =
          appState.filter_options['no_vaccination_needed'].toString();
      _sameBreed.text = appState.filter_options['same_breed'].toString();
      _currentRangeValues = RangeValues(
          appState.filter_options['min_age'].toDouble(),
          appState.filter_options['max_age'].toDouble());
    });
  }

  PreferredSizeWidget _appBarWidget() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            child: ListTile(
              leading: IconButton(
                icon: Icon(FontAwesomeIcons.longArrowAltLeft),
                color: Theme.of(context).iconTheme.color,
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // trailing: Icon(
              //   Icons.refresh,
              //   color: Theme.of(context).iconTheme.color,
              // ),
            ),
          ),
        ],
      ),
    );
  }
}
