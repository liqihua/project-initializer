package ${packageName}.web.config.aop.annotation;

import java.lang.annotation.*;

/**
 * 限流注解
 * @author lqh
 * @date 2019/5/14
 */
@Documented
@Inherited
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
public @interface RateLimit {

    /**
     * second 秒内访问频率不超过 frequency 次 默认 second = 5
     * @return
     */
    int second() default 5;

    /**
     * second 秒内访问频率不超过 frequency 次 默认 frequency = 10
     * @return
     */
    int frequency() default 10;

    /**
     * 限流通道名称
     * redis SoretedSet 的 key = keyName + fieldName.value()
     * @return
     */
    String key();

    /**
     * 参数字段名称
     * redis SoretedSet 的 key = keyName + fieldName.value()
     * @return
     */
    String paramName();
}
