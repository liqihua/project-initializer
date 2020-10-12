<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
         xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <parent>
        <artifactId>${projectName}</artifactId>
        <groupId>${packageName}</groupId>
        <version>1.0</version>
    </parent>
    <modelVersion>4.0.0</modelVersion>

    <artifactId>${projectName}-service</artifactId>

    <dependencies>
        <dependency>
            <groupId>${packageName}</groupId>
            <artifactId>${projectName}-dao</artifactId>
            <version>1.0</version>
        </dependency>
        <dependency>
            <groupId>${packageName}</groupId>
            <artifactId>${projectName}-common</artifactId>
            <version>1.0</version>
        </dependency>
    </dependencies>



</project>