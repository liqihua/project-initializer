package ${packageName}.web.controller;

import com.alibaba.fastjson.JSON;
import ${packageName}.common.basic.BaseController;
import ${packageName}.common.basic.ResultVO;
import ${packageName}.common.constant.MsgCode;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponse;
import io.swagger.annotations.ApiResponses;
import org.redisson.api.RBucket;
import org.redisson.api.RedissonClient;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.List;

@Api(value="TestController",description="调试，请勿调")
@RestController
@RequestMapping("/test")
public class TestController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(TestController.class);


    @Autowired
    private RedissonClient redissonClient;


    @ApiOperation(value = "test1")
    @GetMapping("/test1")
    public ResultVO test1(){
        return buildSuccessInfo(null);
    }


    @ApiOperation(value = "test2")
    @ApiResponses({@ApiResponse(code = MsgCode.BASE_SUCCESS_CODE, message = MsgCode.BASE_SUCCESS_MSG, response = String.class)})
    @PostMapping("/test2")
    public ResultVO<List<TestVO>> test2(@RequestBody @Valid TestDTO param, BindingResult bindingResult){
        logger.info("参数是：{}", JSON.toJSONString(param));
        return buildSuccessInfo(param);
    }


    @ApiOperation(value = "redisSet")
    @GetMapping("/redisSet")
    public ResultVO redisSet(String key){
        TestDTO obj = new TestDTO();
        obj.setOrderNo(System.currentTimeMillis()+"");
        obj.setName(obj.getOrderNo());
        RBucket bucket = redissonClient.getBucket(key);
        bucket.set(obj);
        return buildSuccessInfo(null);
    }

    @ApiOperation(value = "redisGet")
    @GetMapping("/redisGet")
    public ResultVO redisGet(String key){
        RBucket bucket = redissonClient.getBucket(key);
        return buildSuccessInfo(bucket.get());
    }

}
