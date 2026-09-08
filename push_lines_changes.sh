#!/bin/sh
CURL=`which curl`

FEATURE="$1"
ADDED="$2"
PURE_ADDED="$3"
DELETED="$4"
PURE_DELETED="$5"
TOTAL="$6"
TOTAL_MOD="$7"
PACKAGE_SEQUENCE="$8"

# Load environment variables from .env file
if [ -f .env ]; then
  source ./.env
fi

if [ -z "$REDCAP_API_TOKEN" ]; then
  echo "Environment variable REDCAP_API_TOKEN is not set. Exiting."
  exit 1
fi

if [ "$REDCAP_API_URL" == "https://redcap.loc/api/" ]; then
  CURL="$CURL --ssl-revoke-best-effort"
fi

#Get the record ID and make sure it exists
result=`$CURL -X POST "$REDCAP_API_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=$REDCAP_API_TOKEN" \
  -d "content=record" \
  -d "action=export" \
  -d "format=json" \
  -d "type=flat" \
  -d "fields=record_id" \
  -d "returnFormat=json" \
  -d "filterLogic=[package_sequence]='$PACKAGE_SEQUENCE' AND [frs_id]='$FEATURE'"`

recordIdOn="${result#*\"record_id\":\"}"
secondRecordIdOn="${recordIdOn#*\"record_id\":\"}"
if [[ "$result" == "[]" ]]; then
  echo "Failing since record with FRS_ID $FEATURE not found.  There may be a bug in this script trying to create a record that shouldn't exist in this project."
  exit 1
elif [[ "$secondRecordIdOn" != "$recordIdOn" ]]; then
  # Bash substring matching returns the full string if there are no matches
  echo "Failing since multiple records matched for package_sequence $PACKAGE_SEQUENCE and frs_id $FEATURE"
  exit 1
fi

RECORD_ID="${recordIdOn%%\"*}"

#Upload the Video file to the REDCap project
result=`$CURL -X POST "$REDCAP_API_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=$REDCAP_API_TOKEN" \
  -d "content=record" \
  -d "format=json" \
  -d "type=flat" \
  -d "data=[{\"record_id\":\"$RECORD_ID\",\"lines_added\":\"$ADDED\",\"lines_added_pure\":\"$PURE_ADDED\",\"lines_removed\":\"$DELETED\",\"lines_removed_pure\":\"$PURE_DELETED\",\"total_lines_changed\":\"$TOTAL\",\"est_total_mod_lines\":\"$TOTAL_MOD\",\"rvp_metrics_complete\":\"2\"}]" \
  -d "returnContent=ids" \
  -d "returnFormat=json"`

if [[ "$result" == *"error"* ]]; then
    echo Error: $result
    exit 1
fi