complete -C '/usr/bin/aws_completer' aws
source .aws_credentials

#export AWS_ACCESS_KEY_ID=""
#export AWS_SECRET_ACCESS_KEY=""
#export AWS_DEFAULT_REGION=''
#export AWS_DEFAULT_OUTPUT='json'

#
#export ACC=""
#export USER_ARN=""
#export NAMESPACE=""

function list-user(){
    aws quicksight list-users --aws-account-id $ACC --namespace nsdev24
}


function delete-user(){
    aws quicksight delete-user --aws-account-id "$ACC" --namespace nsdev24 --user-name "$1"
}

function delete-group(){
    aws quicksight delete-group --aws-account-id "$ACC" --namespace "$NAMESPACE" --group-name "$1"
}

function user-groups(){
    aws quicksight list-user-groups --aws-account-id "$ACC" --namespace "$NAMESPACE" --user-name "$1"
}

function list-groups(){
    aws quicksight list-groups --aws-account-id "$ACC" --namespace "$NAMESPACE"
}

