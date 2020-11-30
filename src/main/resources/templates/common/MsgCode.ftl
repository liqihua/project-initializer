package ${packageName}.common.constant;


/**
* web响应状态码
*
*/
public class MsgCode {
    private Integer code;
    private String message;

    public static final int BASE_SUCCESS_CODE = 100;
    public static final String BASE_SUCCESS_MSG = "操作成功";

    public static final MsgCode SUCCESS = new MsgCode(BASE_SUCCESS_CODE, BASE_SUCCESS_MSG);
    public static final MsgCode FAILURE = new MsgCode(40000, "操作失败");

    public static final MsgCode PARAM_ERROR = new MsgCode(40001, "参数有误");
    public static final MsgCode PARAM_IS_NULL = new MsgCode(40002, "参数不能为空");
    public static final MsgCode PARAM_TYPE_ERROR = new MsgCode(40003, "参数类型有误");
    public static final MsgCode PARAM_DATE_ERROR = new MsgCode(40004, "日期参数有误");
    public static final MsgCode PARAM_NUMBER_ERROR = new MsgCode(40005, "数字参数有误");
    public static final MsgCode PARAM_DOUBLE_ERROR = new MsgCode(40006, "小数参数有误");
    public static final MsgCode PARAM_JSON_ERROR = new MsgCode(40007, "json参数格式或类型有误");
    public static final MsgCode PARAM_FORMAT_ERROR = new MsgCode(40008, "参数格式有误");


    public static final MsgCode BUSINESS_ERROR = new MsgCode(41000, "业务性异常");


    public MsgCode() {
    }

    public MsgCode(Integer code, String message) {
        this.code = code;
        this.message = message;
    }

    public Integer getCode() {
        return code;
    }

    public void setCode(Integer code) {
        this.code = code;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public String getMessage(String msgCode) {
        return message;
    }

}
