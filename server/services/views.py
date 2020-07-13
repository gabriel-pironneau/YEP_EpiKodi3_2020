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

@app.route('/moovieP', methods = ['GET'])
def moovieP():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/movie/popular?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(page))
    response = response.json()
    return response, 200

@app.route('/moovieTR', methods = ['GET'])
def moovieTR():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/movie/top_rated?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(page))
    response = response.json()
    return response, 200

@app.route('/moovieL', methods = ['GET'])
def moovieL():
    response = requests.get("https://api.themoviedb.org/3/movie/latest?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US")
    response = response.json()
    return response, 200

@app.route('/moovieU', methods = ['GET'])
def moovie():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/movieU/upcoming?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(page))
    response = response.json()
    return response, 200

@app.route('/moovieI', methods = ['GET'])
def moovieI():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/movie/{}?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/moovieIm', methods = ['GET'])
def moovieIm():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/movie/{}/images?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/moovieV', methods = ['GET'])
def moovieV():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/movie/{}/videos?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/moovieT', methods = ['GET'])
def moovieT():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/movie/{}/translations?api_key=11f023b66259527a0866e4845fd0f3bb".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/moovieR', methods = ['GET'])
def moovieR():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/movie/{}/recommendations?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(request.args.get("id"), page))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/moovieS', methods = ['GET'])
def moovieS():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/movie/{}/similar?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(request.args.get("id"), page))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/moovieD', methods = ['GET'])
def moovieD():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/discover/movie?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&sort_by=popularity.desc&include_adult=false&page={}".format(page))
    response = response.json()
    return response, 200



@app.route('/tvP', methods = ['GET'])
def tvP():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/tv/popular?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(page))
    response = response.json()
    return response, 200

@app.route('/tvTR', methods = ['GET'])
def tvTR():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/tv/top_rated?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(page))
    response = response.json()
    return response, 200

@app.route('/tvL', methods = ['GET'])
def tvL():
    response = requests.get("https://api.themoviedb.org/3/tv/latest?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US")
    response = response.json()
    return response, 200

@app.route('/tvI', methods = ['GET'])
def tvI():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/tv/{}?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/tvIm', methods = ['GET'])
def tvIm():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/tv/{}/images?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/tvV', methods = ['GET'])
def tvV():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/tv/{}/videos?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/tvT', methods = ['GET'])
def tvT():
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/tv/{}/translations?api_key=11f023b66259527a0866e4845fd0f3bb".format(request.args.get("id")))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/tvR', methods = ['GET'])
def tvR():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/tv/{}/recommendations?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(request.args.get("id"), page))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/tvS', methods = ['GET'])
def tvS():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    if (request.args.get("id")):
        response = requests.get("https://api.themoviedb.org/3/tv/{}/similar?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&page={}".format(request.args.get("id"), page))
        response = response.json()
        return response, 200
    else:
        return "error, no id"

@app.route('/tvD', methods = ['GET'])
def tvD():
    page = 1
    if (request.args.get("page")):
        page = request.args.get("page")
    response = requests.get("https://api.themoviedb.org/3/discover/tv?api_key=11f023b66259527a0866e4845fd0f3bb&language=en-US&sort_by=popularity.desc&include_adult=false&page={}".format(page))
    response = response.json()
    return response, 200


if __name__ == "__main__":
    app.run()
