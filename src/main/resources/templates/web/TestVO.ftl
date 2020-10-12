package ${packageName}.web.controller;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

@Data
public class TestVO {

    @ApiModelProperty("姓名")
    private String name;
}
