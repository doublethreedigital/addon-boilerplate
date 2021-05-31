# Addon Boilerplate (by Duncan McClean)

# Functions
echo_green() {
    echo $(tput setaf 2) $1 $(tput sgr 0)
}

# Questions
echo_green "Vendor Name (doublethreedigital)"
read VENDOR_NAME
echo ""

echo_green "Addon Name (static-cache-manager)"
read ADDON_NAME
echo ""

echo_green "Composer Package Name (doublethreedigital/static-cache-manager)"
read PACKAGE_NAME
echo ""

echo_green "Namespace Vendor (DoubleThreeDigital)"
read NAMESPACE_VENDOR
echo ""

echo_green "Namespace Addon Name (SimpleCommerce)"
read NAMESPACE_ADDON
echo ""

echo_green "Vendor Email"
read VENDOR_EMAIL
echo ""

echo_green "Addon Description"
read ADDON_DESCRIPTION
echo ""

# Generate a list of file paths
FILE_PATHS=()

for filename in *; do
    if [ -d $filename ]; then
        for filename2 in $filename/*; do
            FILE_PATHS+=("$filename/$filename2")
        done
    fi;

    FILE_PATHS+=($filename)
done

ADDON_PACKAGE_NAME='simple-commerce'

# Find & Replace (loop through all files, and find and replace wildcards)
for FILE_PATH in $FILE_PATHS; do
    echo $FILE_PATH
    FILE_CONTENT=$(cat $FILE_PATH)

    # Replace any wildcards in FILE_CONTENT
    FILE_CONTENT=${FILE_CONTENT//vendor-name/$VENDOR_NAME}
    FILE_CONTENT=${FILE_CONTENT//addon-name/$ADDON_NAME}
    FILE_CONTENT=${FILE_CONTENT//composer-name/$PACKAGE_NAME}
    FILE_CONTENT=${FILE_CONTENT//DummyVendorNamespace/$NAMESPACE_VENDOR}
    FILE_CONTENT=${FILE_CONTENT//DummyAddonNamespace/$NAMESPACE_ADDON}
    FILE_CONTENT=${FILE_CONTENT//vendor-email/$VENDOR_EMAIL}
    FILE_CONTENT=${FILE_CONTENT//addon-description/$ADDON_DESCRIPTION}

    # Write back to file
    echo "$FILE_CONTENT" > $FILE_PATH
done

# Tidy up (move Readme, get rid of script)
rm README.md
mv README.new.md README.md

rm boilerplate.sh

rm -rf .git
git init
git add .
git commit -m "Initial commit"
