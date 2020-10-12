<?xml version="1.0" encoding="UTF-8"?>
<configuration status="ERROR" monitorInterval="300">
    <properties>
        <!-- 详细输出 -->
        <property name="PATTERN_FULL">%d{yyyy-MM-dd HH:mm:ss.SSS} |-%-5level [%thread] %c [%L] -| %msg%n</property>
        <!-- 精简输出 -->
        <property name="PATTERN">%d{yyyy-MM-dd HH:mm:ss.SSS} |-%-5level %c -| %msg%n</property>
        <property name="DIR">logs</property>
    </properties>

    <appenders>
        <console name="console" target="SYSTEM_OUT">
            <PatternLayout pattern="${"$"}{PATTERN}"/>
        </console>

        <File name="running" fileName="${"$"}{DIR}/running.log" append="false">
            <PatternLayout pattern="${"$"}{PATTERN}"/>
        </File>

        <RollingFile name="rolling_file_debug" fileName="${"$"}{DIR}/debug.log" filePattern="${"$"}{DIR}/${"$"}${"$"}{date:yyyy-MM}/debug-%d{yyyy-MM-dd}-%i.log">
            <ThresholdFilter level="debug" onMatch="ACCEPT" onMismatch="DENY"/>
            <PatternLayout pattern="${"$"}{PATTERN}"/>
            <TimeBasedTriggeringPolicy modulate="true" interval="1"/>
        </RollingFile>
        <RollingFile name="rolling_file_info" fileName="${"$"}{DIR}/info.log" filePattern="${"$"}{DIR}/${"$"}${"$"}{date:yyyy-MM}/info-%d{yyyy-MM-dd}-%i.log">
            <ThresholdFilter level="info" onMatch="ACCEPT" onMismatch="DENY"/>
            <PatternLayout pattern="${"$"}{PATTERN}"/>
            <TimeBasedTriggeringPolicy modulate="true" interval="1"/>
        </RollingFile>
        <RollingFile name="rolling_file_warn" fileName="${"$"}{DIR}/warn.log" filePattern="${"$"}{DIR}/${"$"}${"$"}{date:yyyy-MM}/warn-%d{yyyy-MM-dd}-%i.log">
            <ThresholdFilter level="warn" onMatch="ACCEPT" onMismatch="DENY"/>
            <PatternLayout pattern="${"$"}{PATTERN}"/>
            <TimeBasedTriggeringPolicy modulate="true" interval="1"/>
        </RollingFile>
        <RollingFile name="rolling_file_error" fileName="${"$"}{DIR}/error.log" filePattern="${"$"}{DIR}/${"$"}${"$"}{date:yyyy-MM}/error-%d{yyyy-MM-dd}-%i.log">
            <ThresholdFilter level="error" onMatch="ACCEPT" onMismatch="DENY"/>
            <PatternLayout pattern="${"$"}{PATTERN}"/>
            <TimeBasedTriggeringPolicy modulate="true" interval="1"/>
        </RollingFile>

    </appenders>

    <loggers>
        <root level="DEBUG">
            <appender-ref ref="console"/>
            <appender-ref ref="running"/>
            <appender-ref ref="rolling_file_debug"/>
            <appender-ref ref="rolling_file_info"/>
            <appender-ref ref="rolling_file_warn"/>
            <appender-ref ref="rolling_file_error"/>
        </root>
        <!-- 去掉eureka心跳debug信息 -->
        <logger name="com.netflix.discovery" level="INFO"/>
        <logger name="org.apache.http" level="INFO"/>
        <!-- 去掉apollo心跳debug信息 -->
        <logger name="com.ctrip.framework.apollo.internals" level="INFO"/>
        <logger name="com.github" level="INFO"/>
        <!-- 去掉kafka的consumer心跳信息 -->
        <logger name="org.apache.kafka" level="INFO"/>
        <logger name="org.springframework.kafka" level="INFO"/>
        <!-- 去掉active心跳信息 -->
        <logger name="org.apache.activemq.ActiveMQSession" level="INFO"/>
        <logger name="org.apache.activemq.transport" level="INFO"/>
        <!-- 定时器 -->
        <logger name="org.springframework.scheduling" level="INFO"/>
    </loggers>
</configuration>