# URL Shortner


[SSSHelf](https://github.com/voidfiles/ssshelf) is a library that can turn S3 into a database.

This app implments a URL shortner utilizing ssshelf

## Use

You an run this app on heroku.

You can shorten a URL by POSTing

```
http "https://nameless-ravine-42059.herokuapp.com/new/" "url=http://google.com"

HTTP/1.1 200 OK
Connection: keep-alive
Content-Length: 109
Content-Type: application/json
Date: Mon, 18 Sep 2017 05:25:56 GMT
Server: uvicorn
Via: 1.1 vegur

{
    "original_url": "http://google.com",
    "short_url": "https://nameless-ravine-42059.herokuapp.com/gWslWmdJGWA/"
}
```


