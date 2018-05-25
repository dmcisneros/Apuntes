package com.dmcisneros.java.features;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import com.dmcisneros.java.Developer;

public class TestSorting {

    public static void main(String[] args) {
        List<Developer> listDevs = getDevelopers();

        previous(listDevs);
        java8(listDevs);
    }

    /**
     * Before java 8
     * @param listDevs
     */
    private static void previous(List<Developer> listDevs) {
        System.out.println("Java 8");
        // sort by salary
        Collections.sort(listDevs, new Comparator<Developer>() {
            @Override
            public int compare(Developer o1, Developer o2) {
                return o1.getSalary().compareTo(o2.getSalary());
            }
        });

        System.out.println("After Sort");
        for (Developer developer : listDevs) {
            System.out.println(developer);
        }

    }

    /**
     * java 8
     * @param listDevs
     */
    private static void java8(List<Developer> listDevs) {
        System.out.println("Java 8");
        // lambda here!
        listDevs.sort((Developer o1, Developer o2) -> o1.getSalary().compareTo(o2.getSalary()));
        // java 8 only, lambda also, to print the List
        listDevs.forEach((developer) -> System.out.println(developer));
    }

    private static List<Developer> getDevelopers() {

        List<Developer> result = new ArrayList<Developer>();

        result.add(new Developer("mkyong", new BigDecimal("70000"), 33));
        result.add(new Developer("alvin", new BigDecimal("80000"), 20));
        result.add(new Developer("jason", new BigDecimal("100000"), 10));
        result.add(new Developer("iris", new BigDecimal("170000"), 55));

        return result;

    }

}