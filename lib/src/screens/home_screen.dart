import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_mcq_checker/src/blocs/module_bloc.dart';
import 'package:flutter_mcq_checker/src/models/module.dart';
import 'package:flutter_mcq_checker/src/widgets/add_module_bottom_sheet.dart';
import 'package:flutter_mcq_checker/src/widgets/module_list_tile.dart';

class HomeScreen extends StatefulWidget {
  final ModuleBloc bloc;

  HomeScreen({this.bloc});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  VoidCallback _bottomSheetCallback;
  PersistentBottomSheetController _controller;

  @override
  void initState() {
    super.initState();
    _bottomSheetCallback = _showBottomSheet;
  }

  void _showBottomSheet() {
    setState(() {
      _bottomSheetCallback = null;
    });

    _controller =
        _scaffoldKey.currentState.showBottomSheet((BuildContext context) {
      return AddModule(scaffold: _scaffoldKey, context: context);
    });

    _controller.closed.whenComplete(() {
      if (mounted) {
        setState(() {
          _bottomSheetCallback = _showBottomSheet;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xE6344955),
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('MCQ - Checker'),
        backgroundColor: Color(0xff232f34),
      ),
      body: addModule(false),
    );
  }

  Widget buildBody() {
    return StreamBuilder(
      stream: widget.bloc.modules,
      builder: (BuildContext context, AsyncSnapshot<List<Module>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: addModule(false),
          );
        }
        return ListView.builder(
          padding: EdgeInsets.all(8.0),
          itemCount: snapshot.data.length,
          itemBuilder: (BuildContext context, int index) {
            return ModuleListTile(module: snapshot.data[index]);
          },
        );
      },
    );
  }

  Widget addModule(bool isSmall) {
    return Container(
      height: isSmall ? 80.0 : 250.0,
      width: isSmall ? 80.0 : 250.0,
      decoration: BoxDecoration(
        color: isSmall ? Colors.green[400] : Color(0xCC232f34),
        borderRadius: BorderRadius.circular(isSmall ? 40.0 : 125.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(isSmall ? 40.0 : 125.0),
          splashColor: Color(0xff344955),
          child: Icon(
            CupertinoIcons.add,
            size: isSmall ? 50.0 : 100.0,
            color: isSmall ? Colors.white70 : Colors.white30,
          ),
          onTap: _bottomSheetCallback,
          // () {
          //   _scaffoldKey.currentState.showBottomSheet(
          //     (BuildContext context) => AddModule(
          //           scaffold: _scaffoldKey,
          //           context: context,
          //         ),
          //   );
          // },
        ),
      ),
    );
  }
}
