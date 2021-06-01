#!/bin/bash
# 'return' when run as "source <script>" or ". <script>", 'exit' otherwise
[[ "$0" != "${BASH_SOURCE[0]}" ]] && safe_exit="return" || safe_exit="exit"

# Functions
ask_question() {
    # ask_question <question> <default>
    local ANSWER
    read -r -p "$(tput setaf 2) $1 $(tput sgr 0) ($2): " ANSWER
    echo "${ANSWER:-$2}"
}

confirm() {
    # confirm <question> (default = N)
    local ANSWER
    read -r -p "$(tput setaf 2) $1 $(tput sgr 0) (y/N): " -n 1 ANSWER
    echo " "
    [[ "$ANSWER" =~ ^[Yy]$ ]]
}

slugify() {
    # slugify <input> <separator>
    # Jack, Jill & Clémence LTD => jack-jill-clemence-ltd
    # inspiration: https://github.com/pforret/bashew/blob/master/template/normal.sh
    separator="$2"
    [[ -z "$separator" ]] && separator="-"
    # shellcheck disable=SC2020
    echo "$1" |
        tr '[:upper:]' '[:lower:]' |
        tr 'àáâäæãåāçćčèéêëēėęîïííīįìłñńôöòóœøōõßśšûüùúūÿžźż' 'aaaaaaaaccceeeeeeeiiiiiiilnnoooooooosssuuuuuyzzz' |
        awk '{
        gsub(/[\[\]@#$%^&*;,.:()<>!?\/+=_]/," ",$0);
        gsub(/^  */,"",$0);
        gsub(/  *$/,"",$0);
        gsub(/  */,"-",$0);
        gsub(/[^a-z0-9\-]/,"");
        print;
        }' |
        sed "s/-/$separator/g"
}

find_and_replace_wildcards() {
    FILE_PATH=$1
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
}

# Questions
VENDOR_NAME=$(ask_question "Vendor Name" "doublethreedigital")
ADDON_NAME=$(ask_question "Addon Name" "zippy")

NAMESPACE_VENDOR=$(ask_question "Namespace Vendor" "DoubleThreeDigital")
NAMESPACE_ADDON=$(ask_question "Namespace Addon" "Zippy")

VENDOR_EMAIL=$(ask_question "Vendor Email" $(git config user.email))
ADDON_DESCRIPTION=$(ask_question "Addon Description")

PACKAGE_NAME="$(slugify "$VENDOR_NAME" "-")/$(slugify "$ADDON_NAME" "-")"

echo ""
echo -e "------"
echo -e "Composer Package : $PACKAGE_NAME"
echo -e "Addon            : $ADDON_NAME"
echo -e "Vendor           : $VENDOR_NAME"
echo -e "Namespace        : $NAMESPACE_VENDOR/$NAMESPACE_ADDON"
echo -e "Email            : $VENDOR_EMAIL"
echo -e "Description      : $ADDON_DESCRIPTION"
echo -e "------"
echo ""

if ! confirm "Do you wish to go ahead?"; then
    $safe_exit 1
fi

# Find & replace wildcards
ROOT_PATHS="./*"
ROOT2_PATHS="*/*"

for FILE_PATH in $ROOT_PATHS
do
    if [ -d $FILE_PATH ]; then
        echo "$FILE_PATH is directory. Skipped."
    else
        if [ $FILE_PATH != './boilerplate.sh' ]; then
            find_and_replace_wildcards $FILE_PATH
        fi
    fi
done

for FILE_PATH in $ROOT2_PATHS
do
    if [ -d $FILE_PATH ]; then
        echo "$FILE_PATH is directory. Skipped."
    else
        if [ $FILE_PATH != './boilerplate.sh' ]; then
            find_and_replace_wildcards $FILE_PATH
        fi
    fi
done

# Tidy up (move Readme, get rid of script)
rm README.md
mv README.new.md README.md

if confirm "Should this script be deleted?"; then
    rm boilerplate.sh
fi

if confirm "Would you like a fresh Git repository to be initialized?"; then
    rm -rf .git
    git init
    git add .
    git commit -m "Initial commit"
else
    rm -rf .git
fi
