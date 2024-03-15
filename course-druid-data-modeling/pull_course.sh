#!/bin/bash

cd druid-data-modeling-dimensions
instruqt track pull $@
cd ..

cd druid-data-modeling-intro
instruqt track pull $@
cd ..

cd druid-data-modeling-rollup
instruqt track pull $@
cd ..

cd druid-data-modeling-segments
instruqt track pull $@
cd ..

cd druid-data-modeling-timestamp
instruqt track pull $@
cd ..

cd druid-data-modeling-transform
instruqt track pull $@
cd ..
