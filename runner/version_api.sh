#!/bin/sh

sendVersion(){
    MANIFEST="$(cat $2 | sed  's/"/\\"/g')"
    http_response=`curl -X POST "$API_ADDRESS/versions/$1" -H "Content-Type: application/json" -d "{ \"content\": \"$(echo $MANIFEST)\" }" -w %{http_code}`
    http_response=$(echo $http_response | xargs)
    http_status=$(echo $http_response | sed 's/{.*}//g')

    if [ "$http_status" != 200 ] ; then
        echo $http_response;
        exit 1;
    fi
}

fireMessage() {
    http_response=`curl -s -X POST "$API_ADDRESS/wechat/send" -H "Content-Type: application/json" -d "{ \"title\": \"$1\", \"message\": \"$2\" }"`
    echo $http_response
}

fireDeploy() {
    body="{ \"success\": $1, \"projectName\": \"$2\", \"env\": \"$3\", \"branch\": \"$4\", \"version\": \"$5\", \"userName\": \"$6\", \"message\": \"$7\", \"id\": \"$8\" }";
    echo $body
    http_response=`curl -s -X POST "$API_ADDRESS/wechat/deploy" -H "Content-Type: application/json" -d "$body"`
    echo $http_response
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
    sendVersion "$2" "$3"
elif [ "$1" == "fire" ] ; then
    fireContent "$2" "$3"
elif [ "$1" == "deploy" ] ; then 
    fireDeploy "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
elif [ "$1" == "compare" ] ; then
    versionCompare $2 $3
else 
    echo "  "
    echo "Before use, you should be export API_ADDRESS='http://xxxxxxx' first"
    echo "  "
    echo "      Usage: version_api version url json"
    echo "              (Post a new version into server)"
    echo "  "
    echo "          url: :project/:environment/:version"
    echo "          json: { 'xxx': 'xxx' }"
    echo "  "
    echo "  "
    echo "      Usage: version_api deploy success projectName env branch version userName message id"
    echo "              (Send deploy info to business wechat)"
    echo "  "
    echo "  "
    echo "  "
    echo "      Usage: version_api fire status message info"
    echo "              (Send a new message to business wechat)"
    echo "  "
    echo "          message: string message"
    echo "          info: other infos"
    echo "  "
    echo "  "
    echo "      Usage: version_api compare version1 version2"
    echo "              (Compare versions is equal)"
    echo "  "
    echo "  "
fi