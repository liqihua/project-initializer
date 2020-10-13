package ${packageName}.web.config.thread;

import ${packageName}.common.utils.MailUtil;
import ${packageName}.common.utils.SpringContextHolder;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.aop.interceptor.SimpleAsyncUncaughtExceptionHandler;

import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Method;

public class AsyncExceptionHandler extends SimpleAsyncUncaughtExceptionHandler {
    private static final Logger logger = LoggerFactory.getLogger(AsyncExceptionHandler.class);

    private static MailUtil mailUtil = null;

    @Override
    public void handleUncaughtException(Throwable ex, Method method, Object... params) {
        if(mailUtil == null) {
            mailUtil = SpringContextHolder.getBean(MailUtil.class);
        }
        StringWriter sw = new StringWriter();
        ex.printStackTrace(new PrintWriter(sw,true));
        logger.error(ex.getClass().getName() + " " + sw.toString(), this.getClass());
        mailUtil.sendErrorAsync("${projectName}服务发生异常", this.getClass().getCanonicalName() + "\n" + sw.toString());
    }
}
