package ${packageName}.common.feign;

import feign.Logger;

public class InfoFeignLogger extends Logger {
    private final org.slf4j.Logger logger;

    InfoFeignLogger(org.slf4j.Logger logger) {
        this.logger = logger;
    }

    @Override
    protected void log(String configKey, String format, Object... args) {
        if (this.logger.isInfoEnabled()) {
            this.logger.info(String.format(methodTag(configKey) + format, args));
        }
    }
}
