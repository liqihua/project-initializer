package ${packageName}.common.basic;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


@Data
@ApiModel(value = "ResultVO")
public class ResultVO <T> {

	@ApiModelProperty(notes = "返回码，100表示成功，非100表示失败")
	private String resultCode;

	@ApiModelProperty(notes = "返回消息，成功为\"success\",失败为具体失败信息")
	private String resultMsg;

	@ApiModelProperty(notes = "返回数据")
	private T data;

	public ResultVO() {
	}


	public ResultVO(String resultCode) {
		this.resultCode = resultCode;
	}

	public ResultVO(String resultCode, String resultMsg) {
		this.resultCode = resultCode;
		this.resultMsg = resultMsg;
	}

	public ResultVO(String resultCode, String resultMsg, T data) {
		this.resultCode = resultCode;
		this.resultMsg = resultMsg;
		this.data = data;
	}

}
