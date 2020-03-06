package com.agriculture.service.impl;

import com.agriculture.dao.ParvialfieldMapper;
import com.agriculture.pojo.Parvialfield;
import com.agriculture.service.ParvialfieldService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

@Service
public class ParvialfieldServiceImpl implements ParvialfieldService {
    @Resource
    private ParvialfieldMapper parvialfieldMapper;
    @Override
    public List<Parvialfield> getAll() {
        return parvialfieldMapper.getAll();
    }
}
