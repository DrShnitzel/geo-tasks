# geo-tasks

## Installation

ruby 2.3 or higher and mongoDB are required

`rake setup` to seed the database and create indexes

`rake server` to run server on 8080 port


## Endpoints

All API endpoints are working with json body (not form-data)

### creating a task

_Manager can create tasks with two geo locations pickup and delivery_

`POST /task `

*body:*
``` javascript
  {
    "token": "user_auth_token",
    // longitude goes first
    "pickup_location": [56.45, 70.4],
    "delivery_location": [56.78, 71.4]  
  }
```

*response:*

`200 OK`
``` javascript
  {
    "_id": "5873d9d6117cc20225b6a47f"
  }
```

### getting list of nearest tasks
_Driver can get list of tasks nearby (sorted by distance) by sending his current location_

`POST /tasks/nearby `

*body:*
``` javascript
  {
    "token": "user_auth_token",
    "driver_location": [56.45, 70.4]
  }
```
*response:*

`200 OK`
``` javascript
  [
    {
      "_id": "5873d9d6117cc20225b6a47f",
      "pickup_location": [56.45, 70.4],
      "delivery_location": [56.78, 71.4]
    },
    {
      "_id": "5873d9d6117cc20225b6a47a",
      "pickup_location": [56.44, 70.5],
      "delivery_location": [56.78, 71.4]
    },
    ..
    {
      "_id": "5873d9d6117cc20225b6a47c",
      "pickup_location": [56.48, 70.6],
      "delivery_location": [56.78, 71.4]
    }
  ]
```
### picking a task
_Driver can pick one task from the list (the task becomes assigned)_

`UPDATE /tasks/pick`

``` javascript
{
  "token": "user_auth_token",
  "_id": "5873d9d6117cc20225b6a47a"
}
```

*response:*

`200 OK`
``` javascript
  {
    "_id": "5873d9d6117cc20225b6a47a",
    "status": "Assigned"
  }
```

### complete the task
_Driver can complete picked task (the task becomes done)_

`UPDATE /task/complete`

``` javascript
{
  "token": "user_auth_token"
}
```

*response:*

`200 OK`
``` javascript
  {
    "_id": "5873d9d6117cc20225b6a47a",
    "status": "Done"
  }
```

## Errors

`401 Unauthorized`
``` javascript
  {
    "error": "Permission denied"
  }
```
_User with current token cannot parform this action_

`404 Not Found`
``` javascript
  {
    "error": "Record not found"
  }
```
_Record not found_
