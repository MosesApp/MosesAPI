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
If using POW, you have to add the exports to .powenv file.


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
   "timezone": -2
}
```

#### Groups
Create, get, edit or remove group.

Method |          Endpoint           | Description
-------|-----------------------------|-------------
GET    | /groups/                    | Gets all authenticated user's groups
GET    | /groups/<group_id>          | Gets the group's details
POST   | /groups/                    | Creates the group
PATCH  | /groups/                    | Edits the group
DELETE | /groups/                    | Deletes the group if user is admin

GET /groups response example
```json
{
"groups":[
    {
      "id": 1,
      "name": "New",
      "status": "Active",
    }
  ]
}
```

GET /groups/1 response example
```json
{
  "id": 1,
  "name": "New",
  "status": "Active",
  "admins": [
    {
      "member_id": 3
    }
  ],
  "creator": {
    "id": 3,
    "first_name": "Carlos",
    "full_name": "Carlos Moses",
    "email": "dev@example.com",
    "facebook_id": "21788553421335852",
    "locale": "pt_BR",
    "timezone": -2  
  },
  "members":[
    {
      "id": 3,
      "first_name": "Carlos",
      "full_name": "Carlos Moses",
      "email": "dev@example.com",
      "facebook_id": "21788553421335852",
      "locale": "pt_BR",
      "timezone": -2  
    },
    {
      "id": 1,
      "first_name": "Meta",
      "full_name": "Hattie Orn I",
      "email": "dagmar_schmeler@koch.biz",
      "facebook_id": "100001252336714",
      "locale": "en_US",
      "timezone": 1
    }
  ]
}
```

POST /groups request example
```json
{
  "group":
    {
      "name": "New",
      "creator_id": 1,
      "status": "Active",
      "add_members":[
        {
          "id":"1",
          "is_admin":true
        },
        {
          "id":"4",
          "is_admin":false
        }
      ]
    }
}
```
PATCH /groups/1 request example
```json
{
  "group":
   {
     "name": "New",
     "creator_id": 1,
     "status": "Active",
     "add_members":[
       {
         "id":"1",
         "is_admin":true
       },
       {
         "id":"4",
         "is_admin":false
       }
     ],
     "remove_members":[
       {
         "id":"3",
         "is_admin":true
       }
     ]
   }
}
```

#### Bills
Create, get, edit or remove bill.

Method |          Endpoint           | Description
-------|-----------------------------|-------------
GET    | /bills/                     | Gets all authenticated user's bills
GET    | /bills/<group_id>           | Gets the bill's details

GET /bills/ response example
```json
{
  "bills":[
    {
      "id": 1,
      "name": "dreamcatcher",
      "amount": 11.73,
      "created_at": "2016-02-21T00:49:57.367Z",
      "currency":
        {
          "prefix": "$"
        }
    }
  ]
}
```

GET /bill/1 response example
```json
{
  "id": 1,
  "name": "stumptown",
  "description": "Wolf whatever locavore synth messenger bag American Apparel art stumptown.",
  "amount": 96.48,
  "created_at": "2016-02-21T00:49:58.037Z",
  "currency":
    {
      "prefix": "$"
    },
  "group":
    {
      "id":1,
      "name":"Portland",
      "avatar":"/avatars/original/missing.png",
      "status":"Active"
    }
}
```
