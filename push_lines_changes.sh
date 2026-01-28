#!/bin/sh
CURL=`which curl`

FEATURE="$1"
ADDED="$2"
PURE_ADDED="$3"
DELETED="$4"
PURE_DELETED="$5"
TOTAL="$6"
TOTAL_MOD="$7"

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
  -d "filterLogic=[record_id]='$FEATURE'"`

if [[ "$result" == "[]" ]]; then
  echo "Failing since record with ID $FEATURE not found.  There may be a bug in this script trying to create a record that shouldn't exist in this project."
  exit 1
fi

#Upload the Video file to the REDCap project
$CURL -X POST "$REDCAP_API_URL" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "token=$REDCAP_API_TOKEN" \
  -d "content=record" \
  -d "format=json" \
  -d "type=flat" \
  -d "data=[{\"record_id\":\"$FEATURE\",\"lines_added\":\"$ADDED\",\"lines_added_pure\":\"$PURE_ADDED\",\"lines_removed\":\"$DELETED\",\"lines_removed_pure\":\"$PURE_DELETED\",\"total_lines_changed\":\"$TOTAL\",\"est_total_mod_lines\":\"$TOTAL_MOD\",\"feature_changes_complete\":\"2\"}]" \
  -d "returnContent=ids" \
  -d "returnFormat=json"