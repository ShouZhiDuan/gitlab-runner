package com.example.demo.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.net.InetAddress;
import java.net.UnknownHostException;

/**
 * @Auther: ShouZhi@Duan
 * @Description:
 */
@Slf4j
@RestController
@RequestMapping("/cicd")
public class CICDController {

    @GetMapping("/say")
    public Object testCICD(@RequestParam(value = "txt", defaultValue = "Hello！！！！！！") String txt) throws UnknownHostException {
        InetAddress addr = InetAddress.getLocalHost();
        String hostname = addr.getHostName();
        while (true){
            log.info("Local host name: "+hostname);
        }
        //return "Local host name: "+ hostname + " image version latest-9 ......";
    }





}
