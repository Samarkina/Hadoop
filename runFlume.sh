#!/usr/bin/env bash

flume-ng agent --conf conf --conf-file ./randomProducer/flume.conf --name a1 -Dflume.root.logger=INFO,console