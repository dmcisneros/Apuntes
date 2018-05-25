package com.dmcisneros.java.features;

import java.util.ArrayList;
import java.util.List;

public class TestForEach {

    public static void main(String[] args) {
        List<String> listDevs = getItems();

        previous(listDevs);
        java8(listDevs);
    }

    /**
     * Before java 8
     * @param listDevs
     */
    private static void previous(List<String> listDevs) {

    }

    /**
     * java 8
     * @param listDevs
     */
    private static void java8(List<String> listDevs) {}

    private static List<String> getItems() {

        List<String> items = new ArrayList<>();
        items.add("A");
        items.add("B");
        items.add("C");
        items.add("D");
        items.add("E");

        return items;

    }

}