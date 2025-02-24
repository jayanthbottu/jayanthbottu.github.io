from flask import Flask, request, jsonify, send_file
from flask_cors import CORS  # Allow frontend to communicate with backend
import cv2
import os
import base64
import numpy as np
from cryptography.hazmat.primitives.ciphers import Cipher, algorithms, modes
from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.primitives import hashes
from cryptography.hazmat.backends import default_backend

app = Flask(__name__)
CORS(app)  # Enable CORS to allow frontend requests

UPLOAD_FOLDER = "uploads"
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

# AES Encryption Helper Functions
def generate_key(password: str, salt: bytes) -> bytes:
    kdf = PBKDF2HMAC(
        algorithm=hashes.SHA256(),
        length=32,
        salt=salt,
        iterations=100000,
        backend=default_backend()
    )
    return kdf.derive(password.encode())

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
@app.route('/hide', methods=['POST'])
def hide_text():
    try:
        print("Received a request to hide text.")
        if 'image' not in request.files or 'message' not in request.form or 'password' not in request.form:
            print("Missing required fields")
            return jsonify({'error': 'Missing required fields'}), 400

        image_file = request.files['image']
        message = request.form['message']
        password = request.form['password']

        print(f"Processing image: {image_file.filename}")
        print(f"Message length: {len(message)}")
        
        # Read image
        nparr = np.frombuffer(image_file.read(), np.uint8)
        image = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        if image is None:
            print("Error decoding image")
            return jsonify({'error': 'Invalid image file'}), 400

        # Encryption process
        encrypted_message = encrypt_message(message, password)
        
        # Embed the encrypted message in the image
        stego_image = embed_message(image, encrypted_message)
        
        if stego_image is None:
            print("Error embedding message")
            return jsonify({'error': 'Error embedding message'}), 500
        
        # Save and return image
        output_path = "stego_image.png"
        cv2.imwrite(output_path, stego_image)
        print("Image saved successfully.")

        return send_file(output_path, mimetype='image/png')

    except Exception as e:
        print(f"Error: {str(e)}")  # Log the error in the Render logs
        return jsonify({'error': str(e)}), 500

@app.route('/extract', methods=['POST'])
def extract_text():
    try:
        image_file = request.files['image']
        password = request.form['password']

        if not image_file or not password:
            return jsonify({"error": "Missing data"}), 400

        filename = os.path.join(UPLOAD_FOLDER, "extract.png")
        image_file.save(filename)

        img = cv2.imread(filename)
        chars = []
        index = 0

        while index < img.shape[0] * img.shape[1]:
            char = chr(img[index // img.shape[1], index % img.shape[1], 0])
            chars.append(char)
            if ''.join(chars[-7:]) == "@@END@@":
                break
            index += 1

        if index >= img.shape[0] * img.shape[1]:
            return jsonify({"error": "No hidden message found"}), 400

        encoded_message = ''.join(chars[:-7])
        encrypted_message = base64.b64decode(encoded_message)
        decrypted_message = decrypt_message(encrypted_message, password)

        return jsonify({"message": decrypted_message})

    except Exception as e:
        return jsonify({"error": str(e)}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
