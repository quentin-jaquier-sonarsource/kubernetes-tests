#!/bin/sh
REPO=peachee-java-flat
JOBS=jobs
rm -rf $REPO 2>/dev/null
git clone https://github.com/dbolkensteyn/peachee-java-flat $REPO
find $REPO/* -type d -exec sh -c "project=\${1#$REPO/}; sed s/\\\$PROJECT/\$project/ job.yaml > $JOBS/job-\$project.yaml" _ {} \;
