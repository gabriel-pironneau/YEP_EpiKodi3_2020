# Client endpoints


## `POST single file`

Method: `POST`

URL: `127.0.0.1:5000/file`

Note : file must be send as Multipart in the body and the format for the file is *File Content*.

__Accepted formats are .mp3, .png, .vlc & .jpg__

Parameter:

| Part Name    | Value |
|:------- | -------:|
| file | File |

Body example:

```Multipart
{
    file: File Weather.png
}
```

**Response Exemple**:

```json
{
    "status": 200,
    "response": "File Successfully Uploaded"
}
```


## `GET single file`

Method: `GET`

URL: `127.0.0.1:5000/file/:filename`

**Response Exemple**:

```json
{
    "status": 200,
    "file": "127.0.0.1:5000/funny.jpg"
}
```


## `DELETE single file`

Method: `DELETE`

URL: `127.0.0.1:5000/file/:filename`

**Response Exemple**:

```json
{
    "status": 200,
    "response": "File Successfully Deleted"
}
```


## `POST User Datas & File`

Method: `POST`

URL: `127.0.0.1:5000/add`

Parameters:

| Value    | Type |
|:------- | -------:|
| filepath | String |
| id | Number |
| user_id | Number |

Body example:

```json
{
	"id": 4,
	"user_id": 987,
    "filepath": "127.0.0.1:5000/funny.jpg"
}
```

**Response Exemple**:

```json
{
    "success": true
}
```


## `PUT User Datas & File`

Method: `PUT`

URL: `127.0.0.1:5000/update`

Query parameter:

| URL Parameter    | value |
|:------- | -------:|
| id | Number |

Parameters:

| Value    | Type |
|:------- | -------:|
| filepath | String |
| id | Number |
| user_id | Number |

Body example:

```json
{
	"id": 4,
	"user_id": 987,
    "filepath": "127.0.0.1:5000/funny.jpg"
}
```

**Response Exemple**:

```json
{
    "success": true
}
```


## `GET User Files`

Method: `GET`

URL: `127.0.0.1:5000/list`

**Response Exemple**:

```json
[
    {
        "id": 4,
    	"user_id": 987,
        "filepath": "127.0.0.1:5000/funny.jpg"
    },
    {
        "id": 2,
    	"user_id": 9827,
        "filepath": "127.0.0.1:5000/spirituality.jpg"
    },
    "..."
]
```


## `GET User Single File`

Method: `GET`

URL: `127.0.0.1:5000/list`

Query parameter:

| URL Parameter    | value |
|:------- | -------:|
| id | Number |

**Response Exemple**:

```json
{
    "id": 4,
	"user_id": 987,
    "filepath": "127.0.0.1:5000/funny.jpg"
}
```


## `DELETE User Single File`

Method: `DELETE`

URL: `127.0.0.1:5000/delete`

Query parameter:

| URL Parameter    | value |
|:------- | -------:|
| id | Number |

**Response Exemple**:

```json
{
    "success": true
}
```


## `GET Mixcloud Track`

Method: `GET`

URL: `127.0.0.1:5000/mixcloud`

Query parameter:

| URL Parameter    | value |
|:------- | -------:|
| name | String |

**Response Exemple**:

```json
{
    "author": "DJ URB",
	"date": "2019-04-17T02:23:20Z",
    "title": "K Mix 2019 April 17 / KPOP / BLACKPINK / REDVELVET / TWICE / CL / MAMAMOO / BIGBANG / EDM / R'n'B",
    "url": "www.mixcloud.com/djurb-swingup/k-mix-2019-april-17-kpop-blackpink-redvelvet-twice-cl-mamamoo-bigbang-edm-rnb/"
}
```


## `GET YouTube Video`

Method: `GET`

URL: `127.0.0.1:5000/youtube`

Query parameter:

| URL Parameter    | value |
|:------- | -------:|
| name | String |

**Response Exemple**:

```json
{
    "channel_id": "UCqhnX4jA0A5paNd1v-zEysw",
    "channel_title": "GoPro",
    "collection_date": "Fri, 19 Jun 2020 05:12:47 GMT",
    "video_category": null,
    "video_description": "Celebrate International Surf Day with GoPro's Top 10 Surf Moments. Shot 100% on GoPro: http:\/\/bit.ly\/2wUMwfI Get stoked and subscribe: http:\/\/goo.gl\/HgVXpQ ...",
    "video_id": "W7h-Yho8EB0",
    "video_publish_date": 1560604905.0,
    "video_thumbnail": "https:\/\/i.ytimg.com\/vi\/W7h-Yho8EB0\/hqdefault.jpg",
    "video_title": "GoPro: Top 10 Surf Moments"
}
```
