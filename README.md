
# Documentation

## API Endpoints


### Authentication Header:

`Authorization: jwt.token.here`

## JSON Objects returned by API:


### Profile

```JSON
{
  "profile": {
  	"id": 1,
    "name": "djkhaled",
    "email": "djkhaled@wethebest.com",
    "you_follow": true,
    "follows_you": false,
    "following": 200,
    "followers": 100
  }
}
```

### Token

```JSON
{
  "auth": {
  	"jwt": <YOUR JWT TOKEN>
  }
}
```

### Single Post

```JSON
{
  "post": {
    "id": 1,
    "slug": "the-keys-to-success",
    "title": "The Keys To Success",
    "url": "imgur.com/dg26gs",
    "tagList": ["djkhaled", "asahd", "major keys"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "liked": false,
    "likes": 234,
    "author": {
  	"id": 1,
    "name": "djkhaled",
    "email": "djkhaled@wethebest.com",
    "you_follow": true,
    "follows_you": false,
    "following": 200,
    "followers": 100
  }
  }
}
```

### Multiple Posts

```JSON
{
  "posts":[{
    "id": 1,
    "slug": "the-keys-to-success",
    "title": "The Keys To Success",
    "url": "imgur.com/dg26gs",
    "tagList": ["djkhaled", "asahd", "major keys"],
    "createdAt": "2016-02-18T03:22:56.637Z",
    "updatedAt": "2016-02-18T03:48:35.824Z",
    "liked": false,
    "likes": 234,
    "author": {
  	"id": 1,
    "name": "djkhaled",
    "email": "djkhaled@wethebest.com",
    "you_follow": true,
    "follows_you": false,
    "following": 200,
    "followers": 100
  },
   {
    "id": 2,
    "slug": "has-the-drake-vocals-come-in-yet",
    "title": "Has The Drake Vocals Come In Yet",
    "url": "imgur.com/dg26gs",
    "tagList": ["djkhaled", "asahd", "major keys", "grateful"],
    "createdAt": "2016-07-18T03:22:56.637Z",
    "updatedAt": "2016-07-18T03:48:35.824Z",
    "liked": false,
    "likes": 264,
    "author": {
  	"id": 1,
    "name": "djkhaled",
    "email": "djkhaled@wethebest.com",
    "you_follow": true,
    "follows_you": false,
    "following": 200,
    "followers": 100
  }
  ],
  "count": 2
}
```


### List of Tags

```JSON
{
  "tags": [
    "djkhaled",
    "asahd",
    "drake"
  ]
}
```

### Errors and Status Codes

If a request fails any validations, expect a 422 and errors in the following format:

```JSON
{
  "errors":{
    "body": [
      "can't be empty"
    ]
  }
}
```

#### Other status codes:

401 for Unauthorized requests, when a request requires authentication but it isn't provided

403 for Forbidden requests, when a request may be valid but the user doesn't have permissions to perform the action

404 for Not found requests, when a resource can't be found to fulfill the request


## Endpoints:

### Authentication:

`POST /api/v1/token`

Example request body:
```JSON
{
  "user":{
    "email": "djkhaled@wethebest.com",
    "password": "ILOVEYOUASAHD"
  }
}
```

No authentication required, returns a [User](#users-for-authentication)

Required fields: `email`, `password`


### Registration:

`POST /api/v1/users`

Example request body:
```JSON
{
  "user":{
    "name": "djkhaled",
    "email": "djkhaled@wethebest.com",
    "password": "ILOVEYOUASAHD"
  }
}
```

No authentication required, returns a [User](#users-for-authentication)

Required fields: `email`, `name`, `password`



### Get Current User

`GET /api/v1/user`

Authentication required, returns a [User](#users-for-authentication) that's the current user



### Update User

`PUT /api/v1/user`

Example request body:
```JSON
{
  "user":{
	"name": "djkhaledmusic"
  }
}
```

Authentication required, returns the [User](#users-for-authentication)


Accepted fields: `email`, `name`, `password`


### All Profiles
`GET /api/v1/profiles`

Authentication optional, returns a list of all profiles



### Get Profile

`GET /api/v1/profiles/:username`

Authentication optional, returns a [Profile](#profile)



### Get Profile Followers

`GET /api/v1/profiles/:username/followers`

Authetication optional, returns lists of profile who follow :username

### Get Profile Follows

`GET /api/v1/profiles/:username/following`

Authetication optional, returns lists of profile whom :username follow 



### Follow user

`POST /api/v1/profiles/:username/follow`

Authentication required, returns a [Profile](#profile)

No additional parameters required



### Unfollow user

`DELETE /api/v1/profiles/:username/follow`

Authentication required, returns a [Profile](#profile)

No additional parameters required



### List posts

`GET /api/v1/posts`

Returns most recent posts globally by default, provide `tag`, `author` or `liked` query parameter to filter results

Query Parameters:

Filter by tag:

`?tag=memes`

Filter by author:

`?author=djkhaled`

Liked by user:

`?liked=asahdkhaled`

Limit number of posts (default is 25):

`?limit=20`

Offset/skip number of posts (default is 0):

`?offset=0`

Authentication optional, will return [multiple posts](#multiple-posts)



### Feed posts

`GET /api/v1/posts/feed`

Can also take `limit` and `offset` query parameters like [List posts](#list-posts)

Authentication required, will return [multiple posts](#multiple-posts) created by followed users


### Get Post

`GET /api/v1/posts/:slug`

No authentication required, will return [single Post](#single-Post)

### Create Post

`POST /api/v1/posts`

Example request body:

```JSON
{
  "Post": {
    "title": "The key is to believe. smh",
    "url": "imgur.com/5f4dd",
    "tagList": ["khaledquotes", "djkhaled", "wethebest"]
  }
}
```

Authentication required, will return an [Post](#single-Post)

Required fields: `title`, `url`

Optional fields: `tagList` as an array of Strings



### Update Post

`PUT /api/v1/posts/:slug`

Example request body:

```JSON
{
  "Post": {
    "title": "MY SON ASAHD"
  }
}
```

Authentication required, returns the updated [Post](#single-Post)

Optional fields: `title`, `url`

The `slug` also gets updated when the `title` is changed


### Delete Post

`DELETE /api/v1/posts/:slug`

Authentication required



### Liked Posts

`GET /api/v1/posts/liked`

Authentication required. returns list of liked posts by current user




### Like Post

`POST /api/v1/posts/:slug/vote`

Authentication required, returns the [Post](#single-Post)

No additional parameters required



### Unlike Post

`DELETE /api/v1/posts/:slug/vote`

Authentication required, returns the [Post](#single-Post)

No additional parameters required



### Get Tags

`GET /api/v1/tags`

No authentication required, returns a [List of Tags](#list-of-tags)
