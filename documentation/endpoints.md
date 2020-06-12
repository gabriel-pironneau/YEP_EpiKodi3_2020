# Client endpoints

## `Sign Up`

Method: `POST`
URL: `localhost:3000/api/auth/signup`
Parameters:


| Value    | Type |
|:------- | -------:|
| email | string |
| password | string |


Body example:

```json
{
	"email": "bryan.molly@deep.com",
	"password": "test123"
}
```

**Response Exemple**:

```json
{
    "status": 201,
    "msg": "User added successfully !"
}
```

## `Log In`

Method: `POST`
URL: `localhost:3000/api/auth/login`
Parameters:


| Value    | Type |
|:------- | -------:|
| email | string |
| password | string |


Body example:

```json
{
	"email": "bryan.molly@deep.com",
	"password": "test123"
}
```

**Response Exemple**:

```json
{
    "status": 200,
    "userId": "5ebe06e7b39f0045641ec7be",
    "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI1ZWJlMDZlN2IzOWYwMDQ1NjQxZWM3YmUiLCJpYXQiOjE1ODk5Mjg0MzcsImV4cCI6MTU5MDAxNDgzN30.2ADh7uNW_4L1LpCkJJmXHUNfO4EK92yWsdlWfoEeze"
}
```

## `get sport articles`

Method: `GET`
URL: `localhost:3000/api/articles/sport`


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
[
    {
        "status": 200,
        "Id": 0,
        "Tags": "Sports",
        "Desc": "Tuesday’s vote will prevent teams from blocking assistant coaches and executives who plan to interview for new jobs. But team owners tabled a measure to upgrade the draft status of franchises that hire nonwhite candidates for leadership positions.",
        "Title": "N.F.L. Team Owners Enhance Rooney Rule, but Stop Short of Incentives",
        "Source": "The New York Times",
        "Link": "https://www.nytimes.com/2020/05/19/sports/football/nfl-rooney-rule-minority-coaches.html",
        "Author": "By Ken Belson",
        "Date": "19/5/2020",
        "Image": "https://static01.nyt.com/images/2020/05/19/sports/19nfl-meeting/merlin_168049419_e6a395df-0391-4db7-b302-65a3f87612d0-articleLarge.jpg"
    },
    "..."
]
```

## `get science articles`

Method: `GET`
URL: `localhost:3000/api/articles/science`


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |

**Response Exemple**:

```json
[
    {
        "status": 200,
        "Id": 0,
        "Tags": "Science",
        "Desc": "The large reptiles make decoy nests to distract predators during an oft-ignored behavior following their egg laying, researchers say.",
        "Title": "Mother Sea Turtles Might Be Sneakier Than They Look",
        "Source": "The New York Times",
        "Link": "https://www.nytimes.com/2020/05/19/science/sea-turtles-decoy-nests.html",
        "Author": "By David Waldstein",
        "Date": "19/5/2020",
        "Image": "https://static01.nyt.com/images/2020/05/19/science/19TB-SEATURTLES1/merlin_172460943_6538f4e4-77fd-4a18-89e7-13d5eff092f8-articleLarge.jpg"
    },
    "..."
]
```

## `get culture articles`

Method: `GET`
URL: `localhost:3000/api/articles/culture`


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
[
    {
       "status": 200,
       "Id": 0,
       "Tags": "Culture",
       "Desc": "How do you get discovered in a teetering art world? Graduating students organize shows with peers, team up with dealers — and lobby for relief funds. Will they bring change?",
       "Title": "Newly Minted Artists, Facing a Precarious Future, Take Action",
       "Source": "The New York Times",
       "Link": "https://www.nytimes.com/2020/05/19/arts/design/art-schools-covid.html",
       "Author": "By Hilarie M. Sheets",
       "Date": "19/5/2020",
       "Image": "https://static01.nyt.com/images/2020/05/20/arts/20artschool-virus1/20artschool-virus1-articleLarge.jpg"
    },
    "..."
]
```

## `get travel articles`

Method: `GET`
URL: `localhost:3000/api/articles/travel`


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
[
    {
        "status": 200,
        "Id": 19,
        "Tags": "Travel",
        "Desc": "New polling shows 35% of Australians are now less likely to travel overseas, regardless of open borders. How will domestic travel fare?",
        "Title": "Special deals and domestic travel: 'The world has shrunk, but not necessarily in a bad way'",
        "Source": "theguardian.com",
        "Link": "https://www.theguardian.com/travel/2020/may/17/special-deals-and-domestic-travel-the-world-has-shrunk-but-not-necessarily-in-a-bad-way",
        "Author": "Celina Ribeiro",
        "Date": "16/5/2020",
        "Image": "https://media.guim.co.uk/e1c1fa29a972a2c7329e90bef750c677dcd8d398/0_0_4898_2940/500.jpg"
    },
    "..."
]
```

## `get business articles`

Method: `GET`
URL: `localhost:3000/api/articles/business`


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
[
    {
        "status": 200,
        "Id": 19,
        "Tags": "Business",
        "Desc": "Government sets out plan to cut tariffs, with farming and car industry to be protected",
        "Title": "UK businesses urge PM to seal post-Brexit EU free trade deal",
        "Source": "The Guardian",
        "Link": "https://www.theguardian.com/business/2020/may/19/uk-farming-car-industry-brexit-trade-cut-tariffs-import-duties",
        "Author": "Larry Elliott",
        "Date": "19/5/2020",
        "Image": "https://media.guim.co.uk/4c31a29c676db99640699d96cdbfaa1f94c9b84d/0_54_3500_2101/500.jpg"
    },
    "..."
]
```

# Feed

## `get popular articles`

Method: `GET`
URL: `localhost:3000/api/articles/popular`

Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
[
    {
        "Id": 0,
        "Tags": [
            "world",
            "US"
        ],
        "Desc": "Doctors fear a lockdown that began two months ago is being eased too soon. In Indonesia, the caseload has doubled since early May to nearly 25,000.",
        "Title": "Caseloads Soar Amid Reopenings in India and Beyond: Live Coverage",
        "Source": "New York Times",
        "Link": "https://www.nytimes.com/2020/05/29/world/coronavirus-news.html",
        "Author": "John Prime",
        "Date": "29/5/2020",
        "Image": "https://static01.nyt.com/images/2020/05/29/world/29virus-int-briefing-india/29virus-int-briefing-india-thumbLarge.jpg"
    },
    {
        "Id": 2,
        "Tags": [
            "Global development",
            "US"
        ],
        "Desc": "A high school student was convicted on the grounds that failing to seek antenatal care amounted to murder, after giving birth in a bathroom in 2016",
        "Title": "El Salvador teen rape victim sentenced to 30 years in prison after stillbirth",
        "Source": "theguardian.com",
        "Link": "https://www.theguardian.com/global-development/2017/jul/06/el-salvador-teen-rape-victim-sentenced-30-years-prison-stillbirth",
        "Author": "Nina Lakhani",
        "Date": "4/3/2019",
        "Image": "https://media.guim.co.uk/b171ce504b5e299ab806046cf98e4db59460f473/0_0_5568_3341/500.jpg"
    }
    "..."
]
```

# Favorite (Link To MongoDB)

## `Add Article`

Method: `POST`
URL: `localhost:3000/api/favorite/article`
<<<<<<< HEAD

Authorization:


| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


Parameters:


| Value    | Type |
|:------- | -------:|
| Id | Number |
| Tag | String |
| Link | String |
| Image | String |
| Desc | String |
| Source | String |
| Author | String |
| Date | String |


Body example:

```json
{
	"Id": 9,
	"Tag": ["technology", "test"],
	"Title": "beautiful tech",
	"Link": "http://at.com",
	"Image": "http://zaeaz",
	"Desc": "Tech Discovery",
	"Source": "New York Times",
	"Author": "Steve Kane",
	"Date": "01/02/2020"
}
```

**Response Exemple**:

```json
{
    "status": 201,
    "msg": "Article saved successfully !"
}
```

## `Add Tag`

Method: `POST`
URL: `localhost:3000/api/favorites/tag`
Authorization:


| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


=======
>>>>>>> master
Parameters:


| Value    | Type |
|:------- | -------:|
| Id | Number |
<<<<<<< HEAD
| Tag | String |
=======
| Tag | Title |
>>>>>>> master


Body example:

```json
{
<<<<<<< HEAD
    "Id": 20,
    "Tag": "business"
=======
	"email": "bryan.molly@deep.com",
	"password": "test123"
>>>>>>> master
}
```

**Response Exemple**:

```json
{
    "status": 201,
<<<<<<< HEAD
    "msg": "Tag saved successfully !"
}
```


## `Delete Article`

Method: `DELETE`
URL: `localhost:3000/api/favorites/article/:id`
Note: __":id" correspond to the "Id" of a single JSON Article__
Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |

**Response Exemple**:

```json
{
    "status": 200,
    "msg": "Article Deleted !"
}
```


## `Delete Tag`

Method: `DELETE`
URL: `localhost:3000/api/favorites/tag/:id`
Note: __":id" correspond to the "Id" of a single JSON Tag__
Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |

**Response Exemple**:

```json
{
    "status": 200,
    "msg": "Tag Deleted !"
}
```


## `Fetch Tags`

Method: `GET`
URL: `localhost:3000/api/favorites/tags`
Note: __This request return all the available tags as well as all articles associated with a tag.__


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
{
    "Tags": [
        {
            "_id": "5ecfe794bb24e4e3b2abab95",
            "Id": 1,
            "Tag": "science",
            "__v": 0
        },
        {
            "_id": "5ecfe7c1b1b932e3c904819e",
            "Id": 2,
            "Tag": "culture",
            "__v": 0
        },
        {
            "_id": "5ed0013c390c2cf011f40307",
            "Id": 20,
            "Tag": "business",
            "__v": 0
        }
    ],
    "Articles": [
        {
            "Id": 0,
            "Tags": "Business",
            "Desc": "Facebook should be making its policy choices in fair and transparent ways. But is it?",
            "Title": "Facebook and Its Secret Policies",
            "Source": "The New York Times",
            "Link": "https://www.nytimes.com/2020/05/28/technology/facebook-polarization.html",
            "Author": "By Shira Ovide",
            "Date": "28/5/2020",
            "Image": "https://static01.nyt.com/images/2020/05/28/business/28ontech/28ontech-articleLarge.gif"
        },
        "..."
    ]
}
```

## `Fetch Articles`

Method: `GET`
URL: `localhost:3000/api/favorites/articles`


Authorization:

| Value    | Type |
|:------- | -------:|
| Bearer Token | authorization |
| token | string |


**Response Exemple**:

```json
[
    {
        "_id": "5ecfe3e8ccf9f0e219514d84",
        "Id": 5,
        "Tag": "culture",
        "Title": "beautiful discovery",
        "Link": "http://at.com",
        "Image": "http://zaeaz",
        "Desc": "Space Discovery",
        "Source": "New York Times",
        "Author": "Steve Kane",
        "Date": "01/02/2020",
        "__v": 0
    },
    "..."
]
```
=======
    "msg": "User added successfully !"
}
```
>>>>>>> master
