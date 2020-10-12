package ${packageName}.web.controller;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Data
public class TestDTO {

    @ApiModelProperty(value = "姓名")
    private String name;

    @NotNull
    @Size(min = 1,message = "fees长度必须大于0")
    @ApiModelProperty(value = "数组参数")
    private List<String> typeList;

    @ApiModelProperty(value = "日期参数 yyyy-MM-dd")
    private LocalDate date;

    @ApiModelProperty(value = "时间参数 yyyy-MM-dd HH:mm:ss")
    private LocalDateTime time;

    @NotBlank
    @ApiModelProperty(value = "订单号", required = true)
    private String orderNo;
}
