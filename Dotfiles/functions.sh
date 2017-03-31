#!/bin/bash

function find_java {
  echo `find /Library/Java/JavaVirtualMachines -depth 1 | sort -r | head -1`
}
