# Client endpoints

## `Send single file`

Method: `POST`

URL: `127.0.0.1:5000/file`

Note : file must be send as Multipart in the body and the format for the file is *File Content*.

__Accepted format are .mp3, .png & .jpg__

Parameters:

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


## `Get single file`

Method: `GET`

URL: `127.0.0.1:5000/file/:filename`


## `Delete single file`

Method: `DELETE`
URL: `127.0.0.1:5000/file/:filename`


**Response Exemple**:

```json
{
    "status": 200,
    "response": "File Successfully Deleted"
}
```
