package ${packageName}.common.feign;

import feign.Logger;
import feign.Request;
import feign.Retryer;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;

public class BasicFeignConfig {
    @Value("${"$"}{feign.connectTimeoutMillis}")
    private Integer connectTimeoutMillis;
    @Value("${"$"}{feign.readTimeoutMillis}")
    private Integer readTimeoutMillis;


    @Bean
    public Logger.Level feignLoggerLevel() {
        return Logger.Level.FULL;
    }

    @Bean
    public InfoFeignLoggerFactory infoFeignLoggerFactory() {
        return new InfoFeignLoggerFactory();
    }

    @Bean
    public Request.Options options() {
        return new Request.Options(connectTimeoutMillis, readTimeoutMillis);
    }

    @Bean
    public Retryer feignRetryer() {
        return new Retryer.Default();
    }
}
