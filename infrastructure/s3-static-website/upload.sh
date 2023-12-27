#! /usr/bin/bash


cd ../../frontend
aws s3 sync . s3://acrc-static-website112 --delete