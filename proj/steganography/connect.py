from flask import Flask, request, jsonify, send_file
import cv2
import os
import base64
import numpy as np
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend
from flask_cors import CORS

app = Flask(__name__)
CORS(app)
UPLOAD_FOLDER = "uploads"
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# Generate AES key from password
def generate_key(password: str, salt: bytes) -> bytes:
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,
        salt=salt,
        iterations=100000,
        backend=default_backend()
    )
    return kdf.derive(password.encode())

# Encrypt message using AES
def encrypt_message(message: str, password: str) -> bytes:
    salt = os.urandom(16)
    key = generate_key(password, salt)
    iv = os.urandom(16)

    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    encryptor = cipher.encryptor()

    message_bytes = message.encode()
    pad_length = 16 - len(message_bytes) % 16
    message_bytes += bytes([pad_length]) * pad_length

    ciphertext = encryptor.update(message_bytes) + encryptor.finalize()
    return salt + iv + ciphertext

# Decrypt message using AES
def decrypt_message(encrypted_message: bytes, password: str) -> str:
    salt = encrypted_message[:16]
    iv = encrypted_message[16:32]
    ciphertext = encrypted_message[32:]

    key = generate_key(password, salt)
    cipher = Cipher(algorithms.AES(key), modes.CBC(iv), backend=default_backend())
    decryptor = cipher.decryptor()

    decrypted_bytes = decryptor.update(ciphertext) + decryptor.finalize()
    pad_length = decrypted_bytes[-1]
    return decrypted_bytes[:-pad_length].decode()

@app.route('/hide', methods=['POST'])
def hide_text():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400
    if 'message' not in request.form or 'password' not in request.form:
        return jsonify({'error': 'Missing message or password'}), 400

    image_file = request.files['image']
    message = request.form['message']
    password = request.form['password']
    image_path = os.path.join(UPLOAD_FOLDER, image_file.filename)
    image_file.save(image_path)

    try:
        encrypted_message = encrypt_message(message, password)
        encoded_message = base64.b64encode(encrypted_message).decode() + "@@END@@"

        img = cv2.imread(image_path)
        index = 0

        for char in encoded_message:
            if index >= img.shape[0] * img.shape[1]:
                return jsonify({'error': 'Message too large to hide in image'}), 400
            img[index // img.shape[1], index % img.shape[1], 0] = ord(char)
            index += 1

        output_path = os.path.join(UPLOAD_FOLDER, "stego_image.png")
        cv2.imwrite(output_path, img)

        return send_file(output_path, mimetype='image/png', as_attachment=True, download_name='stego_image.png')
    except Exception as e:
        return jsonify({'error': str(e)}), 500

@app.route('/extract', methods=['POST'])
def extract_text():
    if 'image' not in request.files:
        return jsonify({'error': 'No image uploaded'}), 400
    if 'password' not in request.form:
        return jsonify({'error': 'Missing password'}), 400

    image_file = request.files['image']
    password = request.form['password']
    image_path = os.path.join(UPLOAD_FOLDER, image_file.filename)
    image_file.save(image_path)

    try:
        img = cv2.imread(image_path)
        chars = []
        index = 0

        while index < img.shape[0] * img.shape[1]:
            char = chr(img[index // img.shape[1], index % img.shape[1], 0])
            chars.append(char)
            if ''.join(chars[-7:]) == "@@END@@":
                break
            index += 1

        if index >= img.shape[0] * img.shape[1]:
            return jsonify({'error': 'No hidden message found or message incomplete'}), 400

        encoded_message = ''.join(chars[:-7])
        encrypted_message = base64.b64decode(encoded_message)
        decrypted_message = decrypt_message(encrypted_message, password)

        return jsonify({'message': decrypted_message})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)
