package ${packageName}.common.basic;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;


@Data
@ApiModel(value = "ResultVO")
public class ResultVO <T> {

	@ApiModelProperty(notes = "返回码，100表示成功，非100表示失败")
	private Integer code;

	@ApiModelProperty(notes = "返回消息，成功为\"success\",失败为具体失败信息")
	private String message;

	@ApiModelProperty(notes = "返回数据")
	private T data;

	public ResultVO() {
	}


	public ResultVO(Integer code) {
		this.code = code;
	}

	public ResultVO(Integer code, String message) {
		this.code = code;
		this.message = message;
	}

	public ResultVO(Integer code, String message, T data) {
		this.code = code;
		this.message = message;
		this.data = data;
	}

}

