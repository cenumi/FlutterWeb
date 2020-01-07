import 'package:flutter/material.dart';
import 'package:flutter_web/ui/data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingDialog extends StatefulWidget {
  final ColorConfig config;

  const SettingDialog({Key key, this.config}) : super(key: key);

  @override
  _SettingDialogState createState() => _SettingDialogState();
}

class _SettingDialogState extends State<SettingDialog> {
  final _key = GlobalKey<FormState>();
  ColorConfig _conf;

  @override
  void initState() {
    _conf = widget.config;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('配置修改'),
      content: Form(
          key: _key,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: '背景颜色(ARGB)',isDense: true),
                initialValue: _conf.backgroundColor.toRadixString(16),
                validator: (s) => RegExp(r'[a-fA-F0-9]{1,8}').hasMatch(s) ? null : '请填写十六进制ARGB颜色值',
                onSaved: (s) => _conf.backgroundColor = int.parse('0x$s'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '进度条背景色(ARGB)',isDense: true),
                initialValue: _conf.itemBackgroundColor.toRadixString(16),
                validator: (s) => RegExp(r'[a-fA-F0-9]{1,8}').hasMatch(s) ? null : '请填写十六进制ARGB颜色值',
                onSaved: (s) => _conf.itemBackgroundColor = int.parse('0x$s'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '进度条前景色(ARGB)',isDense: true),
                initialValue: _conf.itemForegroundColor.toRadixString(16),
                validator: (s) => RegExp(r'[a-fA-F0-9]{1,8}').hasMatch(s) ? null : '请填写十六进制ARGB颜色值',
                onSaved: (s) => _conf.itemForegroundColor = int.parse('0x$s'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '文字颜色(ARGB)',isDense: true),
                initialValue: _conf.textColor.toRadixString(16),
                validator: (s) => RegExp(r'[a-fA-F0-9]{1,8}').hasMatch(s) ? null : '请填写十六进制ARGB颜色值',
                onSaved: (s) => _conf.textColor = int.parse('0x$s'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '进度条文字颜色(ARGB)',isDense: true),
                initialValue: _conf.itemTextColor.toRadixString(16),
                validator: (s) => RegExp(r'[a-fA-F0-9]{1,8}').hasMatch(s) ? null : '请填写十六进制ARGB颜色值',
                onSaved: (s) => _conf.itemTextColor = int.parse('0x$s'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: '进度条边框弧度',isDense: true),
                initialValue: _conf.radius.toString(),
                validator: (s) => RegExp(r'^\d+(.\d+)?$').hasMatch(s) ? null : '请填写数字',
                onSaved: (s) => _conf.radius = double.parse('$s'),
              ),
            ],
          )),
      actions: <Widget>[
        FlatButton(onPressed: () => Navigator.pop(context), child: Text('取消')),
        FlatButton(onPressed: _save, child: Text('保存')),
      ],
    );
  }



  _save() async {
    final fs = _key.currentState;
    final sp = await SharedPreferences.getInstance();
    if (fs.validate()) {
      fs.save();
      await sp.setString('config', _conf.toString());
      Navigator.pop(context, _conf);
    }
  }
}
