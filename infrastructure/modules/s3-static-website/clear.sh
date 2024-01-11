#! /usr/bin/env python

import boto3

s3 = boto3.resource('s3')
bucket = s3.Bucket('acrc-static-website112')
bucket.object_versions.all().delete()














# aws s3 rm s3://acrc-static-website112/ --recursive


