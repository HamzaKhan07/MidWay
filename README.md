
# 🗺️📍 MidWay

MidWay a mobile app which helps the group of friends ✌️ which are planning 
to meet or join together the best place 🏕️ to meet which is nearest from all
friend's location or which is in the middle of their location 📍.

Star⭐ the repo if you like what you see😉.




![Logo](https://drive.google.com/uc?id=1Hqth10Xv0edwzackhtBi8IrCUQTwZPGF)

## 🎨 Color Reference

| Color             | Hex                                                                |
| ----------------- | ------------------------------------------------------------------ |
| Example Color | ![#000](https://via.placeholder.com/10/000a192f?text=+) #000 |
| Example Color | ![#FFF](https://via.placeholder.com/10/FFF?text=+) #FFF |

## 💡 Features

- Place Autosuggestion.
- Calculates midpoint from multiple locations.
- Draws route from all Source Places to Midpoint.
- Cross platform


## 📸 Screenshots

![App Screenshot](https://drive.google.com/uc?id=1TOdlZysEPV9dCnmnaeAWjA9emS6Utnsi)

![App Screenshot](https://drive.google.com/uc?id=1TdbKt3jsnl8iiBFLjVjd60xqTO9FzRS7)

![App Screenshot](https://drive.google.com/uc?id=18e-_HAo-4n4GtMLIsCmWGxO-xB9W8-2I)

![App Screenshot](https://drive.google.com/uc?id=1akKXcYjrIF-dcTVGCAMH35DZna1xpb-l)

![App Screenshot](https://drive.google.com/uc?id=1ZNLAlqv4xjnGqlJ74Qtr2N-z6QlT3gMY)

## 📡 API Reference

#### 🗺️ Get Place Suggestions based on geographical coordinates.

```http
  GET https://autosuggest.search.hereapi.com/v1/autosuggest?at=
  $lat,$long&limit=limit&lang=en&q=$pattern&apiKey=api_key
```

| Parameter | Type     | Description                |
| :-------- | :------- | :------------------------- |
| `api_key` | `string` | **Required**. Your API key |
| `lat` | `string` | **Required**. Latitute |
| `long` | `string` | **Required**. Longitute |
| `limit` | `string` | **Required**. Suggestions to fetch per character typed.|

#### 📍 Get Routes between two geographical coordinates

```http
  GET 'https://api.openrouteservice.org/v2/directions/travelling_mode?
  api_key=api_key&start=$startLong,$startLat&end=$endLong,$endLat');
      
```

| Parameter | Type     | Description                       |
| :-------- | :------- | :-------------------------------- |
| `api_key`      | `string` | **Required**. Id of item to fetch |
| `travelling_mode`      | `string` | **Required**. such as driving-car, walk, bike, etc |
| `startLong`      | `string` | **Required**. Source Longitute |
| `startLat`      | `string` | **Required**. Source Latitute |
| `endLong`      | `string` | **Required**. Destination Source Longitute |
| `endLat`      | `string` | **Required**. Destination Latitute |


## 💻 Tech Stack

Flutter and Dart



## ⚙️ Installation

Install "MidWay" from the below link:

```web
  shorturl.at/suLQ1
```
    
## ✍️ Authors

- [@HamzaKhan07](https://www.github.com/hamzakhan48208)

