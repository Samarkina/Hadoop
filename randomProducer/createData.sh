#!/usr/bin/env bash

python3 ./randomProducer.py | nc localhost 44444 >/dev/null