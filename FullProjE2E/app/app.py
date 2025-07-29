# app/app.py

from flask import Flask

app = Flask(__name__)

@app.route('/hello')
def hello():
    """
    A simple endpoint that returns a greeting message.
    """
    return "Hello from The Full Proj! This is a basic web API running in a container."

if __name__ == '__main__':
    # Listen on all available network interfaces (0.0.0.0)
    # and on port 8000, which will be exposed by Docker.
    app.run(host='0.0.0.0', port=8000)