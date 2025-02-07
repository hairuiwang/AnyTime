#!/bin/bash

# Copyright (c) 2024, crasowas.
#
# Use of this source code is governed by a MIT-style license
# that can be found in the LICENSE file or at
# https://opensource.org/licenses/MIT.

app_dir="$1"
frameworks_dir="$app_dir/Frameworks"

# Check if the app exists
if [ ! -d "$app_dir" ] || [[ "$app_dir" != *.app ]]; then
    echo "Unable to find the app: $app_dir"
    exit 1
fi

report_output_file="$2"
# Additional arguments as template usage records
template_usage_records=("${@:2}")

# Absolute path of the script and the report root directory
script_path="$(realpath "$0")"
report_root_dir="$(dirname "$script_path")"

# Copy report template to output file
report_template_file="$report_root_dir/report-template.html"
if ! rsync -a "$report_template_file" "$report_output_file"; then
    echo "Error: Failed to copy the report template to $report_output_file"
    exit 1
fi

# Initialize report content
report_content=""

# File name of the privacy manifest
readonly PRIVACY_MANIFEST_FILE_NAME="PrivacyInfo.xcprivacy"

# Universal delimiter
readonly DELIMITER=":"

# Space escape symbol for handling space in path
readonly SPACE_ESCAPE="\u0020"

# Split a string into substrings using a specified delimiter
function split_string_by_delimiter() {
    local string="$1"
    local -a substrings=()

    IFS="$DELIMITER" read -ra substrings <<< "$string"

    echo "${substrings[@]}"
}

# Encode a path string by replacing space with an escape character
function encode_path() {
    echo "$1" | sed "s/ /$SPACE_ESCAPE/g"
}

# Decode a path string by replacing encoded character with space
function decode_path() {
    echo "$1" | sed "s/$SPACE_ESCAPE/ /g"
}

# Search for privacy manifest files in a directory
function search_privacy_manifest_files() {
    local dir_path="$1"
    local -a privacy_manifest_files=()

    # Create a temporary file to store search results
    local temp_file="$(mktemp)"

    # Ensure the temporary file is deleted on script exit
    trap "rm -f $temp_file" EXIT

    # Find privacy manifest files within the specified directory and store the results in the temporary file
    find "$dir_path" -type f -name "$PRIVACY_MANIFEST_FILE_NAME" -print0 2>/dev/null > "$temp_file"

    while IFS= read -r -d '' file_path; do
        privacy_manifest_files+=($(encode_path "$file_path"))
    done < "$temp_file"

    echo "${privacy_manifest_files[@]}"
}

function get_privacy_manifest_file() {
    # If there are multiple privacy manifest files, return the one with the shortest path
    local privacy_manifest_file="$(printf "%s\n" "$@" | awk '{print length, $0}' | sort -n | head -n1 | cut -d ' ' -f2-)"
    
    echo "$(decode_path "$privacy_manifest_file")"
}

# Get the template file used for fixing based on the app or framework name
function get_used_template_file() {
    local name="$1"
    
    for template_usage_record in "${template_usage_records[@]}"; do
        if [[ "$template_usage_record" == "$name$DELIMITER"* ]]; then
            echo "${template_usage_record#*$DELIMITER}"
            return
        fi
    done
    
    echo ""
}

# Analyze accessed API types and their corresponding reasons
function analyze_privacy_accessed_api() {
    local privacy_manifest_file="$1"
    local -a results=()

    if [ -f "$privacy_manifest_file" ]; then
        local api_count=$(xmllint --xpath 'count(//dict/key[text()="NSPrivacyAccessedAPIType"])' "$privacy_manifest_file")

        for ((i=1; i<=api_count; i++)); do
            local api_type=$(xmllint --xpath "(//dict/key[text()='NSPrivacyAccessedAPIType']/following-sibling::string[1])[$i]/text()" "$privacy_manifest_file")
            local api_reasons=$(xmllint --xpath "(//dict/key[text()='NSPrivacyAccessedAPITypeReasons']/following-sibling::array[1])[position()=$i]/string/text()" "$privacy_manifest_file" 2>/dev/null | paste -sd "/" -)
            
            if [ -z "$api_reasons" ]; then
                api_reasons="N/A"
            fi
            
            results+=("$api_type$DELIMITER$api_reasons")
        done
        
        # Add placeholder 'N/A' if the accessed privacy API types array is empty
        if [ ${#results[@]} -eq 0 ]; then
            results+=("N/A${DELIMITER}N/A")
        fi
    fi

    echo "${results[@]}"
}

# Add an HTML <div> element with the `card` class
function add_html_card_container() {
    local card="$1"
    
    report_content="$report_content<div class=\"card\">$card</div>"
}

# Generate an HTML <h2> element
function generate_html_title() {
    local title="$1"
    
    echo "<h2>$title</h2>"
}

# Generate an HTML <a> element with optional `warning` class
function generate_html_anchor() {
    local text="$1"
    local href="$2"
    local warning="$3"
    
    if [ "$warning" == true ]; then
        echo "<a class=\"warning\" href=\"$href\">$text</a>"
    else
        echo "<a href=\"$href\">$text</a>"
    fi
}

# Generate an HTML <table> element
function generate_html_table() {
    local thead="$1"
    local tbody="$2"
    
    echo "<table>$thead$tbody</table>"
}

# Generate an HTML <thead> element
function generate_html_thead() {
    local ths=("$@")
    local tr=""
    
    for th in "${ths[@]}"; do
        tr="$tr<th>$th</th>"
    done
    
    echo "<thead><tr>$tr</tr></thead>"
}

# Generate an HTML <tbody> element
function generate_html_tbody() {
    local trs=("$@")
    local tbody=""
    
    for tr in "${trs[@]}"; do
        tbody="$tbody<tr>"
        local tds=($(split_string_by_delimiter "$tr"))
        
        for td in "${tds[@]}"; do
            tbody="$tbody<td>$td</td>"
        done
        
        tbody="$tbody</tr>"
    done
    
    echo "<tbody>$tbody</tbody>"
}

# Generate the report content for the specified directory
function generate_report_content() {
    local dir_path="$1"
    
    local privacy_manifest_file=""
    
    if [[ "$dir_path" == *.app ]]; then
        # Per the documentation, the privacy manifest should be placed at the root of the app’s bundle
        # Reference: https://developer.apple.com/documentation/bundleresources/adding-a-privacy-manifest-to-your-app-or-third-party-sdk#Add-a-privacy-manifest-to-your-app
        privacy_manifest_file="$dir_path/$PRIVACY_MANIFEST_FILE_NAME"
    else
        # Per the documentation, the privacy manifest should be placed at the root of the framework’s bundle
        # Some SDKs don’t follow the guideline, so we use a search-based approach for now
        # Reference: https://developer.apple.com/documentation/bundleresources/adding-a-privacy-manifest-to-your-app-or-third-party-sdk#Add-a-privacy-manifest-to-your-framework
        local privacy_manifest_files=($(search_privacy_manifest_files "$dir_path"))
        privacy_manifest_file="$(get_privacy_manifest_file "${privacy_manifest_files[@]}")"
    fi
    
    local name="$(basename "$dir_path")"
    local card="$(generate_html_title "$name")"
    
    if [ -f "$privacy_manifest_file" ]; then
        card="$card$(generate_html_anchor "$PRIVACY_MANIFEST_FILE_NAME" "$privacy_manifest_file" false)"
        
        local used_template_file="$(get_used_template_file "$name")"
        
        if [ -f "$used_template_file" ]; then
            card="$card$(generate_html_anchor "Template Used: $(basename "$used_template_file")" "$used_template_file" false)"
        fi
        
        local thead="$(generate_html_thead "NSPrivacyAccessedAPIType" "NSPrivacyAccessedAPITypeReasons")"
        local trs=($(analyze_privacy_accessed_api "$privacy_manifest_file"))
        local thbody="$(generate_html_tbody "${trs[@]}")"
        
        card="$card$(generate_html_table "$thead" "$thbody")"
    else
        card="$card$(generate_html_anchor "Missing Privacy Manifest" "$dir_path" true)"
    fi
    
    add_html_card_container "$card"
}

# Generate the report content for app
function generate_app_report_content() {
    generate_report_content "$app_dir"
}

# Generate the report content for frameworks
function generate_frameworks_report_content() {
    if ! [ -d "$frameworks_dir" ]; then
        return
    fi
    
    for path in "$frameworks_dir"/*; do
        if [ -d "$path" ]; then
            generate_report_content "$path"
        fi
    done
}

# Generate the final report with all content
function generate_final_report() {
    # Replace placeholder in the template with the report content
    sed -i "" "s|{{REPORT_CONTENT}}|${report_content}|g" "$report_output_file"
    echo "Privacy Access Report has been generated: $report_output_file."
}

generate_app_report_content
generate_frameworks_report_content
generate_final_report
