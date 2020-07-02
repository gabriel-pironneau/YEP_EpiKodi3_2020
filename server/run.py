#! /usr/bin/env python
from services import app

app.config.from_object('config')
if __name__ == "__main__":
    app.run(debug=True, host='192.168.0.174' )
