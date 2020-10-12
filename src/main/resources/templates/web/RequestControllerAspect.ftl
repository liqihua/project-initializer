package ${packageName}.web.config.aop;

import cn.hutool.core.util.StrUtil;
import com.alibaba.fastjson.JSON;
import ${packageName}.common.basic.ResultVO;
import ${packageName}.common.constant.MsgCode;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import java.lang.annotation.Annotation;
import java.lang.reflect.Method;
import java.lang.reflect.Parameter;
import java.util.Enumeration;

/**
 * 监控controller的请求
 * 对@RequestParam 为 true 的参数进行值校验
 * @author liqihua
 * @since 2018/11/19
 */
@Aspect
@Component
public class RequestControllerAspect {

    private static final Logger log = LoggerFactory.getLogger(RequestControllerAspect.class);

    /**
     * controller层aop处理
     * @param joinPoint
     * @return
     * @throws Throwable
     */
	@Around("execution (* com..*.*Controller.*(..))")
    public Object controllerAround(ProceedingJoinPoint joinPoint) throws Throwable{
        /**
         * 请求日志打印
         */
        String classAndMethodName = null;
        //获取当前请求属性集
        ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
        //获取请求
        HttpServletRequest request = sra.getRequest();
        //获取请求地址
        String requestUrl = request.getRequestURL().toString();
        //记录请求地址
        log.info("请求路径：---> {}", requestUrl);
        //记录请求开始时间
        long startTime = System.currentTimeMillis();
        Class<?> target = joinPoint.getTarget().getClass();
        MethodSignature methodSignature = (MethodSignature) joinPoint.getSignature();
        Class<?>[] paramTypes = methodSignature.getParameterTypes();
        String methodName = joinPoint.getSignature().getName();
        Method currentMethod = target.getMethod(methodName, paramTypes);
        classAndMethodName = target.getName() + "." + currentMethod.getName() + "()";
        log.info("执行函数：---> {}", classAndMethodName);
        /**
         * 打印key/value参数
         */
        Enumeration<String> enumeration = request.getParameterNames();
        while (enumeration.hasMoreElements()){
            String param = enumeration.nextElement();
            log.info("key/value参数：---> {}", param+" : "+request.getParameter(param));
        }

        /**
         * 打印@RequestBody参数、RequestParam注解参数非空参数拦截
         */
        Parameter[] params = currentMethod.getParameters();
        if(params != null && params.length > 0){
            Object[] args = joinPoint.getArgs();
            for(int i=0; i< params.length; i++){
                Annotation[] annos = params[i].getDeclaredAnnotations();
                if(annos != null && annos.length > 0){
                    for(Annotation anno : annos){
                        if(anno instanceof RequestBody){
                            log.info("@RequestBody参数：---> {}",JSON.toJSONString(args[i]));
                        }
                        if(anno instanceof RequestParam){
                            RequestParam annoObj = (RequestParam)anno;
                            if(annoObj.required()){
                                if(args[i] == null || (args[i] instanceof String && StrUtil.isBlank(args[i]+""))){
                                    String paramName = methodSignature.getParameterNames()[i];
                                    log.info(paramName+":"+args[i]);
                                    log.info("参数 "+paramName+" 要求非空，参数值："+(args[i]==null?"":args[i].toString()));
                                    ResultVO result = new ResultVO(MsgCode.PARAM_IS_NULL.getMsgCode(),MsgCode.PARAM_IS_NULL.getMessage() + "->" + paramName);
                                    return result;
                                }
                            }
                        }
                    }
                }
            }
        }
        Object object = joinPoint.proceed();
        log.info("返回结果: ---> {}", object==null?"null": JSON.toJSONString(object));
        long endTime = System.currentTimeMillis();
        log.info("响应时间：---> {} 毫秒", endTime-startTime);
        return object;
    }



}
