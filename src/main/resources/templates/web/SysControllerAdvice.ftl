package ${packageName}.web.config.advice;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.exc.InvalidFormatException;
import com.fasterxml.jackson.databind.exc.MismatchedInputException;
import ${packageName}.common.basic.BaseController;
import ${packageName}.common.basic.ResultVO;
import ${packageName}.common.constant.MsgCode;
import ${packageName}.common.exception.RemoteApiException;
import ${packageName}.common.utils.MailUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.TypeMismatchException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.bind.MissingServletRequestParameterException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.io.PrintWriter;
import java.io.StringWriter;


/**
 * 全局异常处理类
 */
@ControllerAdvice(basePackages = {"com"})
public class SysControllerAdvice extends BaseController {
    private static final Logger LOG = LoggerFactory.getLogger(SysControllerAdvice.class);

    @Autowired
    private MailUtil mailUtil;


    /**
     * 其他异常
     * @param ex
     * @return
     */
    @ExceptionHandler({RuntimeException.class})
    @ResponseBody
    public ResultVO runtimeException(RuntimeException ex){
        StringWriter sw = new StringWriter();
        ex.printStackTrace(new PrintWriter(sw,true));
        LOG.error(ex.getClass().getName() + " " + sw.toString(), this.getClass());
        mailUtil.sendErrorAsync("商品服务发生异常",this.getClass().getCanonicalName() + "\n" + sw.toString());
        return buildFailedInfo("服务器发生异常："+ex.getMessage());
    }

    /**
     * api调用异常
     * @param ex
     * @return
     */
    @ExceptionHandler({RemoteApiException.class})
    @ResponseBody
    public ResultVO remoteApiException(RemoteApiException ex){
        return buildFailedInfo("远程调用失败："+ex.getMessage());
    }


    /**
     * 400错误->缺少参数异常
     */
    @ExceptionHandler({MissingServletRequestParameterException.class})
    @ResponseBody
    public ResultVO requestMissingServletRequest(MissingServletRequestParameterException ex){
        return buildFailedInfo(MsgCode.PARAM_IS_NULL.getMessage() + "："+ex.getParameterName());
    }


    /**
     * 400错误->参数类型异常
     */
    @ExceptionHandler({TypeMismatchException.class})
    @ResponseBody
    public ResultVO paramTypeError(TypeMismatchException ex){
        return buildFailedInfo(MsgCode.PARAM_TYPE_ERROR.getMessage()+"："+ex.getValue()+"，需要："+ex.getRequiredType().getName());
    }

    /**
     * 400错误->参数格式有误
     */
    @ExceptionHandler({InvalidFormatException.class})
    @ResponseBody
    public ResultVO invalidFormatException(InvalidFormatException ex){
        return buildFailedInfo(MsgCode.PARAM_FORMAT_ERROR);
    }


    /**
     * 400错误->json参数格式有误
     */
    @ExceptionHandler({JsonParseException.class})
    @ResponseBody
    public ResultVO jsonParamError1(JsonParseException ex){
        return buildFailedInfo(MsgCode.PARAM_JSON_ERROR);
    }

    /**
     * 400错误->json参数格式有误
     */
    @ExceptionHandler({HttpMessageNotReadableException.class})
    @ResponseBody
    public ResultVO jsonParamError2(HttpMessageNotReadableException ex){
        if( ex.getCause() instanceof MismatchedInputException) {
            MismatchedInputException cause = (MismatchedInputException) ex.getCause();
            String paramName = cause.getPathReference();
            String needType = cause.getTargetType().getName();
            return buildFailedInfo(MsgCode.PARAM_TYPE_ERROR.getMessage() + " " + paramName + " 需要的类型是：" + needType);
        }
        return buildFailedInfo(MsgCode.PARAM_JSON_ERROR);
    }


    
}
