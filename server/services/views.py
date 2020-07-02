from youtube_api import YouTubeDataAPI
from flask import Flask, request
from file_transfer import app
import requests

YT_KEY ='AIzaSyBmQsTIX2RCJQIkkBLA95UNfqlaS4Jbs9Q'
yt = YouTubeDataAPI(YT_KEY)

@app.route('/youtube', methods = ['GET'])
def youtube():
    searches = yt.search(q=request.args.get('name'),
    max_results=10)
    return str(searches), 200

@app.route('/mixcloud', methods = ['GET'])
def mixcloud():
    allmusic = {}
    response = requests.get("https://api.mixcloud.com/search/?q={}&type=cloudcast".format(request.args.get('name')))
    music = { "music0":{
        "date": response.json()['data'][0]['created_time'],
        "title": response.json()['data'][0]['name'],
        "url": response.json()['data'][0]['url'],
        "author": response.json()['data'][0]['user']['name'],
        "thumbnail": response.json()['data'][0]['pictures']['medium']
    },"music1":{
        "date": response.json()['data'][1]['created_time'],
        "title": response.json()['data'][1]['name'],
        "url": response.json()['data'][1]['url'],
        "author": response.json()['data'][1]['user']['name'],
        "thumbnail": response.json()['data'][1]['pictures']['medium']
    },"music2":{
        "date": response.json()['data'][2]['created_time'],
        "title": response.json()['data'][2]['name'],
        "url": response.json()['data'][2]['url'],
        "author": response.json()['data'][2]['user']['name'],
        "thumbnail": response.json()['data'][2]['pictures']['medium']
    },"music3":{
        "date": response.json()['data'][3]['created_time'],
        "title": response.json()['data'][3]['name'],
        "url": response.json()['data'][3]['url'],
        "author": response.json()['data'][3]['user']['name'],
        "thumbnail": response.json()['data'][3]['pictures']['medium']
    },"music4":{
        "date": response.json()['data'][4]['created_time'],
        "title": response.json()['data'][4]['name'],
        "url": response.json()['data'][4]['url'],
        "author": response.json()['data'][4]['user']['name'],
        "thumbnail": response.json()['data'][4]['pictures']['medium']
    },"music5":{
        "date": response.json()['data'][5]['created_time'],
        "title": response.json()['data'][5]['name'],
        "url": response.json()['data'][5]['url'],
        "author": response.json()['data'][5]['user']['name'],
        "thumbnail": response.json()['data'][5]['pictures']['medium']
    },"music6":{
        "date": response.json()['data'][6]['created_time'],
        "title": response.json()['data'][6]['name'],
        "url": response.json()['data'][6]['url'],
        "author": response.json()['data'][6]['user']['name'],
        "thumbnail": response.json()['data'][6]['pictures']['medium']
    },"music7":{
        "date": response.json()['data'][7]['created_time'],
        "title": response.json()['data'][7]['name'],
        "url": response.json()['data'][7]['url'],
        "author": response.json()['data'][7]['user']['name'],
        "thumbnail": response.json()['data'][7]['pictures']['medium']
    },"music8":{
        "date": response.json()['data'][8]['created_time'],
        "title": response.json()['data'][8]['name'],
        "url": response.json()['data'][8]['url'],
        "author": response.json()['data'][8]['user']['name'],
        "thumbnail": response.json()['data'][8]['pictures']['medium']
    },}
    return music, 200

if __name__ == "__main__":
    app.run()
