package com.example.demo.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Auther: ShouZhi@Duan
 * @Description:
 */
@RestController
@RequestMapping("/cicd")
public class CICDController {

    @GetMapping("/say")
    public Object testCICD(@RequestParam(value = "txt",defaultValue = "Hello！！！！！！") String txt){
        txt = txt + " 666666";
        return txt;
    }


}
