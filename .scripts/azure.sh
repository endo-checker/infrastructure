# App Registration - sp-deployment

az ad sp create-for-rbac \
    --name "sp-deployment-stg" \
    --role='contributor' \
    --scopes /subscriptions/4e6ec3dd-7f2a-4679-86fc-1cc8297b48cd
