package com.weixin.pay.utils;

import com.weixin.pay.vo.ResultVo;

public class ResultUtil {



    public static ResultVo success(Object obj) {
        ResultVo resultVo = new ResultVo();
        resultVo.setCode(0);
        resultVo.setMsg("成功");
        resultVo.setData(obj);
        return resultVo;
    }

    public static ResultVo error(Object obj) {
        ResultVo resultVo = new ResultVo();
        resultVo.setCode(1);
        resultVo.setMsg("失败");
        return resultVo;
    }
}