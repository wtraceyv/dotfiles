#!/bin/bash

ls | grep .bak | grep -v sh | xargs rm
echo "Cleaned backups; new ls:"
ls
