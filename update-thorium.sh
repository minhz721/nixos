#!/usr/bin/env bash
set -euo pipefail

# Configuration
REPO="${REPO:-gz83/thorium}"
NIX_FILE="${NIX_FILE:-packages/thorium/default.nix}"
ENV_OUT="${ENV_OUT:-${GITHUB_ENV:-/dev/null}}"
TARGET_TAG="${TARGET_TAG:-}"

# Validate dependencies
for cmd in curl jq nix sed; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		echo "Missing dependency: $cmd"
		exit 1
	fi
done

if [ ! -f "$NIX_FILE" ]; then
	echo "Nix file not found: $NIX_FILE"
	exit 1
fi

# Read current package information
CURRENT_URL=$(
	sed -nE 's/^[[:space:]]*url = "([^"]*)";/\1/p' "$NIX_FILE"
)
CURRENT_HASH=$(
	sed -nE 's/^[[:space:]]*hash = "([^"]*)";/\1/p' "$NIX_FILE"
)

echo "Current URL:  $CURRENT_URL"
echo "Current Hash: $CURRENT_HASH"

# Optional GitHub token (avoids the 60 requests/hour anonymous API limit)
AUTH_ARGS=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
	AUTH_ARGS=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi

#!/usr/bin/env bash
set -euo pipefail

# Configuration
REPO="${REPO:-gz83/thorium}"
NIX_FILE="${NIX_FILE:-packages/thorium/default.nix}"
ENV_OUT="${ENV_OUT:-${GITHUB_ENV:-/dev/null}}"
TARGET_TAG="${TARGET_TAG:-}"

# Validate dependencies
for cmd in curl jq nix sed; do
	if ! command -v "$cmd" >/dev/null 2>&1; then
		echo "Missing dependency: $cmd"
		exit 1
	fi
done

if [ ! -f "$NIX_FILE" ]; then
	echo "Nix file not found: $NIX_FILE"
	exit 1
fi

# Read current package information
CURRENT_URL=$(
	sed -nE 's/^[[:space:]]*url = "([^"]*)";/\1/p' "$NIX_FILE"
)
CURRENT_HASH=$(
	sed -nE 's/^[[:space:]]*hash = "([^"]*)";/\1/p' "$NIX_FILE"
)

echo "Current URL:  $CURRENT_URL"
echo "Current Hash: $CURRENT_HASH"

# Optional GitHub token (avoids the 60 requests/hour anonymous API limit)
AUTH_ARGS=()
if [ -n "${GITHUB_TOKEN:-}" ]; then
	AUTH_ARGS=(-H "Authorization: Bearer ${GITHUB_TOKEN}")
fi

# Fetch release information
if [ -n "$TARGET_TAG" ]; then
	echo "Fetching release tag '$TARGET_TAG' from $REPO..."
	API_URL="https://api.github.com/repos/${REPO}/releases/tags/${TARGET_TAG}"
else
	echo "Fetching latest release from $REPO..."
	API_URL="https://api.github.com/repos/${REPO}/releases/latest"
fi

RELEASE_JSON=$(
	curl -fsSL \
		--retry 3 \
		--retry-delay 2 \
		-H "Accept: application/vnd.github+json" \
		"${AUTH_ARGS[@]}" \
		"$API_URL"
)

# Find AVX2 AppImage
ASSET_NAME=$(
	jq -er '
		[.assets[]
		  | select(.name | test("_AVX2\\.AppImage$"))
		  | .name][0] // empty
	' <<<"$RELEASE_JSON"
) || {
	echo "No AVX2 AppImage found in the requested release."
	echo "UPDATE_DETECTED=false" >>"$ENV_OUT"
	exit 1
}

DOWNLOAD_URL=$(
	jq -er --arg name "$ASSET_NAME" '
		[.assets[]
		  | select(.name == $name)
		  | .browser_download_url][0] // empty
	' <<<"$RELEASE_JSON"
)

if [ -z "$DOWNLOAD_URL" ]; then
	echo "Invalid download URL."
	exit 1
fi

# SHA-256 published by GitHub for this asset ("sha256:<hex>"), empty if not available
DIGEST=$(
	jq -r --arg name "$ASSET_NAME" '
		[.assets[]
		  | select(.name == $name)
		  | .digest // empty][0] // empty
	' <<<"$RELEASE_JSON"
)

# Extract version from asset name
LATEST_VERSION=$(
	sed -E \
		's/^Thorium_Browser_(.*)_AVX2\.AppImage$/\1/' \
		<<<"$ASSET_NAME"
)

if [ -z "$LATEST_VERSION" ] || [ "$LATEST_VERSION" = "$ASSET_NAME" ]; then
	echo "Unexpected asset filename: $ASSET_NAME"
	exit 1
fi

echo "Target version: $LATEST_VERSION"
echo "Download URL:   $DOWNLOAD_URL"

# Skip if URL and hash are already valid
if [[ "$CURRENT_URL" == "$DOWNLOAD_URL" ]] &&
	[[ -n "$CURRENT_HASH" ]] &&
	[[ "$CURRENT_HASH" != *"0000000000"* ]]; then

	echo "Thorium AVX2 is already up-to-date."
	echo "UPDATE_DETECTED=false" >>"$ENV_OUT"
	exit 0
fi

# Calculate the hash: use GitHub's digest when present, otherwise download the file
NEW_HASH=""

if [[ "$DIGEST" == sha256:* ]]; then
	echo "Using the digest published by GitHub (no download needed)."
	NEW_HASH=$(nix hash convert --hash-algo sha256 --from base16 "${DIGEST#sha256:}") || NEW_HASH=""
fi

if [ -z "$NEW_HASH" ]; then
	TEMP_FILE=$(mktemp)
	trap 'rm -f "$TEMP_FILE"' EXIT

	echo "Downloading Thorium AVX2..."

	curl -fL \
		--retry 3 \
		--retry-delay 2 \
		"$DOWNLOAD_URL" \
		-o "$TEMP_FILE"

	if [ ! -s "$TEMP_FILE" ]; then
		echo "Downloaded file is empty."
		exit 1
	fi

	NEW_HASH=$(nix hash file --type sha256 "$TEMP_FILE")
fi

if [[ "$NEW_HASH" != sha256-* ]]; then
	echo "Failed to calculate an SRI hash (got: '${NEW_HASH}')."
	exit 1
fi

echo "New Hash: $NEW_HASH"

# Update Nix package
sed -i -E \
	"s|^[[:space:]]*version = \"[^\"]*\";|  version = \"${LATEST_VERSION}\";|" \
	"$NIX_FILE"

sed -i -E \
	"s|^[[:space:]]*url = \"[^\"]*\";|  url = \"${DOWNLOAD_URL}\";|" \
	"$NIX_FILE"

sed -i -E \
	"s|^[[:space:]]*hash = \"[^\"]*\";|  hash = \"${NEW_HASH}\";|" \
	"$NIX_FILE"

# Export update information
{
	echo "UPDATE_DETECTED=true"
	echo "LATEST_VERSION=$LATEST_VERSION"
} >>"$ENV_OUT"

echo
echo "Successfully updated Thorium AVX2."
echo "Version: $LATEST_VERSION"
echo "File:    $NIX_FILE"
