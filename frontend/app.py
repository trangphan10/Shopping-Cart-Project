from flask import Flask, render_template, send_from_directory
import os
import requests

BACKEND_HOST = "127.0.0.1" if os.environ.get("BACKEND_HOST") != "backend-service" else "backend-service"
print(BACKEND_HOST)
app = Flask(__name__, static_folder='static')


# Thư mục chứa các tệp hình ảnh
image_folder = "static/data/"

# Đường dẫn đến các tệp hình ảnh
@app.route('/data/<path:path>')
def send_image(path):
    return send_from_directory(image_folder, path)


@app.route('/index.html', methods=['GET'])
def index():
    return render_template('index.html', data_value = BACKEND_HOST)

@app.route('/', methods=['GET'])
def home():
    return render_template('index.html', data_value = BACKEND_HOST)

@app.route('/sub-pages/shop.html', methods=['GET'])
def shop():
    return render_template('/sub-pages/shop.html', data_value = BACKEND_HOST)

@app.route('/sub-pages/cart.html', methods=['GET'])
def cart():
    return render_template('/sub-pages/cart.html', data_value = BACKEND_HOST)

@app.route('/sub-pages/blog.html', methods=['GET'])
def blog():
    return render_template('/sub-pages/blog.html', data_value = BACKEND_HOST)

@app.route('/sub-pages/sign-in.html', methods=['GET'])
def sign_in():
    return render_template('/sub-pages/sign-in.html', data_value = str(BACKEND_HOST))

@app.route('/sub-pages/sign-up.html', methods=['GET'])
def sign_up():
    return render_template('/sub-pages/sign-up.html', data_value = str(BACKEND_HOST))

@app.route('/sub-pages/sproduct.html', methods=['GET'])
def sproduct():
    return render_template('/sub-pages/sproduct.html', data_value = BACKEND_HOST)


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port="5000")