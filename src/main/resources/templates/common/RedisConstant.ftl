package ${packageName}.common.constant;

/**
* redis 常量
*/
public interface RedisConstant {
    /**
    * 锁的最大持锁时间
    */
    int LOCK_MAX_LIVE_TIME = 30;
    /**
    * 获取锁的最大等待时间
    */
    int LOCK_WAIT_TIME = 30;


    /**
    * 项目前缀
    */
    String PROJECT_PREFFIX = "${projectName ? capitalize}:";

}
