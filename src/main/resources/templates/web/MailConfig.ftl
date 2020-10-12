package ${packageName}.web.config.mail;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

import java.util.Properties;

@Configuration
public class MailConfig {

    @Value("${"$"}{mail.host}")
    private String host;
    @Value("${"$"}{mail.port}")
    private Integer port;
    @Value("${"$"}{mail.username}")
    private String username;
    @Value("${"$"}{mail.password}")
    private String password;
    @Value("${"$"}{mail.default-encoding}")
    private String defaultEncoding;


    @Value("${"$"}{mail.properties.mail.smtp.auth}")
    private String smtpAuth;
    @Value("${"$"}{mail.properties.mail.smtp.starttls.enable}")
    private String smtpStarttlsEnable;
    @Value("${"$"}{mail.properties.mail.smtp.starttls.required}")
    private String smtpStarttlsRequired;
    @Value("${"$"}{mail.properties.mail.smtp.ssl.enable}")
    private String smtpSSLEnable;



    @Bean
    public JavaMailSender javaMailSender() {
        JavaMailSenderImpl config = new JavaMailSenderImpl();
        config.setHost(host);
        config.setPort(port);
        config.setUsername(username);
        config.setPassword(password);
        config.setDefaultEncoding(defaultEncoding);
        Properties prop = new Properties();
        prop.setProperty("mail.smtp.auth",smtpAuth);
        prop.setProperty("mail.smtp.starttls.enable",smtpStarttlsEnable);
        prop.setProperty("mail.smtp.starttls.required",smtpStarttlsRequired);
        prop.setProperty("mail.smtp.ssl.enable",smtpSSLEnable);
        config.setJavaMailProperties(prop);
        return config;
    }



}
