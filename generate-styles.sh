#!/usr/bin/env bash

set -euo pipefail

# Verify env vars present
: "${SOURCES_OPENMAPTILES_URL:?Environment variable missing}"

TEMPLATE_DIR="templates"
OUTPUT_DIR="generated-styles"

for LOCALE in fi sv; do
  export LOCALE
  echo "Processing lang '$LOCALE'..."

  # Process each JSON template
  for TEMPLATE in "$TEMPLATE_DIR"/*.json; do
    # Skip if no templates found
    [[ -e "$TEMPLATE" ]] || { echo "No JSON files found in '$TEMPLATE_DIR'."; break; }

    BASENAME=$(basename "$TEMPLATE" .json)
    OUTPUT_FILE="$OUTPUT_DIR/${BASENAME}.${LOCALE}.json"

    # Substitute environment variables and write to output
    envsubst < "$TEMPLATE" > "$OUTPUT_FILE"
    echo "  -> Generated ${OUTPUT_DIR}/${OUTPUT_FILE}"
  done
done

echo "All done. Generated files are in '$OUTPUT_DIR'."
