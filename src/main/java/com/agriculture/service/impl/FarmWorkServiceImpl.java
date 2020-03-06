package com.agriculture.service.impl;

import com.agriculture.dao.FarmWorkMapper;
import com.agriculture.pojo.FarmWork;
import com.agriculture.service.FarmWorkService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class FarmWorkServiceImpl implements FarmWorkService {
    @Resource
    private FarmWorkMapper farmWorkMapper;
    @Override
    public List<FarmWork> getAll(int id) {
        return farmWorkMapper.getAll(id);
    }

    @Override
    public FarmWork getAll1() {
        return farmWorkMapper.getAll1();
    }

    @Override
    public FarmWork getxq(int lotid, int id) {
        return farmWorkMapper.getxq(lotid,id);
    }
}
