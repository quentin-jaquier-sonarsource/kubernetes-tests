#!/bin/sh
if [ "$#" -ne 1 ]; then
  echo "Expected exactly one argument: the name of the YAML job template"
  exit 1
fi

REPO=peachee-java-flat
JOBS=jobs
JOB_NAME_MAX_LENGTH=50

rm -rf $JOBS
mkdir $JOBS
rm -rf $REPO 2>/dev/null
git clone https://github.com/dbolkensteyn/peachee-java-flat $REPO
find $REPO/* -type d -exec sh -c "project=\${1#$REPO/}; sed \"s/%PROJECT-NAME%/\${project:\${#project}<$JOB_NAME_MAX_LENGTH?0:-$JOB_NAME_MAX_LENGTH}/g; s/%PROJECT%/\$project/g;\" $1 > $JOBS/job-\$project.yaml" _ {} \;
