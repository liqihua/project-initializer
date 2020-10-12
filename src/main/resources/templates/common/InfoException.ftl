package ${packageName}.common.exception;


import ${packageName}.common.constant.MsgCode;

/**
* 业务性质的异常类
*
*/
public class InfoException extends RuntimeException{
    private MsgCode msgCode;

    public InfoException(String message) {
        super(message);
    }

    public InfoException(MsgCode msgCode) {
        super(msgCode.getMessage());
        this.msgCode = msgCode;
    }

    public MsgCode getMsgCode() {
        return msgCode;
    }

    public void setMsgCode(MsgCode msgCode) {
        this.msgCode = msgCode;
    }
}
