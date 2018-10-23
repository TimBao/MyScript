#! /bin/bash

POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -t|--template)
    TEMPLATE="$2"
    shift # past argument
    shift # past value
    ;;
    -m|--mode)
    MODE="$2"
    shift # past argument
    shift # past value
    ;;
    --default)
    DEFAULT=YES
    shift # past argument
    ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters
echo ${POSITIONAL}

echo FILE TEMPLATE  = "${TEMPLATE}"
echo MODE           = "${MODE}"
echo DEFAULT        = "${DEFAULT}"

if [[ "${DEFAULT}" = "YES" ]]; then
    echo "set default model"
    MODE=portrait
    TEMPLATE=default.png
fi

basepath=$(cd `dirname $0`; pwd)
TEMPLATE="${basepath}/${TEMPLATE}"
echo "input image ${TEMPLATE}, mode is ${MODE}"

if [ -f "${TEMPLATE}" ]
then
    if [[ "${MODE}" = "portrait" ]]; then
        echo "protrait"
        # iPhone 3.5" @2x
        sips -Z 960 -c 960 640 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default640x960.png
        # iPhone 4.0" @2x
        sips -Z 1136 -c 1136 640 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default640x1136.png
        # iPhone 5.5" @3x - portrait
        sips -Z 2208 -c 2208 1242 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1242x2208.png
        # iPhone 4.7" @2x
        sips -Z 1334 -c 1334 750 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default750x1334.png
        # iPhone X @3x - portrait
        sips -Z 2436 -c 2436 1125 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1125x2436.png
        # iPhone XS Max --portrait 1242px × 2688px
        sips -Z 2688 -c 2688 1242 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1242x2688.png
        # iPhone XR - portrait  828px × 1792px
        sips -Z 1792 -c 1792 828 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default828x1792.png
        # iPad @2x - portrait
        sips -Z 2048 -c 2048 1536 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1536x2048.png
        # iPad @1x - portrait
        sips -Z 1024 -c 1024 768 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default768x1024.png
    else
        echo "landscape"
        # iPhone 3.5" @2x
        sips -Z 960 -c 640 960 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default960x640.png
        # iPhone 4.0" @2x
        sips -Z 1136 -c 640 1136 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1136x640.png
        # iPhone 5.5" @3x
        sips -Z 2208 -c 1242 2208 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default2208x1242.png
        # iPhone 4.7" @2x
        sips -Z 1334 -c 750 1334 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1334x750.png
        # iPhone X @3x
        sips -Z 2436 -c 2436 1125 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default2436x1125.png
        # iPhone XS Max
        sips -Z 2688 -c 2688 1242 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1242x2688.png
        # iPhone XR
        sips -Z 1792 -c 828 1792 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1792x828.png
        # iPad @2x
        sips -Z 2048 -c 1536 2048 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default2048x1536.png
        # iPad @1x
        sips -Z 1024 -c 768 1024 ${TEMPLATE} --out Images.xcassets/LaunchImage.launchimage/Default1024x768.png
    fi
else
    echo "${TEMPLATE} not found."
fi
