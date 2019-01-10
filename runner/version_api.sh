#!/bin/sh

sendVersion(){
    MANIFEST="$(cat $2 | sed  's/"/\\"/g')"
    http_response=`curl -X POST "$API_ADDRESS/versions/$1" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"content\": \"$(echo $MANIFEST)\" }" -w %{http_code}`
    http_response=$(echo $http_response | xargs)
    http_status=$(echo $http_response | sed 's/{.*}//g')

    if [ "$http_status" != 200 ] ; then
        echo $http_response;
        exit 1;
    fi
}

fireContent() {
    curl -s -X POST "$API_ADDRESS/wechat/send" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"status\": \"$1\", \"message\": \"$2\", \"info\": \"$3\" }"
}

versionCompare() {
    if [ $1 != $2 ] ; then
        ERROR_MESSAGE="分支版本号：$1 与项目包版本号：$2不匹配！";
        echo $ERROR_MESSAGE
        fireContent "error" "$ERROR_MESSAGE"
        exit 1;
    fi
}

if [ "$1" == "version" ] ; then
    sendVersion $2 $3
elif [ "$1" == "fire" ] ; then
    fireContent $2 $3 $4
elif [ "$1" == "compare" ] ; then
    versionCompare $2 $3
else 
    echo "  "
    echo "Before use, you should be export API_ADDRESS='http://xxxxxxx' first"
    echo "  "
    echo "version_api types type_options"
    echo "  "
    echo "  "
    echo "  types:"
    echo "  "
    echo "      version url json (Post a new version into server)"
    echo "  "
    echo "          url: :project/:environment/:version"
    echo "          json: { 'xxx': 'xxx' }"
    echo "  "
    echo "  "
    echo "      fire status message info (Send a new message to business wechat)"
    echo "  "
    echo "          status: enum (success, error)"
    echo "          message: string message"
    echo "          info: other infos"
    echo "  "
    echo "  "
    echo "      compare version1 version2 (Compare versions is equal)"
    echo "  "
    echo "  "
fi