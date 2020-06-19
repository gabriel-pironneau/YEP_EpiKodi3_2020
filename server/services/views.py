from youtube_api import YouTubeDataAPI
from flask import Flask, request
from file_transfer import app
import requests

YT_KEY ='AIzaSyBmQsTIX2RCJQIkkBLA95UNfqlaS4Jbs9Q'
yt = YouTubeDataAPI(YT_KEY)

@app.route('/youtube', methods = ['GET'])
def youtube():
    searches = yt.search(q=request.args.get('name'),
    max_results=5)
    return searches[0], 200

@app.route('/mixcloud', methods = ['GET'])
def mixcloud():
    music = {}
    response = requests.get("https://api.mixcloud.com/search/?q={}&type=cloudcast".format(request.args.get('name')))
    music = {
        "date": response.json()['data'][0]['created_time'],
        "title": response.json()['data'][0]['name'],
        "url": response.json()['data'][0]['url'],
        "author": response.json()['data'][0]['user']['name']
    }
    return music, 200

if __name__ == "__main__":
    app.run()
