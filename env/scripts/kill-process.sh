#!/bin/bash

echo 'What process you wish to kill'
read processID

kill -9 "$processID"
