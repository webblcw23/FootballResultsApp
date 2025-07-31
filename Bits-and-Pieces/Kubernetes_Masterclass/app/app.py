# Python file to run a simple 'flask' application. This will be used for the Docker and Kubernetes demo.

from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
    return 'Hello, World! This is a simple Flask application running in a Docker container. We will use this for Kubernetes demo.'

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)