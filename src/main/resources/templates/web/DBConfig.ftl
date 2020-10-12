package ${packageName}.web.config.db;

import com.alibaba.druid.pool.DruidDataSource;
import com.alibaba.druid.support.http.StatViewServlet;
import com.alibaba.druid.support.http.WebStatFilter;
import com.baomidou.mybatisplus.annotation.DbType;
import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.core.config.GlobalConfig;
import com.baomidou.mybatisplus.extension.plugins.PaginationInterceptor;
import com.baomidou.mybatisplus.extension.plugins.PerformanceInterceptor;
import com.baomidou.mybatisplus.extension.spring.MybatisSqlSessionFactoryBean;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.session.SqlSessionFactory;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.FilterRegistrationBean;
import org.springframework.boot.web.servlet.ServletRegistrationBean;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.core.io.support.PathMatchingResourcePatternResolver;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;

import javax.sql.DataSource;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@Configuration
@MapperScan(basePackages = {"${packageName}.**.mapper*"},sqlSessionFactoryRef = "sqlSessionFactory")
public class DBConfig {
    /**
     * mapper的xml位置
     */
    public static final String[] DATASOURCE_MAPPER_LOACTIONS = {"classpath*:mapper/**/*.xml"};


    @Value("${"$"}{jdbc.url}")
    private String url;
    @Value("${"$"}{jdbc.username}")
    private String username;
    @Value("${"$"}{jdbc.password}")
    private String password;
    @Value("${"$"}{jdbc.driverClassName}")
    private String driverClass;
    @Value("${"$"}{jdbc.minIdle}")
    private Integer minIdle;
    @Value("${"$"}{jdbc.timeBetweenEvictionRunsMillis}")
    private Integer timeBetweenEvictionRunsMillis;
    @Value("${"$"}{jdbc.minEvictableIdleTimeMillis}")
    private Integer minEvictableIdleTimeMillis;
    @Value("${"$"}{jdbc.keepAlive}")
    private Boolean keepAlive;
    @Value("${"$"}{jdbc.removeAbandoned}")
    private Boolean removeAbandoned;
    @Value("${"$"}{jdbc.removeAbandonedTimeout}")
    private Integer removeAbandonedTimeout;
    @Value("${"$"}{jdbc.maxWait}")
    private Integer maxWait;


    @Bean
    public DataSource dataSource() {
        DruidDataSource dataSource = new DruidDataSource();
        dataSource.setDriverClassName(driverClass);
        dataSource.setUrl(url);
        dataSource.setUsername(username);
        dataSource.setPassword(password);
        dataSource.setMinIdle(minIdle);
        dataSource.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);//每x秒运行一次空闲连接回收器，毫秒
        dataSource.setMinEvictableIdleTimeMillis(minEvictableIdleTimeMillis);//空闲而不被驱逐的最长时间，毫秒
        dataSource.setKeepAlive(keepAlive);//true则保持minIdle数量的最少连接数
        dataSource.setRemoveAbandoned(removeAbandoned);//连接被借出removeAbandonedTimeout秒后是否强制回收，true：是，false：否，默认false
        dataSource.setRemoveAbandonedTimeout(removeAbandonedTimeout);//连接被借出的最大时间，秒
        dataSource.setMaxWait(maxWait);//获取连接时最大等待时间，毫秒
        dataSource.setUseUnfairLock(true);//设置获取连接使用非公平锁，默认公平锁，影响并发
        try {
            dataSource.setFilters("stat");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return dataSource;
    }


    @Bean
    public DataSourceTransactionManager transactionManagerManager(DataSource dataSource) {
        return new DataSourceTransactionManager(dataSource);
    }

    @Bean(name = "sqlSessionFactory")
    public SqlSessionFactory sqlSessionFactory(DataSource dataSource) throws Exception {
        MybatisSqlSessionFactoryBean bean = new MybatisSqlSessionFactoryBean();
        bean.setDataSource(dataSource);
        //设置mapper的xml路径
        Resource[] resources = getMapperResource();
        if(resources != null){
            bean.setMapperLocations(resources);
        }
        //分页插件
        PaginationInterceptor pageInterceptor = new PaginationInterceptor();
        pageInterceptor.setDialectType("mysql");
        //SQL 执行性能分析插件
        PerformanceInterceptor performanceInterceptor = new PerformanceInterceptor();
        performanceInterceptor.setMaxTime(10000);
        performanceInterceptor.setFormat(true);
        Interceptor[] interceptors = {pageInterceptor,performanceInterceptor};
        bean.setPlugins(interceptors);

        GlobalConfig config = new GlobalConfig();
        //插入数据字段预处理
        config.setMetaObjectHandler(new MyBatisPlusObjectHandler());
        GlobalConfig.DbConfig dbConfig = new GlobalConfig.DbConfig();
        //主键策略
        dbConfig.setIdType(IdType.AUTO);
        dbConfig.setDbType(DbType.MYSQL);
        config.setDbConfig(dbConfig);
        bean.setGlobalConfig(config);
        //字段下划线映射bean以驼峰模式
        bean.getObject().getConfiguration().setMapUnderscoreToCamelCase(true);
        return bean.getObject();
    }


    //注册druid过滤器
    @Bean
    public FilterRegistrationBean filterRegistrationBean() {
        FilterRegistrationBean bean = new FilterRegistrationBean();
        bean.setFilter(new WebStatFilter());
        bean.addUrlPatterns("/*");
        bean.addInitParameter("exclusions", "*.html,*.js,*.gif,*.jpg,*.png,*.css,*.ico,/druid/*");
        bean.addInitParameter("profileEnable", "true");
        bean.addInitParameter("principalCookieName", "USER_COOKIE");
        bean.addInitParameter("principalSessionName", "USER_SESSION");
        return bean;
    }

    //注册druid的统计Servlet
    @Bean
    public ServletRegistrationBean druidServlet() {
        ServletRegistrationBean reg = new ServletRegistrationBean();
        reg.setServlet(new StatViewServlet());
        reg.addUrlMappings("/druid/*");
        return reg;
    }


    /**
     * mapper的xml路径处理
     * 把String[]转Resource[]
     * @return
     */
    protected Resource[] getMapperResource(){
        try {
            if(DATASOURCE_MAPPER_LOACTIONS != null && DATASOURCE_MAPPER_LOACTIONS.length > 0) {
                List<Resource> resourceList = new ArrayList<>();
                for (String location : DATASOURCE_MAPPER_LOACTIONS) {
                    Resource[] resourceArr = new Resource[0];

                    resourceArr = new PathMatchingResourcePatternResolver().getResources(location);

                    for (Resource resource : resourceArr) {
                        resourceList.add(resource);
                    }
                }
                Resource[] resources = new Resource[resourceList.size()];
                for (int i = 0; i < resourceList.size(); i++) {
                    resources[i] = resourceList.get(i);
                }
                return resources;
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }


}
