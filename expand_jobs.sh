#!/bin/sh
REPO=peachee-java-flat
JOBS=jobs
JOB_NAME_MAX_LENGTH=50

rm -rf $REPO 2>/dev/null
git clone https://github.com/dbolkensteyn/peachee-java-flat $REPO
find $REPO/* -type d -exec sh -c "project=\${1#$REPO/}; sed \"s/%PROJECT-NAME%/\${project:\${#project}<$JOB_NAME_MAX_LENGTH?0:-$JOB_NAME_MAX_LENGTH}/; s/%PROJECT%/\$project/;\" job.yaml > $JOBS/job-\$project.yaml" _ {} \;
