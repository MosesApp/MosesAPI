## MosesAPI

#### OAuth
Authenticate using Facebook token.
User will be automatically registered in Moses service if not already registered.

Method |          Endpoint           | Description
-------|-----------------------------|-------------
POST   | /oauth/token/               | Get authentication token

Parameters:
```
    grant_type: assertion
    token: <facebook token>
```

Response example:
```json
{
  "access_token": "09da8218e7f3ed0bbc3aa53586fd0221333f68510b5290b1ffe4e10dd11ea5d7",
  "token_type": "bearer",
  "expires_in": 7200,
  "created_at": 1455051683
}
```

#### Users
Get, edit or remove an user.

Method |          Endpoint           | Description
-------|-----------------------------|-------------
GET    | /user/                      | Gets the authenticated user
PUT    | /user/                      | Edits the authenticated user
DELETE | /user/                      | Deletes the authenticated user

GET response example:
```json
{
   "id": 3,
   "first_name": "Carlos",
   "full_name": "Carlos Moses",
   "email": "dev@example.com",
   "facebook_id": "21788553421335852",
   "locale": "pt_BR",
   "timezone": -2,
   "created_at": "2016-02-09T18:52:29.181Z",
   "updated_at": "2016-02-09T18:52:29.181Z"
}
```

#### Groups
Create, get, edit or remove group.

Method |          Endpoint           | Description
-------|-----------------------------|-------------
GET    | /group/<group_id>           | Gets the group
