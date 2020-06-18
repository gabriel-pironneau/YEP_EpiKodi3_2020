import os
from flask import Flask, make_response, request, redirect, url_for, send_from_directory
from werkzeug.utils import secure_filename

UPLOAD_FOLDER = './uploads'
ALLOWED_EXTENSIONS = { 'png', 'jpg', 'mp3' } #to change for music files

app = Flask(__name__)
app.config['UPLOAD_FOLDER'] = os.path.join(os.getcwd(), "file_transfer/uploads")

print(os.getcwd())

def allowed_file(filename):
    return '.' in filename and filename.rsplit('.', 1)[1].lower() in ALLOWED_EXTENSIONS

@app.route('/file/<filename>', methods = ['GET'])
def file_download(filename):
    return send_from_directory(app.config['UPLOAD_FOLDER'], filename, as_attachment=True)

@app.route('/file', methods = ['POST'])
def file_upload():
    if 'file' not in request.files:
        return "ERROR : No file part", 404
    file = request.files['file']
    if file.filename == '':
        return "ERROR : No selected file", 401
    if file and allowed_file(file.filename):
        filename = secure_filename(file.filename)
        file.save(os.path.join(app.config['UPLOAD_FOLDER'], filename))
        return "File Successfully Uploaded"
    #request.files

@app.route('/file/<filename>', methods = ['DELETE'])
def delete_items(filename):
    os.remove(os.path.join(app.config['UPLOAD_FOLDER'], filename))
    return "File Successfully Deleted"

@app.errorhandler(401)
@app.errorhandler(404)
@app.errorhandler(500)
def ma_page_erreur(error):
    return "Error {}".format(error.code), error.code

if __name__ == "__main__":
    app.run()
