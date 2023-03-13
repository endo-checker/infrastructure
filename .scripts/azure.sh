# App Registration - sp-deployment

az ad sp create-for-rbac \
    --name "sp-deployment-stg" \
    --role='contributor' \
    --scopes /subscriptions/2da318e2-604b-4f60-8984-b801b824a602
