package com.liqihua.project.maker.projectinitializer;

import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.FieldFill;
import com.baomidou.mybatisplus.generator.AutoGenerator;
import com.baomidou.mybatisplus.generator.config.*;
import com.baomidou.mybatisplus.generator.config.po.TableFill;
import com.baomidou.mybatisplus.generator.config.querys.MySqlQuery;
import com.baomidou.mybatisplus.generator.config.rules.NamingStrategy;
import com.baomidou.mybatisplus.generator.engine.FreemarkerTemplateEngine;
import org.junit.Test;

import java.util.ArrayList;
import java.util.List;

public class MybatisPlusCodeGenerator {


    /**
     * 代码生成
     */
    @Test
    public void make(){
        String url = "jdbc:mysql://localhost:3306/travel-saas-manager?useUnicode=true&characterEncoding=utf-8&zeroDateTimeBehavior=convertToNull&serverTimezone=Hongkong";
        String username = "root";
        String password = "1234";
        String dir = "F://code//";//代码生成在哪个位置，一般是项目工作目录以外的位置，以防错误覆盖


        String author = "liqihua";//作者
        String parent = "com.wehotel.travel.saas.manager";//父级路径
        String moduleName = "";//在哪个包下生成，代码最后会生成在 parent.moduleName 下，如：com.liqihua.project
        String tablePrefix = "";//表前缀，生成的java类名会去掉前缀
        String[] tables = new String[] {
                "sys_menu",
                "sys_perm",
                "sys_perm_menu",
                "sys_role",
                "sys_role_menu",
                "sys_role_perm",
                "sys_role_user",
                "sys_user",
        };//生成哪个表


        AutoGenerator mpg = new AutoGenerator();
        mpg.setTemplateEngine(new FreemarkerTemplateEngine());
        // 全局配置
        GlobalConfig gc = new GlobalConfig();
        gc.setOutputDir(dir);//代码生成在哪个位置，一般是项目工作目录以外的位置，以防错误覆盖
        gc.setFileOverride(true);
        gc.setActiveRecord(true);// 不需要ActiveRecord特性的请改为false
        gc.setEnableCache(false);// XML 二级缓存
        gc.setBaseResultMap(true);// XML ResultMap
        gc.setBaseColumnList(false);// XML columList
        gc.setAuthor(author);//设置作者
        gc.setSwagger2(true);//开启swagger注解


        /**
         * 设置各个层的类名
         */
        gc.setServiceName("%sService");
        gc.setControllerName("%sController");
        gc.setEntityName("%sEntity");
        gc.setMapperName("%sMapper");
        gc.setXmlName("%sMapper");

        // 数据源配置
        DataSourceConfig dsc = new DataSourceConfig();
        dsc.setDbType(DbType.MYSQL);
        dsc.setDriverName("com.mysql.cj.jdbc.Driver");
        dsc.setUsername(username);
        dsc.setPassword(password);
        dsc.setUrl(url);
        IDbQuery dbQuery = new MySqlQuery();
        dbQuery.fieldCustom();
        dsc.setDbQuery(dbQuery);

        // 策略配置
        StrategyConfig strategy = new StrategyConfig();
        /**
         * 自动填充字段
         */
        List<TableFill> tableFillList = new ArrayList<>();
        tableFillList.add(new TableFill("create_time",FieldFill.INSERT));
        tableFillList.add(new TableFill("update_time", FieldFill.INSERT_UPDATE));
        strategy.setTableFillList(tableFillList);
        strategy.setRestControllerStyle(true);//用@RestController代替@Controller
        strategy.setTablePrefix(new String[] { tablePrefix });// 表前缀
        strategy.setNaming(NamingStrategy.underline_to_camel);// 表名生成策略
        strategy.setInclude(tables);//生成哪个表的代码
        strategy.setEntityLombokModel(true);//开启lombok



        // 包配置
        PackageConfig pc = new PackageConfig();
        pc.setParent(parent);//父级路径
        pc.setModuleName(moduleName);////在哪个包下生成
        pc.setEntity("bean.entity");
        pc.setMapper("dao.mapper");
        pc.setXml("dao.mapper");
        pc.setService("service.service");
        pc.setServiceImpl("service.service.impl");
        pc.setController("web.controller");

        mpg.setGlobalConfig(gc);// 全局配置
        mpg.setDataSource(dsc);// 数据源配置
        mpg.setStrategy(strategy);// 策略配置
        mpg.setPackageInfo(pc);// 包配置

        // 执行生成
        mpg.execute();
    }
}
