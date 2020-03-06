package com.agriculture.service;

import com.agriculture.pojo.FarmWork;

import java.util.List;

public interface FarmWorkService {
    List<FarmWork> getAll(int id);
    FarmWork getAll1();
    FarmWork getxq(int lotid, int id);
}
