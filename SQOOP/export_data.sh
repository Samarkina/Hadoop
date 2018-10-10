#!/usr/bin/env bash

sqoop export \
    --connect jdbc:mysql://localhost:3306/rdbms \
    --username root \
    --table hiveTopCategories \
    --hcatalog-table TopCategories \
    --outdir /output

sqoop export \
    --connect jdbc:mysql://localhost:3306/rdbms \
    --username root \
    --table hiveTopProducts \
    --hcatalog-table TopProducts \
    --outdir /output

sqoop export \
    --connect jdbc:mysql://localhost:3306/rdbms \
    --username root \
    --table hiveTopCountries \
    --hcatalog-table TopCountries \
    --outdir /output