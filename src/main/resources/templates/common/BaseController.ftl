package ${packageName}.common.basic;


import ${packageName}.common.constant.MsgCode;

public abstract class BaseController {
	

	protected ResultVO buildSuccessInfo(Object resultData) {
		return new ResultVO(MsgCode.SUCCESS.getMsgCode(), MsgCode.SUCCESS.getMessage(), resultData);
	}

    protected ResultVO buildFailedInfo(MsgCode errorCode) {
        return new ResultVO(errorCode.getMsgCode(), errorCode.getMessage(), null);
	}

    protected ResultVO buildFailedInfo(String errorMsg) {
        return new ResultVO(MsgCode.FAILURE.getMsgCode(), errorMsg, null);
	}

}
