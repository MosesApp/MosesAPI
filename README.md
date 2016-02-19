# MosesAPI

## Installation

### Domain
Using **Pow** for OSX or **Pax** for GNU/Linux.

#### Pow (for OSX)

```
$ curl get.pow.cx | sh
$ cd ~/.pow
$ ln -s ~/workspace/MosesAPI
```

#### Pax (for linux)

```
$ sudo git clone git://github.com/ysbaddaden/prax.git /opt/prax

$ cd /opt/prax/
$ ./bin/prax install  
$ cd ~/workspace/MosesAPI
$ prax link

$ prax start
```
[Reference](http://apionrails.icalialabs.com/book/chapter_one#sec-pow_prax)

#### ImageMagick
Used by PaperClip gem.

```
brew install imagemagick
```

#### Export environment variables

Set the Facebook variables.
```
export FACEBOOK_APP_ID=<facebook_app_id>
export FACEBOOK_APP_SECRET=<facebook_app_secreat>
```


## API

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
All subsequent call will be authenticated by the Authorization header:

```
Authorization: Bearer 09da8218e7f3ed0bbc3aa53586fd0221333f68510b5290b1ffe4e10dd11ea5d7
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
GET    | /group/                     | Gets all authenticated user's groups
GET    | /group/<group_id>           | Gets the group
POST   | /group/                     | Creates the group

GET /group/ response example
```json
{
"groups":[
    {
      "id": 1,
      "name": "New",
      "creator_id": 1,
      "status": "Active",
      "created_at": "2016-02-18T00:22:20.420Z",
      "updated_at": "2016-02-18T00:22:20.420Z"
    }
  ]
}
```

GET /group/1 response example
```json
{
  "id": 1,
  "name": "New",
  "creator_id": 1,
  "status": "Active",
  "created_at": "2016-02-18T00:22:20.420Z",
  "updated_at": "2016-02-18T00:22:20.420Z"
}
```

POST /group request example
```json
{
  "id": 1,
  "name": "New",
  "creator_id": 1,
  "status": "Active",
  "created_at": "2016-02-18T00:22:20.420Z",
  "updated_at": "2016-02-18T00:22:20.420Z",
  "members":[
    {"id":"1", "is_admin":true},
    {"id":"4", "is_admin":false}
  ]
}
```
