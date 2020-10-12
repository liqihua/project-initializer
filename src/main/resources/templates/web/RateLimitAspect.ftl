package ${packageName}.web.config.aop;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import ${packageName}.common.basic.ResultVO;
import ${packageName}.common.constant.MsgCode;
import ${packageName}.web.config.aop.annotation.RateLimit;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.redisson.api.RScoredSortedSet;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;

import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.UUID;

@Aspect
@Component
public class RateLimitAspect {
    private static final Logger log = LoggerFactory.getLogger(RateLimitAspect.class);

    @Autowired
    private RedissonClient redissonClient;

    @Around("execution (* com..*.*Controller.*(..))")
    public Object controllerAround(ProceedingJoinPoint joinPoint) throws Throwable{
        MethodSignature sign = (MethodSignature) joinPoint.getSignature();
        Method method = sign.getMethod();
        RateLimit rateLimit = method.getAnnotation(RateLimit.class);
        if(rateLimit != null){
            Parameter[] params = method.getParameters();
            for(int i=0; i< params.length; i++) {
                Annotation[] annos = params[i].getDeclaredAnnotations();
                for(Annotation anno : annos){
                    if(anno instanceof RequestBody){
                        JSONObject requestBody = JSON.parseObject(JSON.toJSONString(joinPoint.getArgs()[i]));
                        if(requestBody != null){
                            String paramValue = requestBody.getString(rateLimit.paramName());
                            if(StrUtil.isNotBlank(paramValue)){
                                RScoredSortedSet<String> sortedSet = redissonClient.getScoredSortedSet(rateLimit.key() + paramValue);
                                long max = System.currentTimeMillis();
                                long min = System.currentTimeMillis() - (rateLimit.second() * 1000);
                                int count = sortedSet.count(min,true,max,true);
                                if(count > rateLimit.frequency()) {
                                    ResultVO vo = new ResultVO(MsgCode.BUSINESS_ERROR.getMsgCode(),"操作频繁，请稍候再试");
                                    return vo;
                                } else {
                                    sortedSet.add(max, max + "_" + UUID.randomUUID().toString());
                                    return joinPoint.proceed();
                                }
                            }
                        }
                    }
                }
            }
        }
        return joinPoint.proceed();
    }
}
