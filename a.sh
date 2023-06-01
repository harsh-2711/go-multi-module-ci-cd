echo "::group::Detecting changed packages"
CHANGED_PACKAGES=$(git diff --name-only ${{ github.event.before }}..${{ github.sha }} | grep '^packages/' | cut -d/ -f2 | sort -u || '')
echo "Changed packages: $CHANGED_PACKAGES"
echo "::endgroup::"
if [[ -z "$CHANGED_PACKAGES" ]]; then
	echo "No changes detected in packages, exiting"
	exit 0
fi