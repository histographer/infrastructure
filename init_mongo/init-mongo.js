db.createUser({
    user: 'prod_user',
    pwd: 'prod_password',
    roles: [
        {
            role: 'readWrite',
            db: 'wizard'
        }
    ]
})
