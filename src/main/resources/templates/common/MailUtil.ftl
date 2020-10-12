package ${packageName}.common.utils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Component;

@Component
public class MailUtil {
    private static final Logger logger = LoggerFactory.getLogger(MailUtil.class);



    @Value("${"$"}{mail.username}")
    private String username;
    @Value("${"$"}{mail.errorReciver}")
    private String errorReciver;



    @Autowired
    private JavaMailSender javaMailSender;



    /**
    * 发送异常告警邮件 - 异步
    * @param title
    * @param content
    */
    @Async
    public void sendErrorAsync(String title, String content) {
        sendError(title,content);
    }


    /**
    * 发送异常告警邮件
    * @param title
    * @param content
    */
    public void sendError(String title,String content) {
        send(username,errorReciver,title,content);
    }





    /**
    * 发送邮件
    * @param from
    * @param to
    * @param title
    * @param content
    */
    public void send(String from,String to,String title,String content) {
        logger.info("正在发送邮件...");
        logger.info("发送者：{}",from);
        logger.info("接收者：{}",to);
        logger.info("发送标题：{}",title);
        logger.info("发送内容：{}",content);
        SimpleMailMessage message = new SimpleMailMessage();
        message.setFrom(from);
        message.setTo(to.split(","));
        message.setSubject(title + " " + System.getProperty("env"));
        message.setText(content + "\n\n环境：" + System.getProperty("env"));
        javaMailSender.send(message);
        logger.info("邮件发送结束.");
    }

}
