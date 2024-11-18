complete -C '/usr/bin/aws_completer' aws
if [ -f "$HOME/.aws_params" ]; then
    source "$HOME/.aws_params"
else
    echo "Error: $HOME/.aws_params file not found. Please create it with the following variables:"
    echo "export AWS_ACCESS_KEY_ID=\"\""
    echo "export AWS_SECRET_ACCESS_KEY=\"\""
    echo "export AWS_DEFAULT_REGION=''"
    echo "export AWS_DEFAULT_OUTPUT='json'"
    echo "export ACC=\"\""
    echo "export USER_ARN=\"\""
    echo "export NAMESPACE=\"\""
fi

function list-users(){
    aws quicksight list-users \
    --aws-account-id "$ACC" \
    --namespace nsdev24
}

function delete-user(){
    aws quicksight delete-user \
    --aws-account-id "$ACC" \
    --namespace nsdev24 \
    --user-name "$1"
}

function delete-group(){
    aws quicksight delete-group \
    --aws-account-id "$ACC" \
    --namespace "$NAMESPACE" \
    --group-name "$1"
}

function user-groups(){
    aws quicksight list-user-groups \
    --aws-account-id "$ACC" \
    --namespace "$NAMESPACE" \
    --user-name "$1"
}

function list-groups(){
    aws quicksight list-groups \
    --aws-account-id "$ACC" \
    --namespace "$NAMESPACE"
}

function generate-embedded-url-for-registered-user(){
    local user_arn=$1
    local asset_region=$2
    local region=${2:-$AWS_DEFAULT_REGION}
    aws quicksight generate-embed-url-for-registered-user \
        --aws-account-id "$ACC" \
        --region "$asset_region" \
        --session-lifetime-in-minutes 30 \
        --user-arn "$user_arn" \
        --experience-configuration '{"QuickSightConsole": {"InitialPath": "/start"}}'
}

function generate-session-url(){
    local user_arn=$1
    local region=${2:-$AWS_DEFAULT_REGION}
    aws quicksight generate-embed-url-for-registered-user \
        --aws-account-id "$ACC" \
        --region "$region" \
        --user-arn "$user_arn"
}