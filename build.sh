#!/bin/sh
 
SDK="iphoneos"
CONFIGURATION="Release"

PRODUCT_NAME="Shrimp"

PROJECT_FILE="${PRODUCT_NAME}.xcodeproj"
TARGET_NAME="${PRODUCT_NAME}"
SCHEME_NAME="${PRODUCT_NAME}"
IPA_FILE_NAME="${PRODUCT_NAME}"
OUT_APP_DIR="out"
OUT_IPA_DIR="out"
PROVISIONING_PATH="${HOME}/Library/MobileDevice/Provisioning\ Profiles/48b28118-a045-419f-b63a-baf11fa86bae.mobileprovision"
if [ ! -d ${OUT_IPA_DIR} ]; then
    mkdir "${OUT_IPA_DIR}"
fi
 
## when using xcworkspace 
# WORKSPACE_File="SampleApp.xcworkspace"
# xcodebuild clean -workspace "${WORKSPACE_FILE}" -scheme "${SCHEME_NAME}"
# xcodebuild -workspace "${WORKSPACE_FILE}" -scheme "${SCHEME_NAME}" -sdk "${SDK}" -configuration "${CONFIGURATION}" install DSTROOT="${OUT_APP_DIR}"
 
xcodebuild clean -project "${PROJECT_FILE}" -scheme "${SCHEME_NAME}"
xcodebuild -project "${PROJECT_FILE}" -scheme "${SCHEME_NAME}" -sdk "${SDK}" -configuration "${CONFIGURATION}" install DSTROOT="${OUT_APP_DIR}"
xcrun -sdk "${SDK}" PackageApplication "${PWD}/${OUT_APP_DIR}/Applications/${PRODUCT_NAME}.app" -o "${PWD}/${OUT_IPA_DIR}/${IPA_FILE_NAME}.ipa" -embed "${PROVISIONING_PATH}"