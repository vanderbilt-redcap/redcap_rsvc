#!/bin/bash

set -e

# Load environment variables from .env file
if [ -f .env ]; then
  source .env
fi

# Default values
prompt_mode=false
upload=false

# Parse arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --cur_tag)
      CUR_TAG="$2"
      shift 2
      ;;
    --comp_tag)
      COMP_TAG="$2"
      shift 2
      ;;
    --start_date)
      START_DATE="$2"
      shift 2
      ;;
    --end_date)
      END_DATE="$2"
      shift 2
      ;;
    --prompt)
      prompt_mode=true
      shift
      ;;
    --upload)
      upload=true
      shift
      ;;
    *)
      echo "Unknown option: $1" >&2
      exit 1
      ;;
  esac
done

# Handle prompt mode
if [[ "$prompt_mode" = true ]]; then
  echo "Choose Mode"
  echo "1) Tags"
  echo "2) Dates"
  read -rp "Enter 1 or 2: " choice

  case "$choice" in
    1)
      read -rp "Enter current tag: " CUR_TAG
      read -rp "Enter comparison tag: " COMP_TAG
      ;;
    2)
      read -rp "Enter start date (YYYY-MM-DD): " START_DATE
      read -rp "Enter end date (YYYY-MM-DD): " END_DATE
      ;;
    *)
      echo "Invalid choice. Exiting."
      exit 1
      ;;
  esac
fi

awk_script='
{
  orig_path = $3
  path = orig_path
  old_path = ""

  if (path ~ /\{.*=>.*\}/) {
    prefix = substr(path, 1, match(path, /\{/) - 1)
    inside = substr(path, match(path, /\{/) + 1)
    inside = substr(inside, 1, length(inside) - 1)
    split(inside, parts, /=>/)

    old_part = parts[1]
    new_part = parts[2]

    gsub(/^[ \t]+|[ \t]+$/, "", old_part)
    gsub(/^[ \t]+|[ \t]+$/, "", new_part)

    old_path = prefix old_part
    path = prefix new_part

    old_paths[old_path] = 1
  }

  if (path ~ /\.feature$/) {
    added[path] += $1
    deleted[path] += $2
    files[path] = 1
  }
}

#We ingest a temporary file of all features here so we do not miss any
BEGIN {
  while ((getline line < "all_features.txt.tmp") > 0) {
    all_files[line] = 1
  }
}

END {
  count = 1

  # Remove any files that were old paths in renames
  for (op in old_paths) {
    delete files[op]
    delete added[op]
    delete deleted[op]
  }

  total_added = 0
  total_deleted = 0
  printf "%10s %10s %10s   %s\n", "Added", "Deleted", "Total", "File"

  for (file in all_files) {
    file_added = added[file]
    file_deleted = deleted[file]
    file_total = file_added + file_deleted
    total_added += file_added
    total_deleted += file_deleted

    n = split(file, path_parts, "/")
    base = path_parts[n]
    sub(/\.feature$/, "", base)
    split(base, parts, "\\.")
    letter = toupper(parts[1])
    part1 = parts[2]
    part2 = parts[3]
    part3 = sprintf("%04d", parts[4])

    if (letter != "A" && letter != "B" && letter != "C") continue

    feature = letter "." part1 "." part2 "." part3 "."

    mod = (file_added < file_deleted ? file_added : file_deleted)
    pure_added = file_added - mod
    pure_deleted = file_deleted - mod

    #Outputting this is helpful so we know how many features we have
    printf count
    count++

    if (upload == "true") {

      #Skip these files for upload
      if( feature == "C.6.11.0400." || feature == "C.3.30.1000." || feature == "C.3.30.0800." || feature == "A.3.28.1200." || feature == "A.3.28.1300." || feature == "A.3.28.1100."){

        #Do nothing here because these records do not exist within the VUMC REDCap project for one reason or another
        #NOTE: This skip block will probably change with each new version of LTS tested

      } else {

        if(file_added == 0 && file_deleted == 0){
                printf feature
                cmd = "sh push_lines_changes.sh \"" feature "\" " 0 " " 0 " " 0 " " 0 " " 0 " " 0
                return_code = system(cmd)
        } else {
              cmd = "sh push_lines_changes.sh \"" feature "\" " \
                    file_added " " \
                    pure_added " " \
                    file_deleted " " \
                    pure_deleted " " \
                    file_total " " \
                    mod
              return_code = system(cmd)
        }
      }

      if (return_code != 0) {
        print "push_lines_changes.sh failed on " feature
        exit 1
      }
      printf "%10d %10d %10d   %s - UPLOADED\n", file_added, file_deleted, file_total, file
    } else {
      printf "%10d %10d %10d   %s\n", file_added, file_deleted, file_total, file
    }
  }

  printf "%s\n", "---------------------------------------------------------------"
  printf "   %10d %10d %10d   %s\n", total_added, total_deleted, total_added + total_deleted, "TOTAL"
}'

# Validate input
if [[ -n "$CUR_TAG" && -n "$COMP_TAG" ]]; then
  echo "Using tags: CURRENT_TAG=$CUR_TAG vs COMPARISON_TAG=$COMP_TAG"

    #Only if empty Start Date
    if [ -z $START_DATE ]; then
      START_DATE=$(git log -1 --format=%ad --date=short $COMP_TAG)
    fi

    #Only if empty End Date
    if [ -z $END_DATE ]; then
      END_DATE=$(git log -1 --format=%ad --date=short $CUR_TAG)
    fi

elif [[ -n "$START_DATE" && -n "$END_DATE" ]]; then
  echo "Using dates: START_DATE=$START_DATE => END_DATE=$END_DATE"

else
  #Only if empty Current Tag
  if [ -z $CUR_TAG ]; then
    CUR_TAG=$(git tag --sort=-v:refname | head -n 1)
  fi

  #Only if empty Comparison Tag
  if [ -z $COMP_TAG ]; then
    COMP_TAG=$(git tag --sort=-creatordate | sed -n 2p)
  fi

  #Only if empty Start Date
  if [ -z $START_DATE ]; then
    START_DATE=$(git log -1 --format=%ad --date=short $COMP_TAG)
  fi

  #Only if empty End Date
  if [ -z $END_DATE ]; then
    END_DATE=$(git log -1 --format=%ad --date=short $CUR_TAG)
  fi

  printf "DEFAULT MODE: Takes the most recent tag and compares it to the previous tag.\n"

fi

if [ "$upload" = true ]; then
  if [ -z "$REDCAP_API_TOKEN" ]; then
    echo "Environment variable REDCAP_API_TOKEN is not set. Exiting."
    exit 1
  fi

  if [ -z $CUR_TAG ]; then
    echo "Tags must be used when uploading to ensure we're uploading to the matching REDCap project."
    exit
  fi

  CURL=`which curl`
  if [ "$REDCAP_API_URL" == "https://redcap.loc/api/" ]; then
    CURL="$CURL --ssl-revoke-best-effort"
  fi

  PROJECT_LTS_VERSION=`$CURL -X POST "$REDCAP_API_URL" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -d "token=$REDCAP_API_TOKEN" \
    -d "content=project" \
    -d "format=json" \
    -d "returnFormat=json" |cut -d'"' -f 6|cut -d' ' -f 6`

  if [[ "$CUR_TAG" != "V$PROJECT_LTS_VERSION-ABC" ]]; then
    echo "Tag and project LTS version do not match ($CUR_TAG vs. $PROJECT_LTS_VERSION)"
    exit
  fi
fi
#Generate a temporary file of all features
ALL_FEATURE_FILES=$(git ls-files '*.feature')
echo "$ALL_FEATURE_FILES" > all_features.txt.tmp

#Generate a temporary file of all features
ALL_FEATURE_FILES=$(git ls-files '*.feature')
echo "$ALL_FEATURE_FILES" > all_features.txt.tmp

# Get the line changes for .feature files between the dates
git log --since="$START_DATE" --until="$END_DATE" --pretty=tformat: --numstat --ignore-space-change | awk -F'\t' -v upload="$upload" "$awk_script"

#Remove the temporary file
rm all_features.txt.tmp

if [ -z $CUR_TAG ]; then
  echo ""
else
  printf "\nTAGS: \n CURRENT_TAG: $CUR_TAG \n COMPARISON_TAG: $COMP_TAG\n"
fi
printf "DATES:\n START_DATE: $START_DATE \n END_DATE: $END_DATE\n"