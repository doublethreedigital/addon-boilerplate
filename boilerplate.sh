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

# Find & Replace (loop through all files, and find and replace wildcards)
ROOT_PATHS="./*"
ROOT2_PATHS="*/*"

for FILE_PATH in $ROOT_PATHS
do
    if [ -d $FILE_PATH ]; then
        echo "$FILE_PATH is directory. Skipped."
    else
        echo "1 $FILE_PATH"
        find_and_replace_wildcards $FILE_PATH
    fi
done

for FILE_PATH in $ROOT2_PATHS
do
    if [ -d $FILE_PATH ]; then
        echo "$FILE_PATH is directory. Skipped."
    else
        echo "2 $FILE_PATH"
        find_and_replace_wildcards $FILE_PATH
    fi
done

# Tidy up (move Readme, get rid of script)
rm README.md
mv README.new.md README.md

rm boilerplate.sh

rm -rf .git
git init
git add .
git commit -m "Initial commit"
