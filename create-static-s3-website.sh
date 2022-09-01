#!/bin/bash

## REQUIREMENT: Install hugo first
## https://gohugo.io/getting-started/installing/

# Authenticate w/ AWS
AWS_PROFILE=default
docker run -it -v ~/.aws:/aws -e AWS_PROFILE=$AWS_PROFILE -e DURATION=129600 sysdig/aws-mfa:latest

# Set variables
BUCKET=awsworkshop-review
BUCKETREGION=sa-east-1

# Create bucket
# aws s3 mb s3://$BUCKET --region $BUCKETREGION
aws s3api create-bucket --bucket $BUCKET --region $BUCKETREGION --create-bucket-configuration LocationConstraint=$BUCKETREGION

# Upload Sample index.html for Testing
cat << EOF > index.html
<!DOCTYPE HTML>
<html>
 <head>
  <title>Test Page</title>
 </head>
 <body>
  <p>Hello, world!</p>
 </body>
</html>
EOF

cat << EOF > error.html
<!DOCTYPE HTML>
<html>
 <head>
  <meta charset="utf-8"/>
  <title>404 - this page does not exist</title>
 </head>
 <body>
 <p>404 error - this page does not exist!</p>
 </body>
</html>
EOF

aws s3 cp index.html s3://$BUCKET/index.html
aws s3 cp index.html s3://$BUCKET/error.html

# aws s3api put-object --bucket $BUCKET --key index.html --acl public-read
# aws s3api put-object --bucket $BUCKET --key error.html --acl public-read

# Set the website configuration for bucket
aws s3 website s3://$BUCKET/ --index-document index.html --error-document error.html

cat << EOF > policy.json
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "PublicReadGetObject",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "s3:GetObject"
            ],
            "Resource": [
                "arn:aws:s3:::${BUCKET}/*"
            ]
        }
    ]
}
EOF

aws s3api put-bucket-policy --bucket $BUCKET --policy file://policy.json

# To upload content to S3 bucket $BUCKET, move to that directory, then run the following
# aws s3 cp . s3://$BUCKET/ --profile $AWS_PROFILE --recursive

#open http://$BUCKET.s3-website-$BUCKETREGION.amazonaws.com
 
#################

# Create the content
echo rebuilding content
rm -rf public/*
hugo

echo Uploading content to S3 bucket $BUCKET
cd public
aws s3 cp . s3://$BUCKET/ --profile $AWS_PROFILE --recursive

cd ..

open http://$BUCKET.s3-website-$BUCKETREGION.amazonaws.com

