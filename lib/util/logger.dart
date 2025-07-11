import 'package:flutter_base_logger/net/net_entity.dart';
import 'package:flutter_base_logger/net/net_type.dart';
import 'package:flutter_base_logger/print/print_entity.dart';
import 'package:flutter_base_logger/print/print_type.dart';
import 'package:flutter_base_logger/util/config.dart';
import 'package:flutter_base_logger/util/helper.dart';

class Logger {
  const Logger._();

  static bool get enabled => _Logger.enabled;

  static Config get config => _Logger.config;

  /// 设置日志是否可用
  ///
  /// [hasEnabled] 是否可以用
  static void setLogEnabled(bool hasEnabled) => _Logger.setLogEnabled(hasEnabled);

  /// 设置日志配置信息
  ///
  /// [hasReverse] 日志记录反转
  /// [hasPrintNet] 是否控制台输出网络接口日志
  /// [hasPrintLog] 是否控制台输出日志
  /// [hasWriteLog] 是否写入日志记录
  /// [hasWriteNet] 是否写入网络接口日志
  /// [maxLimit] 记录条数限制，默认100条
  static void setLogConfig({
    bool? hasReverse,
    bool? hasPrintNet,
    bool? hasPrintLog,
    bool? hasWriteLog,
    bool? hasWriteNet,
    int? maxLimit,
  }) => _Logger.setLogConfig(
    hasReverse: hasReverse,
    hasPrintNet: hasPrintNet,
    hasPrintLog: hasPrintLog,
    hasWriteLog: hasWriteLog,
    hasWriteNet: hasWriteNet,
    maxLimit: maxLimit,
  );

  /// 清空所有日志
  static void clear() {
    _Logger.clear();
  }

  /// info信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void info(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.info(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 调试信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void debug(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.debug(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 警告信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void warn(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.warn(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 错误信息
  ///
  /// [message] 内容
  /// [title] 标题
  /// [hasPrintLog] 是否打印日志
  /// [hasWriteLog] 是否写入日志
  static void error(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    _Logger.error(message, title: title, hasPrintLog: hasPrintLog, hasWriteLog: hasWriteLog);
  }

  /// 接口日志
  ///
  /// [api] api名称
  /// [url] 请求路径
  /// [method] 请求方法
  /// [headers] 请求头
  /// [parameters] 请求参数
  /// [responseBody] 响应数据
  /// [spendTime] 花费时间
  /// [statusCode] 请求状态码
  /// [showDetail] 是否展开
  /// [hasPrintNet] 是否打印日志
  /// [hasWriteNet] 是否写入日志
  static void net({
    required String api,
    String url = '',
    String method = '',
    Object headers = '',
    Object parameters = '',
    Object responseBody = '',
    int spendTime = 0,
    int statusCode = 100,
    bool showDetail = false,
    bool? hasPrintNet = true,
    bool? hasWriteNet = true,
  }) {
    _Logger.net(
      api: api,
      url: url,
      method: method,
      headers: headers,
      parameters: parameters,
      responseBody: responseBody,
      spendTime: spendTime,
      statusCode: statusCode,
      showDetail: showDetail,
      hasPrintNet: hasPrintNet,
      hasWriteNet: hasWriteNet,
    );
  }
}

class _Logger {
  const _Logger._();

  static bool enabled = true;
  static Config config = const Config(
    hasReverse: true,
    hasPrintLog: true,
    hasWriteLog: true,
    hasPrintNet: true,
    hasWriteNet: true,
    maxLimit: 100,
  );

  /// 设置日志是否可用
  static void setLogEnabled(bool hasEnabled) {
    enabled = hasEnabled;
  }

  /// 设置日志配置信息
  static void setLogConfig({
    /// 日志记录反转
    bool? hasReverse,
    bool? hasPrintNet,
    bool? hasPrintLog,
    bool? hasWriteLog,
    bool? hasWriteNet,
    int? maxLimit,
  }) {
    config = config.copyWith(
      hasReverse: hasReverse,
      hasPrintNet: hasPrintNet,
      hasPrintLog: hasPrintLog,
      hasWriteLog: hasWriteLog,
      hasWriteNet: hasWriteNet,
      maxLimit: maxLimit,
    );
  }

  /// 清空所有日志
  static void clear() {
    PrintEntity.clear();
    NetEntity.clear();
  }

  static void debug(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (Logger.enabled) {
      PrintEntity.add(
        type: PrintType.debug,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void info(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (Logger.enabled) {
      PrintEntity.add(
        type: PrintType.info,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void warn(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (Logger.enabled) {
      PrintEntity.add(
        type: PrintType.warn,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void error(Object message, {String title = '', bool hasPrintLog = true, hasWriteLog = true}) {
    if (Logger.enabled) {
      PrintEntity.add(
        type: PrintType.error,
        content: message,
        title: title,
        hasPrintLog: hasPrintLog,
        hasWriteLog: hasWriteLog,
      );
    }
  }

  static void net({
    required String api,
    String url = '',
    String method = '',
    Object headers = '',
    Object parameters = '',
    Object responseBody = '',
    int spendTime = 0,
    int statusCode = 100,
    bool showDetail = false,
    bool? hasPrintNet = true,
    bool? hasWriteNet = true,
  }) {
    if (Logger.enabled) {
      NetEntity.net(
        type: NetType.http,
        api: api,
        url: url,
        method: method,
        headers: Helper.convertJsonString(headers),
        parameters: Helper.convertJsonString(parameters),
        responseBody: Helper.convertJsonString(responseBody),
        spendTime: spendTime,
        statusCode: statusCode,
        showDetail: showDetail,
        hasPrintNet: hasPrintNet,
        hasWriteNet: hasWriteNet,
      );
    }
  }
}
